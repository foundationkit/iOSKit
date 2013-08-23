// Part of iOSKit http://foundationk.it
//
// Taken from Ole Begemanns Blog-Post: http://oleb.net/blog/2012/12/accessing-pretty-printing-cgpath-elements/


#import <UIKit/UIKit.h>


typedef void(^fk_bezierPath_block)(const CGPathElement *element);


@interface UIBezierPath (FKDescription)

- (void)fkit_enumerateElementsUsingBlock:(fk_bezierPath_block)handler;

/** A human-readable description of the elements of a bezier Path */
- (NSString *)fkit_pathDescription;

@end
