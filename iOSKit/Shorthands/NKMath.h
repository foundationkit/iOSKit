// Part of FoundationKit http://foundationk.it


// angle conversion
#define NKDegreesToRadian(x) (M_PI * (x) / 180.0)
#define NKRadianToDegrees(x) (M_PI * 180.0 / (x))

// time macros
#define NKTimeIntervalMilliseconds(x) (NSTimeInterval)(x / 1000.)
#define NKTimeIntervalSeconds(x) (NSTimeInterval)x
#define NKTimeIntervalMinutes(x) (NSTimeInterval)(x * 60.)
#define NKTimeIntervalHours(x) (NSTimeInterval)(x * 3600.)
#define NKTimeIntervalDays(x) (NSTimeInterval)(x * 3600. * 24.)


// returns a matrix that rotates and translates at one time
NS_INLINE CGAffineTransform NKAffineTransformMakeRotateTranslate(CGFloat angle, CGFloat dx, CGFloat dy);

// returns a matrix that scales and translates at one time
NS_INLINE CGAffineTransform NKAffineTransformMakeScaleTranslate(CGFloat sx, CGFloat sy, CGFloat dx, CGFloat dy);