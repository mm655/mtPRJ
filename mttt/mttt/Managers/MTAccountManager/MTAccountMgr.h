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

+(BOOL) isLogin;
+(NSString *) userName;

@end
