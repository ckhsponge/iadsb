#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "CCMagneticDeclination.h"
#import "CCMagneticModel.h"
#import "NSDate+DecimalYear.h"
#import "ObjectiveWMM.h"
#import "EGM9615.h"
#import "GeomagnetismHeader.h"

FOUNDATION_EXPORT double ObjectiveWMMVersionNumber;
FOUNDATION_EXPORT const unsigned char ObjectiveWMMVersionString[];

