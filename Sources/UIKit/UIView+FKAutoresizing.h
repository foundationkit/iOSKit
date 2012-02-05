// Part of iOSKit http://foundationk.it

////////////////////////////////////////////////////////////////////////
#pragma mark - Autoresizing Constants
////////////////////////////////////////////////////////////////////////

/** Autoresizing Mask with flexible margins on all sides */
#define UIViewAutoresizingKeepCentered          (UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin)

/** Autoresizing Mask with flexible margins left, right and bottom */
#define UIViewAutoresizingKeepTopCentered       (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin)

/** Autoresizing Mask with flexible margins left, right and top */
#define UIViewAutoresizingKeepBottomCentered    (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin)

/** Autoresizing Mask with flexible margins right and bottom */
#define UIViewAutoresizingKeepTopLeft           (UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin)

/** Autoresizing Mask with flexible margins left and bottom */
#define UIViewAutoresizingKeepTopRight          (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin)

/** Autoresizing Mask with flexible margins right and top */
#define UIViewAutoresizingKeepBottomLeft        (UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin)

/** Autoresizing Mask with flexible margins left and top */
#define UIViewAutoresizingKeepBottomRight       (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin)

/** Autoresizing Mask with flexible width and height */
#define UIViewAutoresizingKeepAllMargins        (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)