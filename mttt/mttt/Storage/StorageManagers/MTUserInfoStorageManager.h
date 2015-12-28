//
//  MTUserInfoStorageManager.h
//  mttt
//
//  Created by 张勐 on 15/12/28.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTUserInfoPack.h"
#import "UserInfo+CoreDataProperties.h"

@interface MTUserInfoStorageManager : NSObject

+(void) setNewUserInfo : (MTUserInfoPack *) userInfo;

+(MTUserInfoPack *) getUserInfoByID : (NSNumber *) userID;

@end
