#import "FKHairlineView.h"

static CGRect FKHairlineFrame(CGRect frame) {
    if (frame.size.width == 1.f) {
        frame.size.width = 1.f / [UIScreen mainScreen].scale;
    }

    if (frame.size.height == 1.f) {
        frame.size.height = 1.f / [UIScreen mainScreen].scale;
    }

    return frame;
}


@implementation FKHairlineView

////////////////////////////////////////////////////////////////////////
#pragma mark - Lifecycle
////////////////////////////////////////////////////////////////////////

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:FKHairlineFrame(frame)];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];

    self.frame = FKHairlineFrame(self.frame);
}

@end
