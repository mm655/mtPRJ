//
//  MTStorageManagerBase.h
//  mttt
//
//  Created by 张勐 on 15/12/28.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTStorageManagerBase : NSObject

@property (strong, nonatomic) NSManagedObjectContext * sharedContext;

+(NSManagedObjectContext *) sharedContext;

@end
