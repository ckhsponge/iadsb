//
//  ObjectiveWMM.m
//  ObjectiveWMM
//
//  Created by Christopher Hobbs on 11/14/18.
//

#import <Foundation/Foundation.h>


#import "ObjectiveWMM.h"

@implementation ObjectiveWMM

+(CLLocationDirection) declinationForLocation:(CLLocation * _Nonnull) location {
    return [CCMagneticModel declinationForLocation: location];
}

+(CLLocationDirection) declinationForCoordinate:(CLLocationCoordinate2D)coordinate elevation:(double)elevation date:(NSDate * _Nullable)date {
    if(date == nil) {
        date = [NSDate date];
    }
    CCMagneticDeclination *model = [[CCMagneticModel instance] declinationForCoordinate:coordinate elevation:elevation date:date];
    return [model magneticDeclination];
}

+(CLLocationDirection) declinationForCoordinate:(CLLocationCoordinate2D)coordinate {
    return [self declinationForCoordinate:coordinate elevation:0.0 date:nil];
}

@end
