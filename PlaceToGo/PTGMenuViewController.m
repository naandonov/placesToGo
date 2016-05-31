//
//  PTGMenuViewController.m
//  PlaceToGo
//
//  Created by Veselin Cholakov on 5/20/16.
//  Copyright © 2016 Nikolay Andonov. All rights reserved.
//

#import "PTGMenuViewController.h"
#import "PTGCredentialStore.h"
#import "PTGNetworkManager.h"
#import "PTGBaseRequest.h"
#import "PTGUserInformationCell.h"
#import "PTGSegmentControlTableViewCell.h"
#import "PTGLoginViewController.h"
#import "PTGAuthenticationRequest.h"
#import "PTGUserInformationRequest.h"
#import "PTGVenuesCountSliderTableViewCell.h"
#import "PTGCoreDataHandler.h"
#import "PTGRadiusSliderTableViewCell.h"
#import "UIImage+PTGImageUtilities.h"

typedef NS_ENUM(NSInteger, PTGSections){
    PTGUserSection = 0,
    PTGFilterSection,
    PTGSortingSection
};

typedef NS_ENUM(NSInteger, PTGAuthenticatedUserSectionItems){
    PTGUserInfoItem = 0,
    PTGLogIOItem
};



typedef NS_ENUM(NSInteger, PTGFilterSelectionItem){
    PTGShowClosedVenuesFilterItem = 0,
    PTGVenuesCountFilterItemEnabled = 1,
    PTGVenuesCountFilterItem = 2,
    PTGRadiusFilterItemEnabled = 3,
    PTGRadiusFilterItem = 4,
};

NSString *const kLoginScreenID = @"PTGLoginViewController";
NSString *const kPTGUserInfoCell = @"PTGUserInfoCell";
NSString *const kPTGSegmentControlTableViewCell = @"PTGSegmentControlTableViewCell";

@interface PTGMenuViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *sectionTableView;
@property (nonatomic, strong) PTGAuthenticatedUserEntity *authenticatedUser;
@property (nonatomic, strong) PTGUserSettingsEntity *userSettings;
@property (nonatomic, strong) NSMutableArray <NSArray *> *cellArray;
@property (nonatomic, strong) NSArray <NSString *> *settingsSectionIdentifiersArray;
@property (nonatomic, strong) NSArray <NSString *> *userInfoIdentifiersArray;

@end



@implementation PTGMenuViewController


- (void)viewDidLoad{
    [super viewDidLoad];
    self.userInfoIdentifiersArray = @[@"PTGUserInfoCell",@"PTGLogIOTableViewCell"];
    self.settingsSectionIdentifiersArray = @[@"PTGShowClosedVenuesCell", @"PTGShowCountSlider", @"PTGCountSliderCell", @"PTGShowRadiusSliderCell", @"PTGRadiusSliderCell"];
    self.sectionTableView.allowsSelection = YES;
    self.sectionTableView.separatorInset = UIEdgeInsetsZero;
    self.sectionTableView.delegate = self;
    self.sectionTableView.dataSource = self;
    [self fetchRequiredEntities];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self assignAuthenticatedUserIfNeeded];
    [self populateCellArray];
    [self.sectionTableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == PTGUserSection){
        if ([PTGCredentialStore isThereAuthenticatedUser] && indexPath.row == PTGLogIOItem) {
            [self logoutAction];
        }else if (![PTGCredentialStore isThereAuthenticatedUser]){
            [self loginAction];
            [self assignAuthenticatedUserIfNeeded];
            [self populateCellArray];
        }
    }else if (indexPath.section == PTGFilterSection){
        
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == PTGUserSection){
        if ([self.cellArray firstObject].count == 1){
            return 45.0f;
        }else if ([self.cellArray firstObject].count != 1 && indexPath.row == 1){
            return 45.0f;
        }else{
            return 97.0f;
        }
    }else{
        return 45.0f;
    }
}

