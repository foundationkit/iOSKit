// Part of iOSKit http://foundationk.it
//
// Derived from Abraham Vegh's BSD-Licensed AVWebViewController: https://github.com/abrahamvegh/AVWebViewController/

#import <Foundation/Foundation.h>

/**
 This ViewController can be used to display an InApp-Browser.
 */
@interface FKBrowserViewController : UIViewController

/** The current address of the browser. You can use this to redirect the browser to the given address */
@property (nonatomic, copy) NSString *address;
/** The current URL of the browser */
@property (nonatomic, strong) NSURL *url;

/** Color used to style NavigationBar and ToolBar */
@property (nonatomic, strong) UIColor *tintColor;
/** Background Color */
@property (nonatomic, strong) UIColor *backgroundColor;
/** Used to control if fade-animation is used. Defaults to YES */
@property (nonatomic, assign) BOOL fadeAnimationEnabled;
/** The toolbar of the browserViewController. Customizable */
@property (nonatomic, strong, readonly) UIToolbar *toolbar;

/**
 Initializes the Browser with the given Address and start loading when the viewController gets pushed.
 This is the designated Initializer.
 
 @param address The address the browser should display
 */
- (id)initWithAddress:(NSString *)address;

/**
 Initializes the Browser with the given URL and start loading when the viewController gets pushed.
 
 @param url The URL the browser should display
 */
- (id)initWithURL:(NSURL *)url;

/**
 Stops loading of the UIWebView
 */
- (void)stopLoading;

/**
 Loads the currently set address/url.
 */
- (void)reload;

@end
