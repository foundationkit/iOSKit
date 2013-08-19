#import "UIViewController+FKLoading.h"
#import "NSObject+FKReflection.h"


FKLoadCategory(UIViewControllerFKLoading);

#define kFKActivityViewMaxSize      37.f


static char activityViewKey;
static char replacedObjectKey;

static CGRect FKCenteredSquareInRectConstrainedToSize(CGRect rect, CGFloat size);
static UIBarButtonItem* FKBarButtonItemWithActivityView(UIActivityIndicatorView *activityView);


@interface UIViewController ()

@property (nonatomic, strong, readwrite) UIActivityIndicatorView *activityView;
@property (nonatomic, strong) id fk_replacedObject;

@end


@implementation UIViewController (FKLoading)

- (void)setActivityView:(UIActivityIndicatorView *)activityView {
    [self associateValue:activityView withKey:&activityViewKey];
}

- (UIActivityIndicatorView *)activityView {
    UIActivityIndicatorView *activityView = (UIActivityIndicatorView *)[self associatedValueForKey:&activityViewKey];
    
    // create activityView when it is first read
    if (activityView == nil) {
        activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        self.activityView = activityView;
    }
    
    return activityView;
}

- (void)setFk_replacedObject:(id)replacedObject {
    [self associateValue:replacedObject withKey:&replacedObjectKey];
}

- (id)fk_replacedObject {
    return [self associatedValueForKey:&replacedObjectKey];
}

- (void)showCenteredLoadingIndicator {
    UIViewAutoresizing autoresizingMask = (UIViewAutoresizingFlexibleTopMargin |
                                           UIViewAutoresizingFlexibleRightMargin |
                                           UIViewAutoresizingFlexibleBottomMargin | 
                                           UIViewAutoresizingFlexibleLeftMargin);
    
    [self showLoadingIndicatorAtPoint:CGPointMake(self.view.bounds.size.width/2.f, self.view.bounds.size.height/2.f) 
                     autoresizingMask:autoresizingMask];
   
}

- (void)showLoadingIndicatorAtPoint:(CGPoint)center autoresizingMask:(UIViewAutoresizing)autoresizingMask {
    [self hideLoadingIndicator];
    
    UIActivityIndicatorView *activityView = self.activityView;
    
    activityView.center = center;
    activityView.frame = CGRectIntegral(activityView.frame);
    activityView.autoresizingMask = autoresizingMask;
    
    [self.view addSubview:activityView];
    [activityView startAnimating]; 
}

- (void)showLoadingIndicatorInsteadOfView:(UIView *)viewToReplace {
    [self hideLoadingIndicator];
    
    UIActivityIndicatorView *activityView = self.activityView;
    
    // TODO: Resizing currently seems broken in iOS 5, we maybe have to roll our own activityIndicatorView
    activityView.frame = FKCenteredSquareInRectConstrainedToSize(viewToReplace.frame, kFKActivityViewMaxSize);
    activityView.autoresizingMask = viewToReplace.autoresizingMask;

    FKAssert(viewToReplace.metaData == nil, @"View MetaData is already set, will loose it");
    viewToReplace.metaData = @(viewToReplace.hidden);
    viewToReplace.hidden = YES;
    self.fk_replacedObject = viewToReplace;
    
    [viewToReplace.superview addSubview:activityView];
    [activityView startAnimating];
}

- (void)showLoadingIndicatorOnTopOfView:(UIView *)view {
    [self hideLoadingIndicator];
    
    UIActivityIndicatorView *activityView = self.activityView;
    
    activityView.frame = FKCenteredSquareInRectConstrainedToSize(view.frame, kFKActivityViewMaxSize);
    activityView.autoresizingMask = view.autoresizingMask;
    
    [view.superview addSubview:activityView];
    [activityView startAnimating];
}

- (void)showLoadingIndicatorInNavigationBar {
    [self hideLoadingIndicator];
    
    UIActivityIndicatorView *activityView = self.activityView;
    UIBarButtonItem *barButtonItemToReplace = self.navigationItem.rightBarButtonItem;
    UIBarButtonItem *activityItem = FKBarButtonItemWithActivityView(activityView);
    
    self.fk_replacedObject = barButtonItemToReplace;
    self.navigationItem.rightBarButtonItem = activityItem;
    
    [activityView startAnimating];
}