#pragma mark - UITableViewDataSource methods

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return self.cellArray.count;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger rowCount = 0;
    NSArray *userSectionArray = [self.cellArray objectAtIndex:PTGUserSection];
    NSArray *filterSectionArray = [self.cellArray objectAtIndex:PTGFilterSection];
    NSArray *sortingSectionArray = [self.cellArray objectAtIndex:PTGSortingSection];
    switch (section) {
        case PTGUserSection:{
            if(userSectionArray){
                rowCount = userSectionArray.count;
                return rowCount;
            }else{
                [self populateCellArray];
                return 0;
            }
        }
        case PTGFilterSection:{
            if(filterSectionArray){
                rowCount = filterSectionArray.count;
                return rowCount;
            }else{
                [self populateCellArray];
                return 0;
            }
        }
        case PTGSortingSection:{
            if(sortingSectionArray){
                NSInteger rowCount = sortingSectionArray.count;
                return rowCount;
            }else{
                [self populateCellArray];
                return rowCount;
            }
        }
        default:
            return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    switch(indexPath.section){
        case PTGUserSection:{
            cell = [self getUserInfoSectionCellForRowAtIndexPath:indexPath inTableView:tableView];
            break;
        }
    
        case PTGFilterSection: {
            cell = [self getUserSettingsCellForRowAtIndexPath:indexPath inTableView:tableView];
            break;
        }
        case PTGSortingSection:{
            cell = [tableView dequeueReusableCellWithIdentifier:kPTGSegmentControlTableViewCell];
            break;
        }
        default:
        {}
    }
    return cell;
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case PTGUserSection:{
            return @"User Information";
        }
        case PTGFilterSection: {
            return @"Filter";
        }
        case PTGSortingSection: {
            return @"Sorting";
        }
        default:
            return @"Error!";
    }
}

#pragma mark - Initialize cells

- (UITableViewCell *)getUserSettingsCellForRowAtIndexPath:(NSIndexPath *)indexPath inTableView:(UITableView *)tableView{
    UITableViewCell *cell = nil;
    NSNumber *identifierIndexNumber = [[self.cellArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    NSString *cellIdentifier = [self.settingsSectionIdentifiersArray objectAtIndex:identifierIndexNumber.integerValue];
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    return cell;
}

- (PTGSegmentControlTableViewCell *)getUserSortingCellRowAtIndexPath:(NSIndexPath *)indexPath inTableView:(UITableView *)tableView{
    PTGSegmentControlTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPTGSegmentControlTableViewCell];
    return cell;
}

- (UITableViewCell *)getUserInfoSectionCellForRowAtIndexPath:(NSIndexPath *)indexPath inTableView:(UITableView *)tableView{
    
    PTGUserInformationCell *cell = nil;
    if([PTGCredentialStore isThereAuthenticatedUser]){
        if(indexPath.row == 0){
            if(self.authenticatedUser){
                cell = [tableView dequeueReusableCellWithIdentifier:[self.userInfoIdentifiersArray objectAtIndex:PTGUserInfoItem]];
                NSString *firstName = [self.authenticatedUser firstName];
                cell.name = [firstName stringByAppendingFormat:@" %@",[self.authenticatedUser lastName]];
                cell.mail = self.authenticatedUser.email;
                NSString *imageDirectory = nil;
                NSArray *paths = nil;
                paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                imageDirectory = [paths objectAtIndex:0];
                imageDirectory = [imageDirectory stringByAppendingPathComponent:self.authenticatedUser.imagePath];
                cell.avatarImagePath = imageDirectory;
                cell.userInteractionEnabled = NO;
                return cell;
            }else{
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[self.userInfoIdentifiersArray objectAtIndex:PTGLogIOItem]];
                
                return cell;
            }
        }else{
            UITableViewCell *cell = [[UITableViewCell alloc] init];
            cell.textLabel.textColor = [UIColor redColor];
            cell.textLabel.text = @"Logout";
            return cell;
        }
    }else{
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        cell.textLabel.textColor = [UIColor blueColor];
        cell.textLabel.text = @"Login";
        return cell;
    }
}

#pragma mark - Get authenticated user

