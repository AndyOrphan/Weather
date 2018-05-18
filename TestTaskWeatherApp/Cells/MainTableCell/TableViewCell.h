//
//  TableViewCell.h
//  TestTaskWeatherApp
//
//  Created by Orphan on 5/17/18.
//  Copyright © 2018 Orphan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityInfo.h"
#import "MainWeather.h"
#import "CityWeatherM+CoreDataClass.h"

@interface TableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *cityNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentTempLabel;

- (void)fillDataWithModel: (CityWeatherM *) model;

@end
