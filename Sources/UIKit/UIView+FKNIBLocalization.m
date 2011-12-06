#import "UIView+FKNIBLocalization.h"
#import "NSNumber+FKConcise.h"

#define kFKNibLocalizationEnabledDefaultValue           YES

static char localizationEnabledKey;

@interface UIView ()

- (NSString *)fk_localizedValueForString:(NSString *)string;

- (void)fk_localizeValueForKey:(NSString *)key;
- (void)fk_localizeButton;
- (void)fk_localizeSegmentedControl;
- (void)fk_localizeTabBar;

@end

@implementation UIView (FKNIBLocalization)

- (void)awakeFromNib {
	if ([self respondsToSelector:@selector(text)]) {
        [self fk_localizeValueForKey:@"text"];
    } else if ([self respondsToSelector:@selector(title)]) {
        [self fk_localizeValueForKey:@"title"];
    } else if ([self isKindOfClass:[UIButton class]]) {
    	[self fk_localizeButton];
    } else if ([self isKindOfClass:[UISegmentedControl class]]) {
        [self fk_localizeSegmentedControl];
    } else if ([self isKindOfClass:[UITabBar class]]) {
        [self fk_localizeTabBar];
    }
    
    if ([self respondsToSelector:@selector(placeholder)]) {
        [self fk_localizeValueForKey:@"placeholder"];
    }
}

- (void)setNibLocalizationEnabled:(BOOL)nibLocalizationEnabled {
    [self associateValue:$bool(nibLocalizationEnabled) withKey:&localizationEnabledKey];
}

- (BOOL)nibLocalizationEnabled {
    NSNumber *enabled = [self associatedValueForKey:&localizationEnabledKey];
    
    if (enabled == nil) {
        [self associateValue:$bool(kFKNibLocalizationEnabledDefaultValue) withKey:&localizationEnabledKey];
        return kFKNibLocalizationEnabledDefaultValue;
    }
    
    return [enabled boolValue];
}

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Private
////////////////////////////////////////////////////////////////////////

- (NSString *)fk_localizeValueForString:(NSString *)string {
    if ([string hasPrefix:@"@"]) {
    	string = NSLocalizedString([string substringFromIndex:1], nil);
    } else if ([string hasPrefix:@"\\@"]) {
        string = [string substringFromIndex:1];
    }
    
    return string;
}

- (void)fk_localizeValueForKey:(NSString *)key {
	NSString* oldValue = [self valueForKey:key];
    NSString* localizedValue = [self fk_localizedValueForString:oldValue];
    
	if (oldValue != localizedValue) {
	    [self setValue:localizedValue forKey:key];
    }
}

- (void)fk_localizeButton {
    UIButton *button = (id)self;
    
	for (UIControlState state = UIControlStateNormal; state <= UIControlStateSelected; state++) {
		NSString *oldTitle = [button titleForState:state];
        
        if (oldTitle != nil) {
            NSString* localizedTitle = [self fk_localizedValueForString:oldTitle];
            
            if (oldTitle != localizedTitle) {
                [button setTitle:localizedTitle forState:state];
            }
        }
    }
}

- (void)fk_localizeSegmentedControl {
    UISegmentedControl *segmentedControl = (UISegmentedControl *)self;
    
    for (int index = 0; index < segmentedControl.numberOfSegments; index++) {
        NSString *title = [segmentedControl titleForSegmentAtIndex:index];
        [segmentedControl setTitle:[self fk_localizedValueForString:title] forSegmentAtIndex:index];
    }
}

- (void)fk_localizeTabBar {
    UITabBar *tabBar = (UITabBar *)self;
    NSArray *tabBarItems = tabBar.items;
    
    for (UITabBarItem* item in tabBarItems) {
        NSString *title = item.title;
        
        [item setTitle:[self fk_localizedValueForString:title]];
    }
}

@end
