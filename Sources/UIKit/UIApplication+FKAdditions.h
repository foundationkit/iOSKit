// Part of iOSKit http://foundationk.it
//
// Derived from Sam Soffes' Custom-Licensed SSToolkit: http://github.com/samsoffes/sstoolkit
// Originally mentioned by Marco Arment: http://twitter.com/marcoarment/status/27965461020

#import <UIKit/UIKit.h>

/**
 This category adds various additions to UIApplication for making life easier.
 */

@interface UIApplication (FKAdditions)

/** Checks for pirated application indicators. This isn't bulletproof, but should catch a lot of cases. */
@property (nonatomic, readonly, getter = isPirated) BOOL pirated;

@end
