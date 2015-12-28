//
//  MTTestEntity+CoreDataProperties.h
//  mttt
//
//  Created by 张勐 on 15/12/28.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "MTTestEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface MTTestEntity (CoreDataProperties)

@property (nullable, nonatomic, retain) NSData *testA;
@property (nullable, nonatomic, retain) NSNumber *userID;

@end

NS_ASSUME_NONNULL_END
