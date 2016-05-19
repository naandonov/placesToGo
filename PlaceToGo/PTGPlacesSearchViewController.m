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

@interface PTGPlacesSearchViewController () <UICollectionViewDelegate, UICollectionViewDataSource, NSURLSessionDelegate, NSURLSessionDownloadDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (weak, nonatomic) IBOutlet UIImageView *something;

@end

@implementation PTGPlacesSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.fetchedResultsController = [PTGCoreDataHandler searchScreenFetchedResultsControllerInContext:[[PTGCoreDataManager sharedManager] managedObjectContext]];
    PTGCategoriesRequest *req = [[PTGCategoriesRequest alloc] initWithParameters:nil];
    [req initializeSessionWithCompletition:^(NSArray<NSDictionary *> *dict, NSError *error) {
        NSLog(@"%@",dict);
        if (error) {
            NSLog(@"Error occured while receiving data from Foursquare! Details:\n%@",error.localizedDescription);
        }
    }];
    
    
    
}
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    NSData *data = [NSData dataWithContentsOfURL:location];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.something setImage:[UIImage imageWithData:data]];
    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)getCategories{
    if(self.fetchedResultsController.fetchedObjects.count == 0){
        PTGCategoryEntity *category = nil;
        PTGCategoriesRequest *req = [[PTGCategoriesRequest alloc] initWithParameters:nil];
        [req initializeSessionWithCompletition:^(NSArray<NSDictionary *> *dict, NSError *error) {
            NSLog(@"%@",dict);
            if (error) {
                NSLog(@"Error occured while receiving data from Foursquare! Details:\n%@",error.localizedDescription);
            }
        }];

    }
}

#pragma mark - UICollectionViewDataSource methods

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.fetchedResultsController.fetchedObjects.count;
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = nil;
    return cell;
}

@end
