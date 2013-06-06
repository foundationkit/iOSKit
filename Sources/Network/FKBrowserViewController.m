#import "FKBrowserViewController.h"
#import "FKShorthands.h"
#import "UIViewController+FKLoading.h"
#import "UIWebView+FKAdditions.h"
#import "UIView+FKAdditions.h"
#import "UIView+FKAnimations.h"
#import "FKiOSMetrics.h"
#import "UIBarButtonItem+FKConcise.h"
#import "UIInterfaceOrientation+FKAdditions.h"
#import "FKNetworkActivityManager.h"
#import "FKInterApp.h"
#import "UIButton+FKConcise.h"
#import <MessageUI/MessageUI.h>

#define kFKBrowserFixedSpaceItemWidth      12.f
#define kFKBrowserDefaultTintColor         nil
#define kFKBrowserDefaultBackgroundColor   [UIColor scrollViewTexturedBackgroundColor]
#define kFKCustomActionTitle               @"kFKCustomActionTitle"
#define kFKCustomActionBlock               @"kFKCustomActionBlock"


@interface FKBrowserViewController () <UIWebViewDelegate, UIActionSheetDelegate, MFMailComposeViewControllerDelegate>

@property (nonatomic, strong, readwrite) UIToolbar *toolbar;
@property (nonatomic, strong, readwrite) UIWebView *webView;

@property (nonatomic, strong) UIBarButtonItem *backItem;
@property (nonatomic, strong) UIBarButtonItem *forwardItem;
@property (nonatomic, strong) UIBarButtonItem *loadItem;
@property (nonatomic, strong) UIBarButtonItem *actionItem;

@property (nonatomic, strong) UIActionSheet *actionSheet;

@property (nonatomic, strong) NSMutableArray *customActions;

@property (nonatomic, readonly) BOOL hasToolbar;


@end


@implementation FKBrowserViewController

////////////////////////////////////////////////////////////////////////
#pragma mark - Lifecycle
////////////////////////////////////////////////////////////////////////

+ (id)browserWithAddress:(NSString *)address {
    return [[[self class] alloc] initWithAddress:address];
}

+ (id)modalBrowserWithAddress:(NSString *)address {
    FKBrowserViewController *viewController = [self browserWithAddress:address];
    viewController.presentedModally = YES;

    return viewController;
}

- (id)initWithAddress:(NSString *)address {
    if ((self = [super initWithNibName:nil bundle:nil])) {
        _fadeAnimationEnabled = YES;
        _tintColor = kFKBrowserDefaultTintColor;
        _backgroundColor = kFKBrowserDefaultBackgroundColor;

        // Initialize toolbar here to make it customizable before view is created
        if (self.hasToolbar) {
            _toolbar = [[UIToolbar alloc] initWithFrame:CGRectZero];
        }

        [self updateAddress:address];
    }

    return self;
}

- (id)initWithURL:(NSURL *)url {
    return [self initWithAddress:[url absoluteString]];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    return [self initWithAddress:nil];
}

- (void)dealloc {
    self.webView.delegate = nil;
}

////////////////////////////////////////////////////////////////////////
#pragma mark - UIViewController
////////////////////////////////////////////////////////////////////////

- (void)viewDidLoad {
	[super viewDidLoad];

    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.boundsWidth, 0.f)];
	self.webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.webView.delegate = self;
    [self.view addSubview:self.webView];

    if (self.hasToolbar) {
        self.toolbar.frameWidth = self.view.boundsWidth;
        self.toolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        [self.view addSubview:self.toolbar];
    }

    if (self.fadeAnimationEnabled) {
        self.webView.alpha = 0.f;
    }

    [self layoutForOrientation:$appOrientation];
    [self customize];
	[self reload];
}

- (void)viewDidUnload {
    [super viewDidUnload];

    self.webView.delegate = nil;
	self.webView = nil;
    self.toolbar = nil;
	self.backItem = nil;
	self.forwardItem = nil;
	self.loadItem = nil;
	self.actionItem = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

	[self updateUI];
}

- (void)viewWillDisappear:(BOOL)animated {
	[self stopLoading];
    [self.actionSheet dismissWithClickedButtonIndex:-1 animated:NO];

	[super viewWillDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	return FKRotateToAllSupportedOrientations(toInterfaceOrientation);
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];

    [self layoutForOrientation:toInterfaceOrientation];
}

////////////////////////////////////////////////////////////////////////
#pragma mark - FKBrowserViewController
////////////////////////////////////////////////////////////////////////

- (void)reload {
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
}

- (void)stopLoading {
    [self.webView stopLoading];
}

- (void)addActionWithTitle:(NSString *)title block:(dispatch_block_t)block {
    if (self.customActions == nil) {
        self.customActions = [NSMutableArray array];
    }

    NSDictionary *action = @{kFKCustomActionTitle : title, kFKCustomActionBlock: [block copy]};
    [self.customActions addObject:action];
}

