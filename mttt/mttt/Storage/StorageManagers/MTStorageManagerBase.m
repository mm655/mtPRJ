//
//  MTStorageManagerBase.m
//  mttt
//
//  Created by 张勐 on 15/12/28.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import "MTStorageManagerBase.h"

@implementation MTStorageManagerBase

-(NSManagedObjectContext *)sharedContext
{
    return [NSManagedObjectContext MR_rootSavingContext];
}

+(NSManagedObjectContext *)sharedContext
{
    return [NSManagedObjectContext MR_rootSavingContext];
}
@end