- (void)showLoadingIndicatorInToolbar:(UIToolbar *)toolbar insteadOfItem:(UIBarButtonItem *)itemToReplace {
    [self hideLoadingIndicator];
    if (toolbar.items.count == 0) {
        return;
    }

    // attach original toolbar items to toolbar for later retreival
    FKAssert(toolbar.metaData == nil, @"UIToolbar MetaData is already set, will loose it");
    toolbar.metaData = toolbar.items;

    NSUInteger indexOfItemToReplace = [toolbar.items indexOfObject:itemToReplace];
    if (indexOfItemToReplace == NSNotFound) {
        return;
    }
    
    NSMutableArray *items = [[NSMutableArray alloc] initWithArray:toolbar.items];
    UIActivityIndicatorView *activityView = self.activityView;
    UIBarButtonItem *activityItem = FKBarButtonItemWithActivityView(activityView);
    
    self.fk_replacedObject = toolbar;
    [items replaceObjectAtIndex:indexOfItemToReplace withObject:activityItem];
    [toolbar setItems:items animated:YES];
    
    [activityView startAnimating];
}

- (void)hideLoadingIndicator {
    id replacedObject = self.fk_replacedObject;
    UIActivityIndicatorView *activityView = self.activityView;
    
    // ActivityView was in NavigationBar
    if ([replacedObject isKindOfClass:[UIBarButtonItem class]]) {
        [activityView stopAnimating];
        self.navigationItem.rightBarButtonItem = replacedObject;
        return;
    } 
    
    // ActivityView was in Toolbar
    else if ([replacedObject isKindOfClass:[UIToolbar class]]) {
        [activityView stopAnimating];
        if ([[replacedObject metaData] isKindOfClass:[NSArray class]]) {
            [replacedObject setItems:[replacedObject metaData] animated:YES];
            [replacedObject setMetaData:nil];
        }
        return;
    }
    
    // ActivityView was displayed instead of another view
    else if ([replacedObject isKindOfClass:[UIView class]]) {
        BOOL hiddenBefore = [[replacedObject metaData] boolValue];
        if (!hiddenBefore) {
            [replacedObject setHidden:NO];
        }
        [replacedObject setMetaData:nil];
    }
    
    [activityView stopAnimating];
    [activityView removeFromSuperview];
}

@end


////////////////////////////////////////////////////////////////////////
#pragma mark - Helper Functions
////////////////////////////////////////////////////////////////////////

static CGRect FKCenteredSquareInRectConstrainedToSize(CGRect rect, CGFloat size) {
    CGRect centeredSquare = rect;
    CGFloat xInset = 0.f;
    CGFloat yInset = 0.f;
    
    // make a centered square
    if (CGRectGetWidth(centeredSquare) < CGRectGetHeight(centeredSquare)) {
        yInset = (CGRectGetHeight(centeredSquare) - CGRectGetWidth(centeredSquare))/2;
    } else {
        xInset = (CGRectGetWidth(centeredSquare) - CGRectGetHeight(centeredSquare))/2;
    }
    
    centeredSquare = CGRectInset(centeredSquare, xInset, yInset);
    
    // limit size
    if (CGRectGetWidth(centeredSquare) > size) {
        centeredSquare = CGRectInset(centeredSquare, (CGRectGetWidth(centeredSquare)-size)/2,(CGRectGetHeight(centeredSquare) - size)/2);
    }
    
    // use integral coordinates to prohibit blurring
    return CGRectIntegral(centeredSquare);
}

static UIBarButtonItem* FKBarButtonItemWithActivityView(UIActivityIndicatorView *activityView) {
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, 24.f, 26.f)];
    
    activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    activityView.autoresizingMask = UIViewAutoresizingNone;
    activityView.frame = CGRectMake(0.f, 2.f, 20.f, 20.f);
    [backgroundView addSubview:activityView];
    
    return [[UIBarButtonItem alloc] initWithCustomView:backgroundView];
}

