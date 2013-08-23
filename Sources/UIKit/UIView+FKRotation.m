#import "UIView+FKRotation.h"
#import "UIApplication+FKConcise.h"


FKLoadCategory(UIViewFKRotation);

static char portraitFrameKey;
static char landscapeFrameKey;

@implementation UIView (FKRotation)

+ (id)fkit_viewWithPortraitFrame:(CGRect)portraitFrame landscapeFrame:(CGRect)landscapeFrame {
    UIView *view = [[[self class] alloc] initWithFrame:portraitFrame];
    
    view.fkit_portraitFrame = portraitFrame;
    view.fkit_landscapeFrame = landscapeFrame;
    
    return view;
}

+ (id)fkit_viewWithPortraitFrame:(CGRect)portraitFrame landscapeOrigin:(CGPoint)landscapeOrigin {
    return [self fkit_viewWithPortraitFrame:portraitFrame landscapeFrame:(CGRect){landscapeOrigin, portraitFrame.size}];
}

- (BOOL)fkit_hasPortraitOrLandscapeFrame {
    return !CGRectIsEmpty(self.fkit_portraitFrame) || !CGRectIsEmpty(self.fkit_landscapeFrame);
}

- (CGRect)fkit_portraitFrame {
    // read associated object for portrait frame
    NSValue *portraitFrameValue = (NSValue *)[self fkit_associatedValueForKey:&portraitFrameKey];
    
    if (portraitFrameValue != nil) {
        return [portraitFrameValue CGRectValue];
    } else {
        return CGRectZero;
    }
}

- (CGRect)fkit_landscapeFrame {
    // read associated object for landscape frame
    NSValue *landscapeFrameValue = (NSValue *)[self fkit_associatedValueForKey:&landscapeFrameKey];
    
    if (landscapeFrameValue != nil) {
        return [landscapeFrameValue CGRectValue];
    } else {
        return CGRectZero;
    }
}

- (void)fkit_setPortraitFrame:(CGRect)portraitFrame {
    [self fkit_associateValue:[NSValue valueWithCGRect:portraitFrame] withKey:&portraitFrameKey];
}

- (void)fkit_setLandscapeFrame:(CGRect)landscapeFrame {
    [self fkit_associateValue:[NSValue valueWithCGRect:landscapeFrame] withKey:&landscapeFrameKey];
}


- (CGRect)fkit_frameForInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    if (UIInterfaceOrientationIsPortrait(interfaceOrientation)) {
        return self.fkit_portraitFrame;
    } else {
        return self.fkit_landscapeFrame;
    }
}

- (void)fkit_animateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [UIView animateWithDuration:duration animations:^{
        [self fkit_setFrameForInterfaceOrientation:toInterfaceOrientation];
    }];
}

- (void)fkit_layoutView {
    [self fkit_setFrameForInterfaceOrientation:$appOrientation];
}

- (void)fkit_setFrameForInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    if (UIInterfaceOrientationIsPortrait(interfaceOrientation)) {
        CGRect portraitFrame = self.fkit_portraitFrame;
        
        self.frame = portraitFrame;
    } else {
        CGRect landscapeFrame = self.fkit_landscapeFrame;
        
        self.frame = landscapeFrame;
    }
}

- (void)fkit_setSubviewFramesForInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    [self fkit_setSubviewFramesForInterfaceOrientation:toInterfaceOrientation recursive:NO];
}

- (void)fkit_setSubviewFramesForInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation recursive:(BOOL)recursive {
    for (UIView *view in self.subviews) {
        if (view.fkit_hasPortraitOrLandscapeFrame) {
            [view fkit_setFrameForInterfaceOrientation:toInterfaceOrientation];
        }
        
        if (recursive) {
            [view fkit_setSubviewFramesForInterfaceOrientation:toInterfaceOrientation recursive:recursive];
        }
    } 
}

@end
