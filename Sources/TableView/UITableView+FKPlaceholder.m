#import "UITableView+FKPlaceholder.h"
#import "UIScrollView+FKAdditions.h"
#import "UIView+FKAdditions.h"
#import "CGGeometry+FKAdditions.h"
#import "UIEdgeInsets+FKAdditions.h"

FKLoadCategory(UITableViewFKPlaceholder);

static char contentUnavailableViewKey;

@interface UITableView ()

@property (nonatomic, strong) UIView *fk_contentUnavailableView;

- (UIView *)fk_contentUnavailableViewFromDelegate;

@end

@implementation UITableView (FKPlaceholder)

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Show/Hide Placeholder
////////////////////////////////////////////////////////////////////////

- (void)setContentUnavailableViewHidden:(BOOL)hidden {
    UIView *contentUnavailableView = [self fk_contentUnavailableViewFromDelegate];
    
    if (hidden || contentUnavailableView == nil) {
        self.scrollEnabled = YES;
        [self.fk_contentUnavailableView removeFromSuperview];
        self.fk_contentUnavailableView = nil;
    } 
    
    // hidden == NO
    else {
        CGRect frame = self.bounds;
        
		if(self.tableHeaderView) {
            frame = FKRectInset(frame, FKEdgeInsetsMake(0.f, self.tableHeaderView.frameHeight, 0.f, 0.f));
		}
        
        contentUnavailableView.frame = frame;
        self.fk_contentUnavailableView = contentUnavailableView;
        
        [self scrollToTop];
        [self addSubview:contentUnavailableView];
        self.scrollEnabled = NO;
    }
}

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Setter/Getter
////////////////////////////////////////////////////////////////////////

- (void)setFk_contentUnavailableView:(UIView *)contentUnavailableView {
    [self associateValue:contentUnavailableView withKey:&contentUnavailableViewKey];
}

- (UIView *)fk_contentUnavailableView {
    return (UIView *)[self associatedValueForKey:&contentUnavailableViewKey];
}

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Delegate Calls
////////////////////////////////////////////////////////////////////////

- (UIView *)fk_contentUnavailableViewFromDelegate {
    id delegate = self.delegate;
    
    if ([delegate respondsToSelector:@selector(contentUnavailableViewForTableView:)]) {
        return [delegate contentUnavailableViewForTableView:self];
    }
    
    return nil;
}

@end
