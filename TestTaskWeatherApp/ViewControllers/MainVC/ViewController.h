//
//  ViewController.h
//  TestTaskWeatherApp
//
//  Created by Orphan on 5/17/18.
//  Copyright © 2018 Orphan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewCell.h"
#import "DetailWeatherVC.h"
#import "ServerManager.h"
#import "AppDelegate.h"
#import "AddNewCityVC.h"


@interface ViewController : UIViewController

- (BOOL)isHaveObj:(CityInfo *)obj;
- (void)insertNewObject: (CityInfo *)model;

@end