- (NSString *)stringByEvaluatingJavaScriptFromString:(NSString *)command {
    return [self.webView stringByEvaluatingJavaScriptFromString:command];
}

////////////////////////////////////////////////////////////////////////
#pragma mark - Setter
////////////////////////////////////////////////////////////////////////

- (void)setAddress:(NSString *)address {
    if (address != _address) {
        [self updateAddress:address];
        [self reload];
    }
}

- (void)setUrl:(NSURL *)url {
    if (url != _url) {
        [self updateAddress:[url absoluteString]];
        [self reload];
    }
}

- (void)setTintColor:(UIColor *)tintColor {
    if (tintColor != _tintColor) {
        _tintColor = tintColor;
        [self customize];
    }
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    if (backgroundColor != _backgroundColor) {
        _backgroundColor = backgroundColor;
        [self customize];
    }
}

- (void)setPresentedModally:(BOOL)presentedModally {
    if (presentedModally != _presentedModally) {
        _presentedModally = presentedModally;

        if (presentedModally) {
            UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                      target:self
                                                                                      action:@selector(handleDoneButtonPress:)];
            self.navigationItem.leftBarButtonItem = doneItem;
        } else {
            self.navigationItem.leftBarButtonItem = nil;
        }
    }
}

- (void)setToolbarHidden:(BOOL)toolbarHidden {
    self.toolbar.hidden = toolbarHidden;
    [self layoutForOrientation:$appOrientation];
}

- (BOOL)toolbarHidden {
    return self.toolbar.hidden;
}

////////////////////////////////////////////////////////////////////////
#pragma mark - Getter
////////////////////////////////////////////////////////////////////////

- (UIBarButtonItem *)backItem {
    if (_backItem == nil) {
        UIButton *button = [UIButton buttonWithImageNamed:@"iOSKit.bundle/browserBack"];
        [button addTarget:self.webView action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];

        _backItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }

    _backItem.enabled = self.webView.canGoBack;

    return _backItem;
}

- (UIBarButtonItem *)forwardItem {
    if (_forwardItem == nil) {
        UIButton *button = [UIButton buttonWithImageNamed:@"iOSKit.bundle/browserForward"];
        [button addTarget:self.webView action:@selector(goForward) forControlEvents:UIControlEventTouchUpInside];

        _forwardItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }

    _forwardItem.enabled = self.webView.canGoForward;

    return _forwardItem;
}

- (UIBarButtonItem *)actionItem {
    if (_actionItem == nil) {
        UIButton *button = [UIButton buttonWithImageNamed:@"iOSKit.bundle/browserAction"];
        [button addTarget:self action:@selector(showActionSheet) forControlEvents:UIControlEventTouchUpInside];

        _actionItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }

    return _actionItem;
}

////////////////////////////////////////////////////////////////////////
#pragma mark - UIWebViewDelegate
////////////////////////////////////////////////////////////////////////

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    [self updateAddress:request.URL.absoluteString];

    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self showLoadingIndicatorInNavigationBar];
    [FKNetworkActivityManager addNetworkUser:self];

    [self updateUI];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if (self.fadeAnimationEnabled) {
        [self.webView fadeIn];
    }

    [self hideLoadingIndicator];
    [FKNetworkActivityManager removeNetworkUser:self];

    [self updateUI];

    if (self.didFinishLoadBlock != nil) {
        self.didFinishLoadBlock(self);
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self hideLoadingIndicator];
    [FKNetworkActivityManager removeNetworkUser:self];

    [self updateUI];

    if (self.didFailToLoadBlock != nil) {
        self.didFailToLoadBlock(self,error);
    }
}

////////////////////////////////////////////////////////////////////////
#pragma mark - UIActionSheetDelegate
////////////////////////////////////////////////////////////////////////

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSInteger customActionsBeginIndex = [MFMailComposeViewController canSendMail] ? 2 : 1;

    if (buttonIndex == 0) {
        FKInterAppOpenSafari(self.url);
    } else if (buttonIndex == 1 && [MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *composer = [[MFMailComposeViewController alloc] init];

        composer.navigationBar.tintColor = self.tintColor;
        [composer setMailComposeDelegate:self];
        [composer setMessageBody:self.address isHTML:NO];

        if (composer != nil) {
            [self presentModalViewController:composer animated:YES];
        }
    } else if (buttonIndex == actionSheet.cancelButtonIndex) {
        // do nothing special
    } else if (buttonIndex >= customActionsBeginIndex) {
        NSDictionary *action = [self.customActions objectAtIndex:(NSUInteger)(buttonIndex - customActionsBeginIndex)];
        dispatch_block_t block = [action valueForKey:kFKCustomActionBlock];

        if (block != nil) {
            block();
        }
    }
}

////////////////////////////////////////////////////////////////////////
#pragma mark - MFMailComposeViewControllerDelegate
////////////////////////////////////////////////////////////////////////

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [controller dismissModalViewControllerAnimated:YES];
}

////////////////////////////////////////////////////////////////////////
#pragma mark - Private
////////////////////////////////////////////////////////////////////////

