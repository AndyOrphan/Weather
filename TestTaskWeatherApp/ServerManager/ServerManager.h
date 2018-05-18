//
//  ServerManager.h
//  TestTaskWeatherApp
//
//  Created by Orphan on 5/17/18.
//  Copyright © 2018 Orphan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>
#import <RestKit/CoreData.h>
#import "CityInfo.h"


@interface ServerManager : NSObject

+ (void)getWeathersFor: (NSArray *)ids withCompletion:(void (^)(NSArray *result, NSError *error)) completion;
+ (void)configureRestKit;
+ (void)getWeathersForCity: (NSString *)name withCompletion:(void (^)(NSArray *result, NSError *error)) completion;

@end
