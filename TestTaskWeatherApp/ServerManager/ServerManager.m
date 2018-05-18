//
//  ServerManager.m
//  TestTaskWeatherApp
//
//  Created by Orphan on 5/17/18.
//  Copyright © 2018 Orphan. All rights reserved.
//

#import "ServerManager.h"


@implementation ServerManager

+ (void)configureRestKit
{
    NSURL *baseURL = [NSURL URLWithString:@"http://api.openweathermap.org"];
    AFRKHTTPClient* client = [[AFRKHTTPClient alloc] initWithBaseURL:baseURL];
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    [RKObjectManager setSharedManager:objectManager];
}

+ (void)getWeathersFor: (NSArray *)ids withCompletion:(void (^)(NSArray *result, NSError *error)) completion
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    NSString *idsStr = [ids componentsJoinedByString:@","];
    
    RKObjectMapping *mapping = [ServerManager setupMapping];
    
    NSIndexSet *statusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful);
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping method:RKRequestMethodGET pathPattern:nil keyPath:@"list" statusCodes:statusCodes];
    
    [objectManager addResponseDescriptor:responseDescriptor];
    
    NSString *path = [NSString stringWithFormat:@"/data/2.5/group?id=%@&units=metric", idsStr];
    
    NSMutableURLRequest *urlRequest = [objectManager requestWithObject:nil
                                                                method:RKRequestMethodGET
                                                                  path:path
                                                            parameters:nil];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [urlRequest setValue:@"7412a3410ae64350150c1a100d768511" forHTTPHeaderField:@"x-api-key"];
    
    RKObjectRequestOperation *operation = [objectManager objectRequestOperationWithRequest:urlRequest success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        completion(mappingResult.array, nil);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        completion(nil, error);
    }];
    
    [objectManager enqueueObjectRequestOperation:operation];
}

+ (void)getWeathersForCity: (NSString *)name withCompletion:(void (^)(NSArray *result, NSError *error)) completion
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    
    RKObjectMapping *mapping = [ServerManager setupMapping];
    
    NSIndexSet *statusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful);
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping method:RKRequestMethodGET pathPattern:nil keyPath:nil statusCodes:statusCodes];
    
    [objectManager addResponseDescriptor:responseDescriptor];
    
    NSString *path = [NSString stringWithFormat:@"/data/2.5/weather?q=%@&units=metric", name];
    
    NSMutableURLRequest *urlRequest = [objectManager requestWithObject:nil
                                                                method:RKRequestMethodGET
                                                                  path:path
                                                            parameters:nil];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [urlRequest setValue:@"7412a3410ae64350150c1a100d768511" forHTTPHeaderField:@"x-api-key"];
    
    RKObjectRequestOperation *operation = [objectManager objectRequestOperationWithRequest:urlRequest success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        completion(mappingResult.array, nil);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        completion(nil, error);
    }];
    
    [objectManager enqueueObjectRequestOperation:operation];
}

+ (RKObjectMapping *)setupMapping {
    RKObjectMapping* mapping = [RKObjectMapping mappingForClass:[CityInfo class]];
    [mapping addAttributeMappingsFromArray:@[@"name", @"id"]];
    
    RKObjectMapping* mainMapping = [RKObjectMapping mappingForClass:[MainWeather class]];
    [mainMapping addAttributeMappingsFromArray:@[@"temp", @"temp_min", @"temp_max"]];
    
    RKObjectMapping* skyMapping = [RKObjectMapping mappingForClass:[SkyWeather class]];
    [skyMapping addAttributeMappingsFromArray:@[@"sunset",@"sunrise"]];
    
    RKObjectMapping* windMapping = [RKObjectMapping mappingForClass:[WindWeather class]];
    [windMapping addAttributeMappingsFromArray:@[@"speed", @"deg"]];
    
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"main" toKeyPath:@"main" withMapping:mainMapping]];
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"sys" toKeyPath:@"sys" withMapping:skyMapping]];
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"wind" toKeyPath:@"wind" withMapping:windMapping]];
    return mapping;
}

@end
