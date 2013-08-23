#import "UITableView+FKLoading.h"
#import "UITableViewCell+FKLoading.h"

FKLoadCategory(UITableViewFKLoading);

static char allowsMultipleIndicatorsKey;
static char cellsShowingIndicatorKey;

@interface UITableView ()

@property (nonatomic, readonly) NSMutableSet *fk_cellsShowingLoadingIndicator;

@end

@implementation UITableView (FKLoading)

- (void)fkit_showLoadingIndicatorAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath];
    
    if (!self.fkit_allowsMultipleLoadingIndicators) {
        [self fkit_hideLoadingIndicators];
    }
    
    [cell fkit_showLoadingIndicator];
    [self.fk_cellsShowingLoadingIndicator addObject:indexPath];
}

- (void)fkit_hideLoadingIndicatorAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath];
    
    [cell fkit_hideLoadingIndicator];
    [self.fk_cellsShowingLoadingIndicator removeObject:indexPath];
}

// hides all loading indicators
- (void)fkit_hideLoadingIndicators {
    for (NSIndexPath *indexPath in self.fk_cellsShowingLoadingIndicator) {
        [self fkit_hideLoadingIndicatorAtIndexPath:indexPath];
    }
}

- (void)fkit_setAllowsMultipleLoadingIndicators:(BOOL)allowsMultipleLoadingIndicators {
    [self fkit_associateValue:@(allowsMultipleLoadingIndicators) withKey:&allowsMultipleIndicatorsKey];
}

- (BOOL)fkit_allowsMultipleLoadingIndicators {
    return [[self fkit_associatedValueForKey:&allowsMultipleIndicatorsKey] boolValue];
}

- (NSMutableSet *)fk_cellsShowingLoadingIndicator {
    NSMutableSet *cells = (NSMutableSet *)[self fkit_associatedValueForKey:&cellsShowingIndicatorKey];
    
    // lazy loading
    if (cells == nil) {
        cells = [NSMutableSet set];
        [self fkit_associateValue:cells withKey:&cellsShowingIndicatorKey];
    }
    
    return cells;
}

@end
