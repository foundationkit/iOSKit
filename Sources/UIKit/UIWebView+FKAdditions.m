#import "UIWebView+FKAdditions.h"

@implementation UIWebView (FKAdditions)

- (NSString *)documentTitle {
    return [self stringByEvaluatingJavaScriptFromString:@"document.title"];
}

- (void)setContentTextSizeScaleFactor:(NSInteger)scaleFactor {
    NSString *scaleCommand = [[NSString alloc] initWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%d%%'", scaleFactor];
    
    [self stringByEvaluatingJavaScriptFromString:scaleCommand];
}

@end
