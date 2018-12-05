//
//  ObjectiveWMM.h
//  ObjectiveWMM
//
//  Created by Stephen Trainor on 12/15/14.
//  Copyright (c) 2014 Crookneck Consulting LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for ObjectiveWMM.
FOUNDATION_EXPORT double ObjectiveWMMVersionNumber;

//! Project version string for ObjectiveWMM.
FOUNDATION_EXPORT const unsigned char ObjectiveWMMVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <ObjectiveWMM/PublicHeader.h>

#import <ObjectiveWMM/CCMagneticDeclination.h>
#import <ObjectiveWMM/CCMagneticModel.h>

@interface ObjectiveWMM : NSObject

+(CLLocationDirection) declinationForLocation:(CLLocation *) location NS_SWIFT_NAME(declination(location:));
+(CLLocationDirection) declinationForCoordinate:(CLLocationCoordinate2D)coordinate elevation:(double)elevation date:(NSDate * _Nullable)date NS_SWIFT_NAME(declination(coordinate:elevation:date:));
+(CLLocationDirection) declinationForCoordinate:(CLLocationCoordinate2D)coordinate NS_SWIFT_NAME(declination(coordinate:));

@end
