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
#import "PTGCategoryCollectionViewCell.h"
#import "UIColor+PTGColor.h"


@interface PTGPlacesSearchViewController () <UICollectionViewDelegate, UICollectionViewDataSource, NSFetchedResultsControllerDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;


@end

@implementation PTGPlacesSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;

    self.fetchedResultsController = [PTGCoreDataHandler searchScreenFetchedResultsControllerInContext:[[PTGCoreDataManager sharedManager] managedObjectContext]];
    self.fetchedResultsController.delegate = self;
    NSError *error = nil;
    [self.fetchedResultsController performFetch:&error];
    [self getCategories];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UICollectionViewDelegate methods

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
   [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{

}

#pragma mark - UICollectionViewDataSource methods

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.fetchedResultsController.fetchedObjects.count;
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PTGCategoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([PTGCategoryCollectionViewCell class]) forIndexPath:indexPath];
    PTGCategoryEntity *currentCategory = [self.fetchedResultsController objectAtIndexPath:indexPath];
    NSString *documentsDirectory = nil;
    NSArray *paths = nil;
    paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    documentsDirectory = [paths objectAtIndex:0];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:currentCategory.imageLocation];
    cell.categoryImageView.image = [UIImage imageWithContentsOfFile:documentsDirectory];
    cell.categoryNameLabel.text = currentCategory.name;
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
                [PTGCoreDataHandler insertCategoryWithName:[currentRecord valueForKey:kNameKey]
                                                        ID:[currentRecord valueForKey:kIDKey]
                                          andImageLocation:[currentRecord valueForKey:kIconPathKey]
                                                 inContext:[[PTGCoreDataManager sharedManager] managedObjectContext]];
                [[PTGCoreDataManager sharedManager] saveContext:[[PTGCoreDataManager sharedManager] managedObjectContext]];
            }
            NSError *fetchError = nil;
            [self.fetchedResultsController performFetch:&fetchError];
            if (fetchError) {
                NSLog(@"Error occured during second fetch of categories! Please refer to the following description:\n%@",error.localizedDescription);
            }
            [self.collectionView reloadData];

        }];
        
    }
}

@end