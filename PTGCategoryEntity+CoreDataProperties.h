//
//  PTGCategoryEntity+CoreDataProperties.h
//  PlaceToGo
//
//  Created by Veselin Cholakov on 5/17/16.
//  Copyright © 2016 Nikolay Andonov. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "PTGCategoryEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTGCategoryEntity (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *id;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *imageLocation;

@end

NS_ASSUME_NONNULL_END
