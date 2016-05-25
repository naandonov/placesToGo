//
//  PTGCoreDataHandler.h
//  PlaceToGo
//
//  Created by Veselin Cholakov on 5/17/16.
//  Copyright © 2016 Nikolay Andonov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PTGCategoryEntity.h"
#import "PTGUserSettingsEntity.h"
#import "PTGCoreDataManager.h"
#import "PTGAuthenticatedUserEntity.h"

@interface PTGCoreDataHandler : NSObject

+ (NSFetchedResultsController *) searchScreenFetchedResultsControllerInContext:(NSManagedObjectContext *)context;
+ (NSArray <PTGAuthenticatedUserEntity *> *)fetchAuthenticatedUsers:(NSManagedObjectContext *)context
                                                      withPredicate:(NSPredicate *)predicate
                                                              error:(NSError **)error;
+ (PTGAuthenticatedUserEntity *) insertAuthenticatedUserWithFirstName:(NSString *)firstName
                                                             lastName:(NSString *)lastName
                                                                email:(NSString *)email
                                                         andImagePath:(NSString *)imageLocation
                                                            inContext:(NSManagedObjectContext *) context;
+ (PTGCategoryEntity *) insertCategoryWithName:(NSString *)name ID:(NSString *)categoryID andImageLocation:(NSString *)imageLocation inContext:(NSManagedObjectContext *) context;
@end
