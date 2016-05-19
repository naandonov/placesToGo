//
//  ViewController.m
//  PlaceToGo
//
//  Created by Nikolay Andonov on 5/11/16.
//  Copyright © 2016 Nikolay Andonov. All rights reserved.
//

#import "PTGPlacesSearchViewController.h"
#import "PTGVenueRequest.h"
#import "APIConstants.h"
#import "PTGCoreDataHandler.h"
#import "PTGCategoriesRequest.h"
#import "PTGCredentialStore.h"

@interface PTGPlacesSearchViewController () <UICollectionViewDelegate, UICollectionViewDataSource, NSFetchedResultsControllerDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;


@end

@implementation PTGPlacesSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fetchedResultsController = [PTGCoreDataHandler searchScreenFetchedResultsControllerInContext:[[PTGCoreDataManager sharedManager] managedObjectContext]];
    self.fetchedResultsController.delegate = self;
    NSError *error = nil;
    [self.fetchedResultsController performFetch:&error];
    [self getCategories];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - UICollectionViewDataSource methods

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.fetchedResultsController.fetchedObjects.count;
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = nil;
    return cell;
}

#pragma mark - Loading categories

-(void)getCategories{
    if(self.fetchedResultsController.fetchedObjects.count == 0){
        PTGCategoriesRequest *req = [[PTGCategoriesRequest alloc] initRequest];
        [req getCategoriesWithCompletion:^(NSArray<NSDictionary *> *dict, NSError *error) {
            NSArray *categoriesArray = dict;
            if (error) {
                NSLog(@"Error occured while receiving data from Foursquare! Details:\n%@",error.localizedDescription);
            }
            for (NSDictionary *currentRecord in categoriesArray) {
                [PTGCoreDataHandler insertCategoryWithName:[currentRecord valueForKey:nameKey]
                                                        ID:[currentRecord valueForKey:idKey]
                                          andImageLocation:[currentRecord valueForKey:iconPathKey]
                                                 inContext:[[PTGCoreDataManager sharedManager] managedObjectContext]];
                [[PTGCoreDataManager sharedManager] saveContext:[[PTGCoreDataManager sharedManager] managedObjectContext]];
            }
        }];
    }
}

@end