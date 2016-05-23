//
//  PTGMenuViewController.m
//  PlaceToGo
//
//  Created by Veselin Cholakov on 5/20/16.
//  Copyright © 2016 Nikolay Andonov. All rights reserved.
//

#import "PTGMenuViewController.h"
@interface PTGMenuViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *sectionTableView;

@end

@implementation PTGMenuViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.sectionTableView.delegate = self;
    self.sectionTableView.dataSource = self;
    self.sectionTableView.scrollEnabled = NO;
    self.sectionTableView.allowsSelection = NO;
    
}

#pragma mark - UITableViewDelegate methods


#pragma mark - UITableViewDataSource methods

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc ] init];
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return section?@"Settings":@"User information";
}


@end