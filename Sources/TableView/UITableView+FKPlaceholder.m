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
#pragma mark - Show/Hide Placeholder
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
        contentUnavailableView.frame = FKRectWithClearedOrigin(self.bounds);
        contentUnavailableView.autoresizingMask = self.autoresizingMask;
        self.fk_contentUnavailableView = contentUnavailableView;
        
        [self scrollToTop];
        [self addSubview:contentUnavailableView];
        self.scrollEnabled = NO;
    }
}

////////////////////////////////////////////////////////////////////////
#pragma mark - Setter/Getter
////////////////////////////////////////////////////////////////////////

- (void)setFk_contentUnavailableView:(UIView *)contentUnavailableView {
    [self associateValue:contentUnavailableView withKey:&contentUnavailableViewKey];
}

- (UIView *)fk_contentUnavailableView {
    return (UIView *)[self associatedValueForKey:&contentUnavailableViewKey];
}

////////////////////////////////////////////////////////////////////////
#pragma mark - Delegate Calls
////////////////////////////////////////////////////////////////////////

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"

- (UIView *)fk_contentUnavailableViewFromDelegate {
    id delegate = self.delegate;
    
    if ([delegate respondsToSelector:@selector(contentUnavailableViewForTableView:)]) {
        return [delegate contentUnavailableViewForTableView:self];
    }
    
    return nil;
}

#pragma clang diagnostic pop

@end