- (void)assignAuthenticatedUserIfNeeded{
    if (self.authenticatedUser || ![PTGCredentialStore isThereAuthenticatedUser]) {
        return;
    }
    PTGUserInformationRequest *authUserRequest = [[PTGUserInformationRequest alloc]initWithUserID:@"self"];
    [authUserRequest getUserInformationWithCompletion:^(NSDictionary *dict, NSError *error) {
        PTGAuthenticatedUserEntity *authenticatedUserEntity = [PTGCoreDataHandler insertAuthenticatedUserWithFirstName:[dict valueForKey:kFirstNameKey] lastName:[dict valueForKey:kLastNameKey] email:[dict valueForKey:kEmailKey] andImagePath:[dict valueForKey:kImagePath] inContext:[[PTGCoreDataManager sharedManager]managedObjectContext]];
        [[PTGCoreDataManager sharedManager] saveContext:[[PTGCoreDataManager sharedManager]managedObjectContext]];
        dispatch_async(dispatch_get_main_queue(),^{
            self.authenticatedUser = authenticatedUserEntity;
            [self.sectionTableView reloadSections:[NSIndexSet indexSetWithIndex:PTGUserSection] withRowAnimation:UITableViewRowAnimationFade];
        });
    }];
}

#pragma mark - Login/Logout

