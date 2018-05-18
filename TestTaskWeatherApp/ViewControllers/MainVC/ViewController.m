//
//  ViewController.m
//  TestTaskWeatherApp
//
//  Created by Orphan on 5/17/18.
//  Copyright © 2018 Orphan. All rights reserved.
//

#import "ViewController.h"



@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *models;
@property (strong, nonatomic) NSMutableArray *ids;

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerNibs];
    [ServerManager configureRestKit];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.managedObjectContext = appDelegate.persistentContainer.viewContext;
    
    [self fetch];
    [self loadFromServer];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self fetch];
}

#pragma mark - Actions
- (IBAction)Add:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AddNewCityVC *addNewVC = (AddNewCityVC *)[storyboard instantiateViewControllerWithIdentifier:@"AddNewCityVC"];
    [addNewVC setDelegate: self];
    [self.navigationController pushViewController:addNewVC animated:YES];
}

#pragma mark - CoreData
- (void)insertNewObject: (CityInfo *)model {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CityWeatherM" inManagedObjectContext:managedObjectContext];
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:managedObjectContext];
    
    
    
    [newManagedObject setValue:model.name forKey:@"name"];
    [newManagedObject setValue:model.id forKey:@"id"];
    [newManagedObject setValue:model.main.temp forKey:@"temp"];
    [newManagedObject setValue:model.main.temp_max forKey:@"temp_max"];
    [newManagedObject setValue:model.main.temp_min forKey:@"temp_min"];
    [newManagedObject setValue:model.wind.speed forKey:@"wind_speed"];
    [newManagedObject setValue:[self stringFrom:model.sys.sunset] forKey:@"sunset"];
    [newManagedObject setValue:[self stringFrom:model.sys.sunrise] forKey:@"sunrise"];
    
    
    NSError *error = nil;
    if(![managedObjectContext save:&error]){
        NSLog(@"Unresolved error: %@, %@", error, [error userInfo]);
        abort();
    }
}

- (void) fetch {
    NSManagedObjectContext *context = self.managedObjectContext;
    
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"CityWeatherM"];
    
    NSError *error = nil;
    
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    
    if (error != nil) {
        
    }
    else {
        self.models = (NSMutableArray *)results;
        _ids = [NSMutableArray array];
        for (CityWeatherM *model in results) {
            [_ids addObject:[NSString stringWithFormat:@"%lld",model.id]];
        }
        
        if (_ids.count == 0) {
            [_ids addObject:@"524901"];
            [_ids addObject:@"703448"];
        }
    }
    [self.tableView reloadData];
}

- (BOOL)isHaveObj:(CityInfo *)obj {
    for (CityWeatherM *model in self.models) {
        if ([NSNumber numberWithUnsignedLongLong:model.id] == obj.id) {
            [model setValue:obj.name forKey:@"name"];
            [model setValue:obj.id forKey:@"id"];
            [model setValue:obj.main.temp forKey:@"temp"];
            [model setValue:obj.main.temp_max forKey:@"temp_max"];
            [model setValue:obj.main.temp_min forKey:@"temp_min"];
            [model setValue:obj.wind.speed forKey:@"wind_speed"];
            [model setValue:[self stringFrom:obj.sys.sunset] forKey:@"sunset"];
            [model setValue:[self stringFrom:obj.sys.sunrise] forKey:@"sunrise"];
            
            NSError *error = nil;
            [self.managedObjectContext save: &error];
            return true;
        }
    }
    return false;
}
#pragma mark - TableView
- (void)registerNibs {
    [self.tableView registerNib:[UINib nibWithNibName: @"TableViewCell" bundle: nil] forCellReuseIdentifier: @"TableViewCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.models count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"TableViewCell"];
    CityWeatherM *model = [self.models objectAtIndex:indexPath.row];
    [cell fillDataWithModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CityWeatherM *model = [self.models objectAtIndex: indexPath.row];
    [self openDetailVCWithModel: model];
}

- (void)openDetailVCWithModel: (CityWeatherM *)model {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DetailWeatherVC *detailVC = (DetailWeatherVC *)[storyboard instantiateViewControllerWithIdentifier:@"DetailWeatherVC"];
    [detailVC setModel: model];
    [self.navigationController pushViewController: detailVC animated: YES];
}

#pragma mark - Server
- (void)loadFromServer {
    [ServerManager getWeathersFor:_ids withCompletion:^(NSArray *result, NSError *error) {
        if (result != nil) {
            NSLog(@"%@",result);
            for (CityInfo* model in result) {
                if (![self isHaveObj:model]) {
                    [self insertNewObject:model];
                }
            }
            [self fetch];
        }
    }];
}

#pragma mark - Helpers

- (NSString *)stringFrom:(NSTimeInterval )timeInterval {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    NSString *timeStr = [formatter stringFromDate:date];
    return timeStr;
}

@end
