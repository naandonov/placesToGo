//
//  PTGUserSettingsEntity+CoreDataProperties.h
//  PlaceToGo
//
//  Created by Veselin Cholakov on 5/26/16.
//  Copyright © 2016 Nikolay Andonov. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "PTGUserSettingsEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTGUserSettingsEntity (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *countLimit;
@property (nullable, nonatomic, retain) NSNumber *radius;
@property (nullable, nonatomic, retain) NSNumber *sorting;
@property (nullable, nonatomic, retain) NSNumber *showClosedVenues;

@end

NS_ASSUME_NONNULL_END