- (void)logoutAction{
    [PTGCredentialStore deleteAccessToken];
    if (self.authenticatedUser){
        [[[PTGCoreDataManager sharedManager] managedObjectContext] deleteObject:self.authenticatedUser];
        self.authenticatedUser = nil;
        [[PTGCoreDataManager sharedManager] saveContext:[[PTGCoreDataManager sharedManager] managedObjectContext]];
    }
    
    [self populateCellArray];
    [self.sectionTableView reloadSections:[NSIndexSet indexSetWithIndex:PTGUserSection] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)loginAction {
    PTGLoginViewController *loginViewController = [self.storyboard instantiateViewControllerWithIdentifier:kLoginScreenID];
    [self presentViewController:loginViewController animated:YES completion:nil];
    
}

#pragma mark - Get cells count

- (void)populateCellArray{
    self.cellArray = [[NSMutableArray alloc] init];
    if([PTGCredentialStore isThereAuthenticatedUser]){
        [self.cellArray addObject:@[@(PTGUserInfoItem),@(PTGLogIOItem)]];
    }else{
        [self.cellArray addObject:@[@(PTGLogIOItem)]];
    }
    NSMutableArray *filterSectionArray = [[NSMutableArray alloc] init];
    [filterSectionArray addObject:@(PTGShowClosedVenuesFilterItem)];
    if (self.userSettings.countLimit) {
        [filterSectionArray addObject:@(PTGVenuesCountFilterItemEnabled)];
        [filterSectionArray addObject:@(PTGVenuesCountFilterItem)];
    }else{
        [filterSectionArray addObject:@(PTGVenuesCountFilterItemEnabled)];
    }
    if (self.userSettings.radius) {
        [filterSectionArray addObject:@(PTGRadiusFilterItemEnabled)];
        [filterSectionArray addObject:@(PTGRadiusFilterItem)];
    }else{
        [filterSectionArray addObject:@(PTGRadiusFilterItemEnabled)];
    }
    [self.cellArray addObject:filterSectionArray];
    [self.cellArray addObject:@[@(0)]];
}

#pragma mark - Fetch user entities

- (void)fetchRequiredEntities{
    NSError *userEntityError = nil;
    self.authenticatedUser = [[PTGCoreDataHandler fetchAuthenticatedUsers:[[PTGCoreDataManager sharedManager] managedObjectContext] withPredicate:nil error:&userEntityError] firstObject];
    if(userEntityError){
        NSLog(@"An error occured while fetching local user data. Please see the description below:\n%@",userEntityError.localizedDescription);
    }
    NSError *userSettingsEntityError = nil;
    self.userSettings = [PTGCoreDataHandler fetchUserSettingsInContext:[[PTGCoreDataManager sharedManager] managedObjectContext] error:&userSettingsEntityError];
    if(userSettingsEntityError){
        NSLog(@"An error occured while fetching local user settings data. Please see the description below:\n%@",userSettingsEntityError.localizedDescription);
    }
}

#pragma mark - Switch methods

- (IBAction)isShowClosedEnabled:(UISwitch *)sender {
    if(sender.selected){
    
        if(self.userSettings){
            [self.userSettings setShowClosedVenues:[NSNumber numberWithBool:NO]];
        }else{
            self.userSettings = [PTGCoreDataHandler insertUserSettingsWithCountLimit:nil radius:nil closedVenuesVisibility:NO andSorting:nil inContext:[[PTGCoreDataManager sharedManager] managedObjectContext]];
        }
    }else{
        
        if(self.userSettings){
            [self.userSettings setShowClosedVenues:[NSNumber numberWithBool:YES]];
        }else{
            self.userSettings = [PTGCoreDataHandler insertUserSettingsWithCountLimit:nil radius:nil closedVenuesVisibility:YES andSorting:nil inContext:[[PTGCoreDataManager sharedManager] managedObjectContext]];
        }
    }
    NSError *error = nil;
    [[[PTGCoreDataManager sharedManager] managedObjectContext] save:&error];
    if(error){
        NSLog(@"Error while saving context %@. More information:\n%@",[[PTGCoreDataManager sharedManager] managedObjectContext],error.localizedDescription);
    }
}

- (IBAction)countSliderEnabled:(UISwitch *)sender {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:PTGVenuesCountFilterItem inSection:PTGFilterSection];
    NSMutableArray *filterArray = [[self.cellArray objectAtIndex:PTGFilterSection] mutableCopy];
    if(!sender.on){

        if([[self.sectionTableView cellForRowAtIndexPath:indexPath] isKindOfClass:[PTGVenuesCountSliderTableViewCell class]]){
            [filterArray  removeObject:@(PTGVenuesCountFilterItem)];
            [self.cellArray removeObjectAtIndex:PTGFilterSection];
            [self.cellArray insertObject:filterArray atIndex:PTGFilterSection];
            [self.sectionTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
        }
    }else{

        if(![[self.sectionTableView cellForRowAtIndexPath:indexPath] isKindOfClass:[PTGVenuesCountSliderTableViewCell class]]){
            [filterArray  insertObject:@(PTGVenuesCountFilterItem) atIndex:PTGVenuesCountFilterItem];
            [self.cellArray removeObjectAtIndex:PTGFilterSection];
            [self.cellArray insertObject:filterArray atIndex:PTGFilterSection];
            [self.sectionTableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }
}


- (IBAction)radiusSliderEnabled:(UISwitch *)sender {
  
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:([self.cellArray objectAtIndex:PTGFilterSection].count -1) inSection:PTGFilterSection];
    NSMutableArray *filterArray = [[self.cellArray objectAtIndex:PTGFilterSection] mutableCopy];
    if(!sender.on){
        
        if([[self.sectionTableView cellForRowAtIndexPath:indexPath] isKindOfClass:[PTGRadiusSliderTableViewCell class]]){
            [filterArray  removeObject:@(PTGRadiusFilterItem)];
            [self.cellArray removeObjectAtIndex:PTGFilterSection];
            [self.cellArray insertObject:filterArray atIndex:PTGFilterSection];
            [self.sectionTableView reloadSections:[NSIndexSet indexSetWithIndex:PTGFilterSection] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }else{
        if(![[self.sectionTableView cellForRowAtIndexPath:indexPath] isKindOfClass:[PTGRadiusSliderTableViewCell class]]){
            [filterArray  addObject:@(PTGRadiusFilterItem)];
            [self.cellArray removeObjectAtIndex:PTGFilterSection];
            [self.cellArray insertObject:filterArray atIndex:PTGFilterSection];
            [self.sectionTableView reloadSections:[NSIndexSet indexSetWithIndex:PTGFilterSection] withRowAnimation:UITableViewRowAnimationAutomatic];

        }
    }
}

@end