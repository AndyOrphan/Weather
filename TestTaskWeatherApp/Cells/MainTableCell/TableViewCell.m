//
//  TableViewCell.m
//  TestTaskWeatherApp
//
//  Created by Orphan on 5/17/18.
//  Copyright © 2018 Orphan. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)fillDataWithModel: (CityWeatherM *) model {
    [self.cityNameLabel setText: model.name];
    [self.currentTempLabel setText: [NSString stringWithFormat: @"%@ C", model.temp]];
}

@end
