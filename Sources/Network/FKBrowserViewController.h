// Part of iOSKit http://foundationk.it
//
// Derived from Abraham Vegh's BSD-Licensed AVWebViewController: https://github.com/abrahamvegh/AVWebViewController/

#import <Foundation/Foundation.h>

@class FKBrowserViewController;

typedef void(^fk_browser_load_block)(FKBrowserViewController *browserViewController);
typedef void(^fk_browser_fail_block)(FKBrowserViewController *browserViewController, NSError *error);

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
@property (nonatomic, strong, readonly) UIWebView *webView;
/** Is the toolbar visible or hidden */
@property (nonatomic, assign) BOOL toolbarHidden;
/** If this flag is YES, a done button is shown */
@property (nonatomic, assign, getter = isPresentedModally) BOOL presentedModally;
/** By setting this property you can force to show this title instead of the title of the webpage */
@property (nonatomic, copy) NSString *titleToDisplay;

/** Block that gets executed when loading of url finished */
@property (nonatomic, copy) fk_browser_load_block didFinishLoadBlock;
/** Block that gets executed when loading of url failed */
@property (nonatomic, copy) fk_browser_fail_block didFailToLoadBlock;

/**
 Creates a FKBrowserViewController with the given Address
 
 @param address The address the browser should display
 */
+ (id)browserWithAddress:(NSString *)address;

/**
 Creates a FKBrowserViewController with the given Address and presentedModally set to YES.
 This shows a done-button which can be used to dismiss the viewController.
 
 @param address The address the browser should display
 */
+ (id)modalBrowserWithAddress:(NSString *)address;

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

/**
 Adds an action to the action menu
 */
- (void)addActionWithTitle:(NSString *)title block:(dispatch_block_t)block;

/** 
 Performs a javascript command and returns the result.
 @param command the javascript command to execute
 @return the result of the javascript command
 */
- (NSString *)stringByEvaluatingJavaScriptFromString:(NSString *)command;

@end
