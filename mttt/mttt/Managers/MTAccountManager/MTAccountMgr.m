//
//  MTAccountMgr.m
//  mttt
//
//  Created by 张勐 on 15/12/21.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import "MTAccountMgr.h"

@implementation MTAccountMgr

+(MTAccountInfo *)getLoginInfo
{
    MTAccountInfo * loginInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:[self getArchivePath]];
    return loginInfo;
}

+(NSString *) getArchivePath
{
    NSArray * tmpArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [tmpArray.firstObject stringByAppendingPathComponent:@"mtLoginInfo"];
}

+(void)loginWithUserName:(NSString *)userName andUserID:(NSNumber *)userID
{
    MTAccountInfo * myInfo = [[MTAccountInfo alloc] init];
    myInfo.loginState = @1;
    myInfo.userID = userID;
    myInfo.userName = userName;
    
    [NSKeyedArchiver archiveRootObject:myInfo toFile:[self getArchivePath]];
}

+(void)logout
{
    MTAccountInfo * myInfo = [[MTAccountInfo alloc] init];
    [NSKeyedArchiver archiveRootObject:myInfo toFile:[self getArchivePath]];
}


@end
