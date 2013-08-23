#import "UIView+FKContentSize.h"
#import "UIView+FKAdditions.h"

FKLoadCategory(UIViewFKContentSize);

static char excludedKey;

@implementation UIView (FKContentSize)

- (BOOL)fkit_excludedFromScrollViewAutocalculation {
    NSNumber *excluded = (NSNumber *)[self fkit_associatedValueForKey:&excludedKey];
    
    if (excluded != nil) {
        return [excluded boolValue];
    }
    
    return NO;
}

- (void)fkit_setExcludedFromScrollViewAutocalculation:(BOOL)excludedFromScrollViewAutocalculation {
    [self fkit_associateValue:@(excludedFromScrollViewAutocalculation) withKey:&excludedKey];
}

- (BOOL)fkit_sizeToFitNeededHeightForWidth:(CGFloat)width {
    self.frameWidth = width;
    
    // size to fit content height
    if ([self isKindOfClass:[UITextView class]]) {
        UITextView *castedSelf = (UITextView *)self;
        CGRect f = castedSelf.frame;
        
        f.size.height = castedSelf.contentSize.height;
        castedSelf.frame = f;
        
        return YES;
    } 
    
    else if ([self isKindOfClass:[UILabel class]]) {
        UILabel *castedSelf = (UILabel *)self;
        
        if (castedSelf.numberOfLines == 1) {
            castedSelf.frameHeight = [castedSelf.font lineHeight];
        } else {
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 5.f);
            [self sizeToFit];
        }
        
        return YES;
    }
    
    // UIWebView sizeToFit is buggy
    else if ([self isKindOfClass:[UIWebView class]]) {
        UIWebView *castedSelf = (UIWebView *)self;
        
        castedSelf.frame = CGRectMake(castedSelf.frameLeft, castedSelf.frameTop, width, 5.f);
        [castedSelf sizeToFit];
        castedSelf.frameWidth = width;
        
        return YES;
    }
    
    else {
        [self sizeToFit];
        return NO;
    }
}

- (BOOL)fkit_sizeToFitNeededHeight {
    return [self fkit_sizeToFitNeededHeightForWidth:self.frameWidth];
}

@end
