// Part of iOSKit http://foundationk.it

#import <UIKit/UIKit.h>

/**
 This category helps localizing NIBs. 
 You can specify the key for localizing by adding an "@" in front of the text.
 If you want to have an '@' at the beginning of the text and it shouldn't be localized
 you can start the text with '\@'
 
 Currently supported are the following UIView-Subclasses:
 1) UIButton
 2) UISegmentedControl
 3) UIButton
 4) Classes that respond to selectors 'title', 'text' or 'placeholder'
 **/

@interface UIView (FKNIBLocalization)

/** Flag whether automatic localization is enabled, defaults to YES */
@property (nonatomic, assign) BOOL nibLocalizationEnabled;

/**
 automatically translate UIViews loaded from NIB which text starts with Prefix "@"
 */
- (void)awakeFromNib;

@end
