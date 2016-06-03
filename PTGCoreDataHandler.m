//
//  PTGCoreDataHandler.m
//  PlaceToGo
//
//  Created by Veselin Cholakov on 5/17/16.
//  Copyright © 2016 Nikolay Andonov. All rights reserved.
//

#import "PTGCoreDataHandler.h"
#import "PTGAuthenticatedUserEntity.h"
#import "PTGUserSettingsEntity.h"

@implementation PTGCoreDataHandler

#pragma mark - NSFetchedResultsController
+ (NSFetchedResultsController *) searchScreenFetchedResultsControllerInContext:(NSManagedObjectContext *)context{
    NSFetchedResultsController *fetchedRC = nil;
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([PTGCategoryEntity class])];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    fetchRequest.sortDescriptors = @[sortDescriptor];
    fetchedRC = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest
                                                   managedObjectContext:[[PTGCoreDataManager sharedManager] managedObjectContext]
                                                     sectionNameKeyPath:nil
                                                              cacheName:nil];
    
    return fetchedRC;
}

#pragma mark - CoreData fetch requests

+ (NSArray <PTGAuthenticatedUserEntity *> *)fetchAuthenticatedUsers:(NSManagedObjectContext *)context
                                                      withPredicate:(NSPredicate *)predicate
                                                              error:(NSError **)error {
    
    __block NSArray <PTGAuthenticatedUserEntity *> *resultArray = nil;
    [context performBlockAndWait:^{
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([PTGAuthenticatedUserEntity class])];
        NSError *fetchError = nil;
        [fetchRequest setPredicate:predicate];
        resultArray = [context executeFetchRequest:fetchRequest error:&fetchError];
        
        if (fetchError) {
            *error = fetchError;
        }
    }];
    
    return resultArray;
}

+ (PTGUserSettingsEntity *)fetchUserSettingsInContext:(NSManagedObjectContext *)context
                                                error:(NSError **)error{
    __block NSArray <PTGUserSettingsEntity *> *resultArray = nil;
    [context performBlockAndWait:^{
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([PTGUserSettingsEntity class])];
        NSError *fetchError = nil;
        resultArray = [context executeFetchRequest:fetchRequest error:&fetchError];
        if(fetchError){
            *error = fetchError;
        }
    }];
    PTGUserSettingsEntity *settings = [resultArray firstObject];
    return settings;
}

#pragma mark - CoreData insert methods
//TODO: create a new insert method with only managed object context as parameter
+ (PTGUserSettingsEntity *)insertUserSettingsWithCountLimit:(NSNumber *)countLimit
                                                     radius:(NSNumber *)radius
                                     closedVenuesVisibility:(BOOL) closedVenuesVisibility
                                                 andSorting:(NSNumber *)sorting
                                                  inContext:(NSManagedObjectContext *)context{
    __block PTGUserSettingsEntity *settings = nil;
    [context performBlockAndWait:^{
        settings = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([PTGUserSettingsEntity class]) inManagedObjectContext:context];
        [settings setCountLimit:countLimit];
        [settings setRadius: radius];
        NSNumber *showClosedVenues = [NSNumber numberWithBool:closedVenuesVisibility];
        [settings setShowClosedVenues:showClosedVenues];
        [settings setSorting:sorting];
    }];
    
    
    return settings;
}

+ (PTGCategoryEntity *)insertCategoryWithName:(NSString *)name ID:(NSString *)categoryID andImageLocation:(NSString *)imageLocation inContext:(NSManagedObjectContext *) context{
    __block PTGCategoryEntity *category = nil;
    [context performBlockAndWait:^{
        category = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([PTGCategoryEntity class]) inManagedObjectContext:context];
        [category setId:categoryID];
        [category setName:name];
        [category setImageLocation:imageLocation];
    }];
    return category;
}

+ (PTGAuthenticatedUserEntity *)insertAuthenticatedUserWithFirstName:(NSString *)firstName
                                                            lastName:(NSString *)lastName
                                                               email:(NSString *)email
                                                        andImagePath:(NSString *)imageLocation
                                                           inContext:(NSManagedObjectContext *) context{
    __block PTGAuthenticatedUserEntity *authenticatedUser = nil;
    [context performBlockAndWait:^{
        authenticatedUser = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([PTGAuthenticatedUserEntity class]) inManagedObjectContext:context];
        [authenticatedUser setFirstName:firstName];
        [authenticatedUser setLastName:lastName];
        [authenticatedUser setEmail:email];
        [authenticatedUser setImagePath:imageLocation];
    }];
    return authenticatedUser;
}

@end