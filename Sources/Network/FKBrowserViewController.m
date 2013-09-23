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
#define kFKCustomActionDestructive         @"kFKCustomActionDestructive"


@interface FKBrowserViewController () <UIActionSheetDelegate, MFMailComposeViewControllerDelegate>

@property (nonatomic, strong, readwrite) UIToolbar *toolbar;
@property (nonatomic, strong, readwrite) UIWebView *webView;

@property (nonatomic, readwrite) UIBarButtonItem *backItem;
@property (nonatomic, readwrite) UIBarButtonItem *forwardItem;
@property (nonatomic, readwrite) UIBarButtonItem *loadItem;
@property (nonatomic, readwrite) UIBarButtonItem *actionItem;
@property (nonatomic, readwrite) UIActionSheet *actionSheet;

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
    if (address != nil && ![address hasPrefix:@"http"]) {
        address = [@"http://" stringByAppendingString:address];
    }

    return [self initWithURL:[NSURL URLWithString:address]];
}

- (id)initWithURL:(NSURL *)url {
    if ((self = [super initWithNibName:nil bundle:nil])) {
        _fadeAnimationEnabled = YES;
        _tintColor = kFKBrowserDefaultTintColor;
        _backgroundColor = kFKBrowserDefaultBackgroundColor;

        // Initialize toolbar here to make it customizable before view is created
        _toolbar = [[UIToolbar alloc] initWithFrame:CGRectZero];
        _toolbar.hidden = !self.hasToolbar;

        _url = url;
        _address = url.absoluteString;
    }

    return self;
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

    self.toolbar.frameWidth = self.view.boundsWidth;
    self.toolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [self.view addSubview:self.toolbar];

    if (self.fadeAnimationEnabled) {
        self.webView.alpha = 0.f;
    }

    [self layoutForOrientation:$appOrientation];
    [self customize];
	[self reload];
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
    [self addActionWithTitle:title block:block destructive:NO];
}

