//
//  ObjectiveWMM.m
//  ObjectiveWMM
//
//  Created by Christopher Hobbs on 11/14/18.
//

#import <Foundation/Foundation.h>


#import "ObjectiveWMM.h"

@implementation ObjectiveWMM

// Returns declination
// Declinations on the west coast U.S. are positive, east coast are negative
// Subtract the declination to convert from true to magnetic
// 90°T -> 90 - 14 = 76°M
// Add the declination to convert from magnetic to true
// 0°M -> 0 + 14 = 14°T
+(CLLocationDirection) declinationForCoordinate:(CLLocationCoordinate2D)coordinate elevation:(double)elevation date:(NSDate * _Nullable)date {
    if(date == nil) {
        date = [NSDate date];
    }
    CCMagneticDeclination *model = [[CCMagneticModel instance] declinationForCoordinate:coordinate elevation:elevation date:date];
    return [model magneticDeclination];
}

// Returns the declination at the specified coordinate at 0 MSL with current timestamp
+(CLLocationDirection) declinationForCoordinate:(CLLocationCoordinate2D)coordinate {
    return [self declinationForCoordinate:coordinate elevation:0.0 date:nil];
}

// Returns the declination at the specified location
// No verification is done that elevation and timestamp are correct, negative elevations are valid
+(CLLocationDirection) declinationForLocation:(CLLocation * _Nonnull) location {
    return [self declinationForCoordinate:location.coordinate elevation:location.altitude date:location.timestamp];
}

@end
