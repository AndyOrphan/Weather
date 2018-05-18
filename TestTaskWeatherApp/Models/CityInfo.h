//
//  CityInfo.h
//  TestTaskWeatherApp
//
//  Created by Orphan on 5/18/18.
//  Copyright © 2018 Orphan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainWeather.h"
#import "SkyWeather.h"
#import "WindWeather.h"

@interface CityInfo : NSObject
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSNumber *id;
@property (strong, nonatomic) MainWeather *main;
@property (strong, nonatomic) SkyWeather *sys;
@property (strong, nonatomic) WindWeather *wind;
@end
