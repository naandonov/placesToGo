//
//  PTGCoreDataHandler.m
//  PlaceToGo
//
//  Created by Veselin Cholakov on 5/17/16.
//  Copyright © 2016 Nikolay Andonov. All rights reserved.
//

#import "PTGCoreDataHandler.h"

@implementation PTGCoreDataHandler

#pragma mark - NSFetchedResultsController
+ (NSFetchedResultsController *) searchScreenFetchedResultsControllerInContext:(NSManagedObjectContext *)context{
    NSFetchedResultsController *fetchedRC = nil;
    fetchedRC = [[NSFetchedResultsController alloc]initWithFetchRequest:[NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([PTGCategoryEntity class])]
                                                   managedObjectContext:[[PTGCoreDataManager sharedManager] managedObjectContext]
                                                     sectionNameKeyPath:nil
                                                              cacheName:nil];
    
    return fetchedRC;
}

#pragma mark - CoreData insert methods

+ (PTGCategoryEntity *) insertCategoryWithName:(NSString *)name ID:(NSString *)categoryID andImageLocation:(NSString *)imageLocation inContext:(NSManagedObjectContext *) context{
    __block PTGCategoryEntity *category = nil;
    [context performBlockAndWait:^{
        category = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([PTGCategoryEntity class]) inManagedObjectContext:context];
        [category setId:categoryID];
        [category setName:name];
        [category setImageLocation:imageLocation];
    }];
    return category;
}


@end
