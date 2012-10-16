#import "UITableView+FKLoading.h"
#import "UITableViewCell+FKLoading.h"

FKLoadCategory(UITableViewFKLoading);

static char allowsMultipleIndicatorsKey;
static char cellsShowingIndicatorKey;

@interface UITableView ()

@property (nonatomic, readonly) NSMutableSet *fk_cellsShowingLoadingIndicator;

@end

@implementation UITableView (FKLoading)

- (void)showLoadingIndicatorAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath];
    
    if (!self.allowsMultipleLoadingIndicators) {
        [self hideLoadingIndicators];
    }
    
    [cell showLoadingIndicator];
    [self.fk_cellsShowingLoadingIndicator addObject:indexPath];
}

- (void)hideLoadingIndicatorAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath];
    
    [cell hideLoadingIndicator];
    [self.fk_cellsShowingLoadingIndicator removeObject:indexPath];
}

// hides all loading indicators
- (void)hideLoadingIndicators {
    for (NSIndexPath *indexPath in self.fk_cellsShowingLoadingIndicator) {
        [self hideLoadingIndicatorAtIndexPath:indexPath];
    }
}

- (void)setAllowsMultipleLoadingIndicators:(BOOL)allowsMultipleLoadingIndicators {
    [self associateValue:@(allowsMultipleLoadingIndicators) withKey:&allowsMultipleIndicatorsKey];
}

- (BOOL)allowsMultipleLoadingIndicators {
    return [[self associatedValueForKey:&allowsMultipleIndicatorsKey] boolValue];
}

- (NSMutableSet *)fk_cellsShowingLoadingIndicator {
    NSMutableSet *cells = (NSMutableSet *)[self associatedValueForKey:&cellsShowingIndicatorKey];
    
    // lazy loading
    if (cells == nil) {
        cells = [NSMutableSet set];
        [self associateValue:cells withKey:&cellsShowingIndicatorKey];
    }
    
    return cells;
}

@end
