#import "UIWebView+FKAdditions.h"

@implementation UIWebView (FKAdditions)

- (NSString *)fkit_documentTitle {
    return [self stringByEvaluatingJavaScriptFromString:@"document.title"];
}

- (NSString *)fkit_selectedText {
    // Idea taken from http://stackoverflow.com/a/13615064/268279
    NSString *currentPasteboardString = [UIPasteboard generalPasteboard].string;
    [[UIApplication sharedApplication] sendAction:@selector(copy:) to:nil from:self forEvent:nil];

    NSString *selectedText = [UIPasteboard generalPasteboard].string;

    if ([currentPasteboardString isKindOfClass:[NSString class]]) {
        [UIPasteboard generalPasteboard].string = currentPasteboardString;
    }
    
    return selectedText;
}

- (void)fkit_setContentTextSizeScaleFactor:(NSInteger)scaleFactor {
    NSString *scaleCommand = [[NSString alloc] initWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%d%%'", scaleFactor];

    [self stringByEvaluatingJavaScriptFromString:scaleCommand];
}

- (void)fkit_setShadowsHidden:(BOOL)shadowsHidden {
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

- (void)fkit_setViewportWidth:(CGFloat)width {
    NSString* format = (@"var meta = document.createElement('meta'); "
                        "meta.setAttribute( 'name', 'viewport' ); "
                        "meta.setAttribute( 'content', 'width = %@ px' ); "
                        "document.getElementsByTagName('head')[0].appendChild(meta)");

    [self stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:format, width]];
}

- (BOOL)fkit_displaysValidWebsite {
    return [self stringByEvaluatingJavaScriptFromString:@"document.body.innerHTML"].length > 0;
}

@end