- (void)updateAddress:(NSString *)address {
    [self willChangeValueForKey:@"address"];
    _address = address;
    [self didChangeValueForKey:@"address"];

    [self willChangeValueForKey:@"url"];
    _url = [NSURL URLWithString:address];
    [self didChangeValueForKey:@"url"];
}

- (void)updateUI {
    if (self.webView.loading) {
        self.title = _(@"Loading...");

        UIButton *button = [UIButton buttonWithImageNamed:@"iOSKit.bundle/browserStop"];
        [button addTarget:self action:@selector(stopLoading) forControlEvents:UIControlEventTouchUpInside];

        self.loadItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    } else {
        if (self.titleToDisplay != nil) {
            self.title = self.titleToDisplay;
        } else {
            self.title = self.webView.documentTitle;
        }

        UIButton *button = [UIButton buttonWithImageNamed:@"iOSKit.bundle/browserRefresh"];
        [button addTarget:self action:@selector(reload) forControlEvents:UIControlEventTouchUpInside];

        self.loadItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        self.loadItem.enabled = ![self.address isEqualToString:@"about:blank"];
    }

    UIBarButtonItem *fixedSpaceItem = [UIBarButtonItem spaceItemWithWidth:kFKBrowserFixedSpaceItemWidth];
    UIBarButtonItem *flexibleSpaceItem = [UIBarButtonItem flexibleSpaceItem];

    BOOL showItems = ![self.address isEqualToString:@"about:blank"] || self.customActions.count > 0;

    if (showItems) {
        if (self.hasToolbar) {
            NSMutableArray *items = [NSMutableArray arrayWithArray:@[fixedSpaceItem, self.backItem, flexibleSpaceItem, self.forwardItem, flexibleSpaceItem, self.loadItem, flexibleSpaceItem]];
            [items addObject:self.actionItem];
            [items addObject:fixedSpaceItem];
            self.toolbar.items = items;
        } else {
            UIBarButtonItem *widerFixedSpaceItem = [UIBarButtonItem spaceItemWithWidth:35.f];
            NSMutableArray *items = [NSMutableArray arrayWithArray:@[self.loadItem, widerFixedSpaceItem,
                                     self.forwardItem, widerFixedSpaceItem,
                                     self.backItem, fixedSpaceItem]];

            [items insertObject:widerFixedSpaceItem atIndex:0];
            [items insertObject:self.actionItem atIndex:0];

            [self.navigationItem setRightBarButtonItems:items];
        }
    } else {
        if (self.hasToolbar) {
            self.toolbar.items = nil;
        } else {
            self.navigationItem.rightBarButtonItems = nil;
        }
    }
}

- (void)layoutForOrientation:(UIInterfaceOrientation)orientation {
    CGFloat toolbarHeight = (self.toolbarHidden || !self.hasToolbar) ? 0.f : FKToolbarHeightForOrientation(orientation);

    self.webView.frameHeight = self.view.boundsHeight - toolbarHeight;
    self.toolbar.frameTop = self.webView.frameBottom;
    self.toolbar.frameHeight = toolbarHeight;
}

- (void)customize {
    self.view.backgroundColor = self.backgroundColor;
    self.webView.scalesPageToFit = YES;
    self.navigationController.navigationBar.tintColor = self.tintColor;
    self.toolbar.tintColor = self.tintColor;
}

- (void)showActionSheet {
    NSString *actionSheetTitle = self.address;

    actionSheetTitle = [actionSheetTitle stringByReplacingOccurrencesOfString:@"(^http://)|(/$)"
                                                                   withString:@""
                                                                      options:NSRegularExpressionSearch
                                                                        range:NSMakeRange(0, actionSheetTitle.length)];

    [self.actionSheet dismissWithClickedButtonIndex:-1 animated:NO];
    self.actionSheet = [[UIActionSheet alloc] initWithTitle:actionSheetTitle
                                                   delegate:self
                                          cancelButtonTitle:nil
                                     destructiveButtonTitle:nil
                                          otherButtonTitles:nil];

    [self.actionSheet addButtonWithTitle:_(@"Open in Safari")];

    if ([MFMailComposeViewController canSendMail]) {
        [self.actionSheet addButtonWithTitle:_(@"Mail Link")];
    }

    for (NSDictionary *action in self.customActions) {
        [self.actionSheet addButtonWithTitle:[action valueForKey:kFKCustomActionTitle]];
    }

    [self.actionSheet addButtonWithTitle:_(@"Cancel")];
    [self.actionSheet setCancelButtonIndex:self.actionSheet.numberOfButtons - 1];

    [self.actionSheet showFromBarButtonItem:self.actionItem animated:YES];
}

- (void)handleDoneButtonPress:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (BOOL)hasToolbar {
    // we don't need a toolbar on iOS 5/iPad because we put the items in the navigationBar
    return $isPhone() || ![UINavigationItem instancesRespondToSelector:@selector(setRightBarButtonItems:)];
}

@end