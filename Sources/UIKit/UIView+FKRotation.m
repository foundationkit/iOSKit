#import "UIView+FKRotation.h"
#import "UIApplication+FKConcise.h"


FKLoadCategory(UIViewFKRotation);

static char portraitFrameKey;
static char landscapeFrameKey;

@implementation UIView (FKRotation)

+ (id)viewWithPortraitFrame:(CGRect)portraitFrame landscapeFrame:(CGRect)landscapeFrame {
    UIView *view = [[[self class] alloc] initWithFrame:portraitFrame];
    
    view.portraitFrame = portraitFrame;
    view.landscapeFrame = landscapeFrame;
    
    return view;
}

+ (id)viewWithPortraitFrame:(CGRect)portraitFrame landscapeOrigin:(CGPoint)landscapeOrigin {
    return [self viewWithPortraitFrame:portraitFrame landscapeFrame:(CGRect){landscapeOrigin, portraitFrame.size}];
}

- (BOOL)hasPortraitOrLandscapeFrame {
    return !CGRectIsEmpty(self.portraitFrame) || !CGRectIsEmpty(self.landscapeFrame);
}

- (CGRect)portraitFrame {
    // read associated object for portrait frame
    NSValue *portraitFrameValue = (NSValue *)[self associatedValueForKey:&portraitFrameKey];
    
    if (portraitFrameValue != nil) {
        return [portraitFrameValue CGRectValue];
    } else {
        return CGRectZero;
    }
}

- (CGRect)landscapeFrame {
    // read associated object for landscape frame
    NSValue *landscapeFrameValue = (NSValue *)[self associatedValueForKey:&landscapeFrameKey];
    
    if (landscapeFrameValue != nil) {
        return [landscapeFrameValue CGRectValue];
    } else {
        return CGRectZero;
    }
}

- (void)setPortraitFrame:(CGRect)portraitFrame {
    [self associateValue:[NSValue valueWithCGRect:portraitFrame] withKey:&portraitFrameKey];
}

- (void)setLandscapeFrame:(CGRect)landscapeFrame {
    [self associateValue:[NSValue valueWithCGRect:landscapeFrame] withKey:&landscapeFrameKey];
}


- (CGRect)frameForInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    if (UIInterfaceOrientationIsPortrait(interfaceOrientation)) {
        return self.portraitFrame;
    } else {
        return self.landscapeFrame;
    }
}

- (void)animateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [UIView animateWithDuration:duration animations:^{
        [self setFrameForInterfaceOrientation:toInterfaceOrientation];
    }];
}

- (void)layoutView {
    [self setFrameForInterfaceOrientation:$appOrientation];
}

- (void)setFrameForInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    if (UIInterfaceOrientationIsPortrait(interfaceOrientation)) {
        CGRect portraitFrame = self.portraitFrame;
        
        self.frame = portraitFrame;
    } else {
        CGRect landscapeFrame = self.landscapeFrame;
        
        self.frame = landscapeFrame;
    }
}

- (void)setSubviewFramesForInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    [self setSubviewFramesForInterfaceOrientation:toInterfaceOrientation recursive:NO];
}

- (void)setSubviewFramesForInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation recursive:(BOOL)recursive {
    for (UIView *view in self.subviews) {
        if (view.hasPortraitOrLandscapeFrame) {
            [view setFrameForInterfaceOrientation:toInterfaceOrientation];
        }
        
        if (recursive) {
            [view setSubviewFramesForInterfaceOrientation:toInterfaceOrientation recursive:recursive];
        }
    } 
}

@end
