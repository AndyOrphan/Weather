//
//  DetailWeatherVC.h
//  TestTaskWeatherApp
//
//  Created by Orphan on 5/17/18.
//  Copyright © 2018 Orphan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"


@interface DetailWeatherVC : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *currentTempLabel;
@property (weak, nonatomic) IBOutlet UILabel *mivTempLabel;
@property (weak, nonatomic) IBOutlet UILabel *maxTempLabel;
@property (weak, nonatomic) IBOutlet UILabel *windSpeedLabel;
@property (weak, nonatomic) IBOutlet UILabel *sunriseLabel;
@property (weak, nonatomic) IBOutlet UILabel *sunsetLabel;

@property (strong, nonatomic) CityWeatherM *model;



@end
