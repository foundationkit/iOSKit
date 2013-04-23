#import "UIWebView+FKAdditions.h"

@implementation UIWebView (FKAdditions)

- (NSString *)documentTitle {
    return [self stringByEvaluatingJavaScriptFromString:@"document.title"];
}

- (void)setContentTextSizeScaleFactor:(NSInteger)scaleFactor {
    NSString *scaleCommand = [[NSString alloc] initWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%d%%'", scaleFactor];

    [self stringByEvaluatingJavaScriptFromString:scaleCommand];
}

- (void)setShadowsHidden:(BOOL)shadowsHidden {
	// Thanks @flyosity http://twitter.com/flyosity/status/17951035384
	for (UIView *view in self.subviews) {
		if ([view isKindOfClass:[UIScrollView class]]) {
			for (UIView *innerView in view.subviews) {
				if ([innerView isKindOfClass:[UIImageView class]]) {
					innerView.hidden = shadowsHidden;
				}
			}
		}
	}
}

- (void)setViewportWidth:(CGFloat)width {
    NSString* format = (@"var meta = document.createElement('meta'); "
                        "meta.setAttribute( 'name', 'viewport' ); "
                        "meta.setAttribute( 'content', 'width = %@ px' ); "
                        "document.getElementsByTagName('head')[0].appendChild(meta)");

    [self stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:format, width]];
}

@end
