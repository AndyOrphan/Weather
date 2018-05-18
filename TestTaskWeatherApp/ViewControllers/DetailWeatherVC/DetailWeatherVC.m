//
//  DetailWeatherVC.m
//  TestTaskWeatherApp
//
//  Created by Orphan on 5/17/18.
//  Copyright © 2018 Orphan. All rights reserved.
//

#import "DetailWeatherVC.h"

@interface DetailWeatherVC ()

@end

@implementation DetailWeatherVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fillData];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) fillData {
    [self.navigationItem setTitle: _model.name];
    [self.sunsetLabel setText:[NSString stringWithFormat:@"Sunset: %@", _model.sunset]];
    [self.sunriseLabel setText:[NSString stringWithFormat:@"Sunrise: %@", _model.sunrise]];
    [self.maxTempLabel setText:[NSString stringWithFormat:@"Max temp: %@ C", _model.temp_max]];
    [self.mivTempLabel setText:[NSString stringWithFormat:@"Min temp: %@ C", _model.temp_min]];
    [self.currentTempLabel setText:[NSString stringWithFormat:@"Temp: %@ C", _model.temp]];
    [self.windSpeedLabel setText:[NSString stringWithFormat:@"Wind speed: %@ m/s", _model.wind_speed]];
}

@end
