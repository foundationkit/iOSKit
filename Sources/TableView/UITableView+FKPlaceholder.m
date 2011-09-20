#import "UITableView+FKPlaceholder.h"
#import "UIScrollView+FKAdditions.h"
#import "UIView+FKAdditions.h"
#import "CGGeometry+FKAdditions.h"
#import "UIEdgeInsets+FKAdditions.h"
#import "NSObject+FKAssociatedObjects.h"

static char placeholderDelegateKey;
static char contentUnavailableViewKey;

@interface UITableView ()

@property (nonatomic, strong) UIView *contentUnavailableView;

- (UIView *)contentUnavailableViewFromDelegate;

@end

@implementation UITableView (FKPlaceholder)

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Show/Hide Placeholder
////////////////////////////////////////////////////////////////////////

- (void)setContentUnavailableViewHidden:(BOOL)hidden {
    UIView *contentUnavailableView = [self contentUnavailableViewFromDelegate];
    
    if (hidden || contentUnavailableView == nil) {
        self.scrollEnabled = YES;
        [self.contentUnavailableView removeFromSuperview];
        self.contentUnavailableView = nil;
    } 
    
    // hidden == NO
    else {
        CGRect frame = self.bounds;
        
		if(self.tableHeaderView) {
            frame = FKRectInset(frame, FKEdgeInsetsMake(0.f, self.tableHeaderView.frameHeight, 0.f, 0.f));
		}
        
        contentUnavailableView.frame = frame;
        self.contentUnavailableView = contentUnavailableView;
        
        [self scrollToTop];
        [self addSubview:contentUnavailableView];
        self.scrollEnabled = NO;
    }
}

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Setter/Getter
////////////////////////////////////////////////////////////////////////

- (void)setPlaceholderDelegate:(id<FKTableViewPlaceholder>)placeholderDelegate {
    [self associateWeakValue:placeholderDelegate withKey:&placeholderDelegateKey];
}

- (id<FKTableViewPlaceholder>)placeholderDelegate {
    return (id<FKTableViewPlaceholder>)[self associatedValueForKey:&placeholderDelegateKey];
}

- (void)setContentUnavailableView:(UIView *)contentUnavailableView {
    [self associateValue:contentUnavailableView withKey:&contentUnavailableViewKey];
}

- (UIView *)contentUnavailableView {
    return (UIView *)[self associatedValueForKey:&contentUnavailableViewKey];
}

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Delegate Calls
////////////////////////////////////////////////////////////////////////

- (UIView *)contentUnavailableViewFromDelegate {
    id<FKTableViewPlaceholder> delegate = self.placeholderDelegate;
    
    if ([delegate respondsToSelector:@selector(contentUnavailableViewForTableView:)]) {
        return [delegate contentUnavailableViewForTableView:self];
    }
    
    return nil;
}

@end
