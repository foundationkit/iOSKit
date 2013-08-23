// Part of iOSKit http://foundationk.it
//
// Parts taken from Sam Soffes' SSToolkit: http://github.com/samsoffes/sstoolkit

#import <UIKit/UIKit.h>

/**
 This category adds various shortcuts to UIWebView for dealing with javascript.
 */
@interface UIWebView (FKAdditions)

/** The title of the document, evaluates javascript 'document.title' */
@property (nonatomic, readonly) NSString *fkit_documentTitle;
/** The text that is currently selected in the webView */
@property (nonatomic, readonly) NSString *fkit_selectedText;

/**
 Adjusts the scale-factor of the content of the webView.
 
 @param scaleFactor the scaleFactor of the content in percent. 100 means standard scale.
 */
- (void)fkit_setContentTextSizeScaleFactor:(NSInteger)scaleFactor;

/** 
 Control the display of the shadows of the UIWebView.
 Be aware that this method might break in future OS versions since the view hierarchy could change.
 
 @param shadowsHidden If YES, the view-hierarchy gets traversed and all shadows get hidden. Otherwise they are shown.
 */
- (void)fkit_setShadowsHidden:(BOOL)shadowsHidden;

/**
 Sets the width by using the meta tag.
 
 <meta name="viewport" content="width=%@" />
 
 @param width the width to set or the viewport
 */
- (void)fkit_setViewportWidth:(CGFloat)width;


- (BOOL)fkit_displaysValidWebsite;

@end
