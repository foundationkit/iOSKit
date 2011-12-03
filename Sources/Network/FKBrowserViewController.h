// Part of iOSKit http://foundationk.it

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

- (id)initWithURL:(NSURL *)url;
- (id)initWithAddress:(NSString *)address;

- (void)stopLoading;
- (void)reload;

@end
