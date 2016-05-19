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

@interface PTGCoreDataHandler : NSObject

+ (NSFetchedResultsController *) searchScreenFetchedResultsControllerInContext:(NSManagedObjectContext *)context;
+ (PTGCategoryEntity *) insertCategoryWithName:(NSString *)name ID:(NSString *)categoryID andImageLocation:(NSString *)imageLocation inContext:(NSManagedObjectContext *) context;
@end
