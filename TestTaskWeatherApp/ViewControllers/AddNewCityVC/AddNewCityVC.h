//
//  AddNewCityVC.h
//  TestTaskWeatherApp
//
//  Created by Orphan on 5/17/18.
//  Copyright © 2018 Orphan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface AddNewCityVC : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) UIViewController *delegate;
@end