- (void)addDestructiveActionWithTitle:(NSString *)title block:(dispatch_block_t)block {
    [self addActionWithTitle:title block:block destructive:YES];
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
        UIImage *image = nil;
        if ([UIView instancesRespondToSelector:@selector(tintColor)]) {
            image = [[UIImage imageNamed:@"iOSKit.bundle/browser-back"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        } else {
            image = [UIImage imageNamed:@"iOSKit.bundle/browser-back-legacy"];
        }

        UIButton *button = [UIButton fkit_buttonWithImage:image];
        [button addTarget:self.webView action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];

        _backItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }

    _backItem.enabled = self.webView.canGoBack;

    return _backItem;
}

- (UIBarButtonItem *)forwardItem {
    if (_forwardItem == nil) {
        UIImage *image = nil;
        if ([UIView instancesRespondToSelector:@selector(tintColor)]) {
            image = [[UIImage imageNamed:@"iOSKit.bundle/browser-forward"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        } else {
            image = [UIImage imageNamed:@"iOSKit.bundle/browser-forward-legacy"];
        }

        UIButton *button = [UIButton fkit_buttonWithImage:image];
        [button addTarget:self.webView action:@selector(goForward) forControlEvents:UIControlEventTouchUpInside];

        _forwardItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }

    _forwardItem.enabled = self.webView.canGoForward;

    return _forwardItem;
}

- (UIBarButtonItem *)actionItem {
    if (_actionItem == nil) {
        if ([UIView instancesRespondToSelector:@selector(tintColor)]) {
            _actionItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(showActionSheet)];
        } else {
            UIButton *button = [UIButton fkit_buttonWithImageNamed:@"iOSKit.bundle/browser-action"];
            [button addTarget:self action:@selector(showActionSheet) forControlEvents:UIControlEventTouchUpInside];
            _actionItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        }
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
    [self fkit_showLoadingIndicatorInNavigationBar];
    [FKNetworkActivityManager addNetworkUser:self];

    [self updateUI];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if (self.fadeAnimationEnabled) {
        [self.webView fkit_fadeIn];
    }

    [self fkit_hideLoadingIndicator];
    [FKNetworkActivityManager removeNetworkUser:self];

    [self updateUI];

    if (self.didFinishLoadBlock != nil) {
        self.didFinishLoadBlock(self);
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self fkit_hideLoadingIndicator];
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
    NSInteger customActionsBeginIndex =  0;
    if ([self hasValidAddress]) {
        customActionsBeginIndex += 2; // copy link, safari
        if (FKInterAppChromeIsInstalled()) {
            customActionsBeginIndex++;
        }
        if ([MFMailComposeViewController canSendMail]) {
            customActionsBeginIndex++;
        }
    }

    if (buttonIndex == actionSheet.cancelButtonIndex) {
        // do nothing special
    } else if (buttonIndex >= customActionsBeginIndex) {
        NSDictionary *action = [self.customActions objectAtIndex:(NSUInteger)(buttonIndex - customActionsBeginIndex)];
        dispatch_block_t block = [action valueForKey:kFKCustomActionBlock];

        if (block != nil) {
            block();
        }
    } else if (buttonIndex == 0) {
        [UIPasteboard generalPasteboard].string = self.address;
    } else if (buttonIndex == 1) {
        FKInterAppOpenSafari(self.url);
    } else if (buttonIndex == 2 && FKInterAppChromeIsInstalled()) {
        FKInterAppOpenChrome(self.url);
    } else if ((buttonIndex == 2 && !FKInterAppChromeIsInstalled() && [MFMailComposeViewController canSendMail]) ||
               (buttonIndex == 3 && FKInterAppChromeIsInstalled() && [MFMailComposeViewController canSendMail])) {
        MFMailComposeViewController *composer = [[MFMailComposeViewController alloc] init];

        composer.navigationBar.tintColor = self.tintColor;
        [composer setMailComposeDelegate:self];
        [composer setMessageBody:self.address isHTML:NO];
        if (composer != nil) {
            [self presentModalViewController:composer animated:YES];
        }
    }

    self.actionSheet = nil;
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
        self.title = _(@"Loading…");

        UIImage *image = nil;
        if ([UIView instancesRespondToSelector:@selector(tintColor)]) {
            image = [[UIImage imageNamed:@"iOSKit.bundle/browser-cancel"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        } else {
            image = [UIImage imageNamed:@"iOSKit.bundle/browser-cancel-legacy"];
        }

        UIButton *button = [UIButton fkit_buttonWithImage:image];
        [button addTarget:self action:@selector(stopLoading) forControlEvents:UIControlEventTouchUpInside];

        self.loadItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    } else {
        if (self.titleToDisplay != nil) {
            self.title = self.titleToDisplay;
        } else {
            self.title = self.webView.fkit_documentTitle;
        }

        UIImage *image = nil;
        if ([UIView instancesRespondToSelector:@selector(tintColor)]) {
            image = [[UIImage imageNamed:@"iOSKit.bundle/browser-reload"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        } else {
            image = [UIImage imageNamed:@"iOSKit.bundle/browser-reload-legacy"];
        }

        UIButton *button = [UIButton fkit_buttonWithImage:image];
        [button addTarget:self action:@selector(reload) forControlEvents:UIControlEventTouchUpInside];

        self.loadItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        self.loadItem.enabled = [self hasValidAddress];
    }

    UIBarButtonItem *fixedSpaceItem = [UIBarButtonItem fkit_spaceItemWithWidth:kFKBrowserFixedSpaceItemWidth];
    UIBarButtonItem *flexibleSpaceItem = [UIBarButtonItem fkit_flexibleSpaceItem];

    BOOL showBrowserItems = [self hasValidAddress];
    BOOL showActionItem = showBrowserItems || self.customActions.count > 0;
    NSMutableArray *items = [NSMutableArray new];

    if (self.hasToolbar) {
        if (showBrowserItems) {
            [items addObjectsFromArray:@[fixedSpaceItem, self.backItem, flexibleSpaceItem, self.forwardItem, flexibleSpaceItem, self.loadItem, flexibleSpaceItem]];
        }

        if (showActionItem) {
            [items addObject:self.actionItem];
            [items addObject:fixedSpaceItem];
        }
        self.toolbar.items = items;
    } else {
        UIBarButtonItem *widerFixedSpaceItem = [UIBarButtonItem fkit_spaceItemWithWidth:35.f];

        if (showBrowserItems) {
            [items addObjectsFromArray:@[self.loadItem, widerFixedSpaceItem, self.forwardItem, widerFixedSpaceItem, self.backItem, fixedSpaceItem]];
        }

        if (showActionItem) {
            [items insertObject:widerFixedSpaceItem atIndex:0];
            [items insertObject:self.actionItem atIndex:0];
        }

        [self.navigationItem setRightBarButtonItems:items];
    }
}

- (void)layoutForOrientation:(UIInterfaceOrientation)orientation {
    CGFloat toolbarHeight = self.toolbarHidden ? 0.f : FKBarHeightForOrientation(orientation);

    self.webView.frameHeight = self.view.boundsHeight - toolbarHeight;
    self.toolbar.frameTop = self.webView.frameBottom;
    self.toolbar.frameHeight = toolbarHeight;
}

- (void)customize {
    self.view.backgroundColor = self.backgroundColor;
    self.webView.scalesPageToFit = YES;

    if ([UIToolbar instancesRespondToSelector:@selector(setBarTintColor:)]) {
        self.navigationController.navigationBar.barTintColor = self.tintColor;
        self.toolbar.barTintColor = self.tintColor;
    } else {
        self.navigationController.navigationBar.tintColor = self.tintColor;
        self.toolbar.tintColor = self.tintColor;
    }
}

- (void)showActionSheet {
    NSString *actionSheetTitle = nil;

    if ([self hasValidAddress]) {
        actionSheetTitle = [self.address stringByReplacingOccurrencesOfString:@"(^http://)|(/$)"
                                                                   withString:@""
                                                                      options:NSRegularExpressionSearch
                                                                        range:NSMakeRange(0, actionSheetTitle.length)];
    }

    [self.actionSheet dismissWithClickedButtonIndex:-1 animated:NO];
    self.actionSheet = [[UIActionSheet alloc] initWithTitle:actionSheetTitle
                                                   delegate:self
                                          cancelButtonTitle:nil
                                     destructiveButtonTitle:nil
                                          otherButtonTitles:nil];

    if ([self hasValidAddress]) {
        [self.actionSheet addButtonWithTitle:_(@"Copy Link")];
        [self.actionSheet addButtonWithTitle:_(@"Open in Safari")];
        if (FKInterAppChromeIsInstalled()) {
            [self.actionSheet addButtonWithTitle:_(@"Open in Chrome")];
        }

        if ([MFMailComposeViewController canSendMail]) {
            [self.actionSheet addButtonWithTitle:_(@"Mail Link")];
        }
    }

    for (NSDictionary *action in self.customActions) {
        [self.actionSheet addButtonWithTitle:[action valueForKey:kFKCustomActionTitle]];

        BOOL destructiveAction = [action[kFKCustomActionDestructive] boolValue];
        if (destructiveAction) {
            self.actionSheet.destructiveButtonIndex = self.actionSheet.numberOfButtons - 1;
        }
    }

    [self.actionSheet addButtonWithTitle:_(@"Cancel")];
    [self.actionSheet setCancelButtonIndex:self.actionSheet.numberOfButtons - 1];

    [self.actionSheet showFromBarButtonItem:self.actionItem animated:YES];
}

- (void)addActionWithTitle:(NSString *)title block:(dispatch_block_t)block destructive:(BOOL)destructive {
    if (self.customActions == nil) {
        self.customActions = [NSMutableArray array];
    }

    NSDictionary *action = @{kFKCustomActionTitle : title, kFKCustomActionBlock: [block copy], kFKCustomActionDestructive : @(destructive)};
    [self.customActions addObject:action];
}

- (void)handleDoneButtonPress:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (BOOL)hasToolbar {
    // we don't need a toolbar on iOS 5/iPad because we put the items in the navigationBar
    return $isPhone() || ![UINavigationItem instancesRespondToSelector:@selector(setRightBarButtonItems:)];
}

- (BOOL)hasValidAddress {
    return ![self.address isEqualToString:@"about:blank"] && ![self.url isFileURL];
}

@end