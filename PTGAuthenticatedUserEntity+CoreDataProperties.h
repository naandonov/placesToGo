//
//  PTGAuthenticatedUserEntity+CoreDataProperties.h
//  PlaceToGo
//
//  Created by Veselin Cholakov on 5/25/16.
//  Copyright © 2016 Nikolay Andonov. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "PTGAuthenticatedUserEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTGAuthenticatedUserEntity (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *firstName;
@property (nullable, nonatomic, retain) NSString *lastName;
@property (nullable, nonatomic, retain) NSString *email;
@property (nullable, nonatomic, retain) NSString *imagePath;

@end

NS_ASSUME_NONNULL_END
