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
#import "PTGLoginViewController.h"
#import "PTGAuthenticationRequest.h"
#import "PTGUserInformationRequest.h"
#import "PTGCoreDataHandler.h"

@interface PTGMenuViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *sectionTableView;
@property (nonatomic, strong) NSArray <PTGAuthenticatedUserEntity *> *authenticatedUsers;

@end
NSString *const kLoginScreenID = @"PTGLoginViewController";
NSString *const kUserInformationCellID = @"UserInfoCell";
NSString *const kResponseKey = @"response";
NSString *const kUserKey = @"user";
NSString *const kFirstNameKey = @"firstName";
NSString *const kLastNameKey = @"lastName";
NSString *const kEmailKey = @"email";
NSString *const kPhotoKey = @"photo";
NSString *const kPhotoPrefixKey = @"prefix";
NSString *const kPhotoSize = @"100x100";
NSString *const kPhotoSuffixKey = @"suffix";

@implementation PTGMenuViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.sectionTableView.delegate = self;
    self.sectionTableView.dataSource = self;
    self.sectionTableView.scrollEnabled = NO;
    self.sectionTableView.allowsSelection = NO;
    
}



- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSError *error = nil;
    self.authenticatedUsers = [PTGCoreDataHandler fetchAuthenticatedUsers:[[PTGCoreDataManager sharedManager] managedObjectContext] withPredicate:nil error:&error];
    if([PTGCredentialStore isThereAuthenticatedUser] && self.authenticatedUsers.count == 0){
        [[PTGNetworkManager sharedManager] taskWithRequest:[[PTGUserInformationRequest alloc] initWithUserID:nil] completion:^(NSData *data, NSURLResponse *response, NSError *error) {
            NSDictionary *userJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            userJSON = [userJSON valueForKey:kResponseKey];
            
            userJSON = [userJSON valueForKey:kUserKey];
            NSString *firstName =[userJSON valueForKey:kFirstNameKey];
            NSString *lastName =[userJSON valueForKey:kLastNameKey];
            NSString *email = [userJSON valueForKey:kEmailKey];
            NSDictionary *photo = [userJSON valueForKey:kPhotoKey];
            NSString *imagePath = [photo valueForKey:kPhotoPrefixKey];
            imagePath = [imagePath stringByAppendingPathComponent:kPhotoSize];
            imagePath = [imagePath stringByAppendingPathComponent:kPhotoSuffixKey];
            [PTGCoreDataHandler insertAuthenticatedUserWithFirstName:firstName lastName:lastName email:email andImagePath:imagePath inContext:[[PTGCoreDataManager sharedManager] managedObjectContext]];
            dispatch_async(dispatch_get_main_queue(), ^{
                NSError *fetchError = nil;
                self.authenticatedUsers = [PTGCoreDataHandler fetchAuthenticatedUsers:[[PTGCoreDataManager sharedManager] managedObjectContext] withPredicate:nil error:&fetchError];
            });
        }];
        
    }
    if(error){
        NSLog(@"An error occured while fetching local user data. Please see the description below:\n%@",error.localizedDescription);
    }
    [self.sectionTableView reloadData];
}

#pragma mark - UITableViewDelegate methods


#pragma mark - UITableViewDataSource methods

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PTGUserInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:kUserInformationCellID];
    
    //TODO: Add the following items: image and email for user info cell, user settings
    if([PTGCredentialStore isThereAuthenticatedUser]){
        cell.nameLabel.hidden = NO;
        cell.nameValueLabel.hidden = NO;
        NSString *firstName = [[self.authenticatedUsers firstObject] firstName];
        cell.nameValueLabel.text = [firstName stringByAppendingFormat:@" %@",[[self.authenticatedUsers firstObject] lastName]];
        cell.statusLabel.text = @"Active";
        [cell.loginButton setTitle:@"Logout" forState:UIControlStateNormal];
        [cell.loginButton addTarget:self action:@selector(logoutAction:) forControlEvents:UIControlEventTouchDown];
        
        
    }else{
        cell.statusLabel.text = @"Not active";
        cell.nameLabel.hidden = YES;
        cell.nameValueLabel.hidden = YES;
        [cell.loginButton setTitle:@"Log In" forState:UIControlStateNormal];
        [cell.loginButton addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchDown];
    }
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return section?@"Settings":@"User information";
}


#pragma mark - Button actions - login/logout

- (void)logoutAction:(PTGLoginButton *) sender{
    [sender removeTarget:self action:@selector(logoutAction:) forControlEvents:UIControlEventTouchDown];
    [PTGCredentialStore deleteAccessToken];
    
    [self.sectionTableView reloadData];
    
    NSLog(@"no user");
}

- (void)loginAction:(PTGLoginButton *)sender {
    [sender removeTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchDown];
    
    PTGLoginViewController *loginViewController = [self.storyboard instantiateViewControllerWithIdentifier:kLoginScreenID];
    [self presentViewController:loginViewController animated:YES completion:nil];
    
}


@end