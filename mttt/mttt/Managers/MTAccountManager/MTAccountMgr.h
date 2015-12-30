//
//  MTAccountMgr.h
//  mttt
//
//  Created by 张勐 on 15/12/21.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTAccountInfo.h"

@interface MTAccountMgr : NSObject

+(MTAccountInfo *) getLoginInfo;

+(void) loginWithUserName : (NSString *) userName andUserID : (NSNumber *) userID;

+(void) logout;

+(void) setAccountInfo : (MTAccountInfo *) info;

+(NSArray *) getMainPageItemArray;
+(void) setMainPageItemArray : (NSArray *) array;

+(NSArray *) getUserItemArray;
+(void) setUserItemArray : (NSArray *) array;

+(NSArray *) getNearbyItemArray;
+(void) setNearbyItemArray : (NSArray *) array;



+(BOOL) isLogin;
+(NSString *) userName;
+(NSNumber *) userID;

@end
