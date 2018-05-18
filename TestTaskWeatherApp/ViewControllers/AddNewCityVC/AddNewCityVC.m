//
//  AddNewCityVC.m
//  TestTaskWeatherApp
//
//  Created by Orphan on 5/17/18.
//  Copyright © 2018 Orphan. All rights reserved.
//

#import "AddNewCityVC.h"

@interface AddNewCityVC ()

@end

@implementation AddNewCityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions
- (IBAction)searchAndAddButtonTouchUpInside:(id)sender {
    [self loadWeatherFromServer];
}

- (void)showErrorAlert {
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Error"
                                 message:@"Nothing found"
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okButton = [UIAlertAction
                                actionWithTitle:@"OK"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    [alert dismissViewControllerAnimated:YES completion:nil];
                                }];
    [alert addAction:okButton];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Server
- (void)loadWeatherFromServer {
    [ServerManager getWeathersForCity:self.textField.text withCompletion:^(NSArray *result, NSError *error) {
        if (result.count > 0) {
            CityInfo *model = result.firstObject;
            ViewController *delVC = (ViewController *)self.delegate;
            if (![delVC isHaveObj:model]) {
                [delVC insertNewObject:model];
            }
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [self showErrorAlert];
        }
    }];
}

@end
