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
//    MTAccountInfo * myInfo = [[MTAccountInfo alloc] init];
    MTAccountInfo * myInfo = [self getLoginInfo];
    myInfo.loginState = @(0);
    [NSKeyedArchiver archiveRootObject:myInfo toFile:[self getArchivePath]];
}

+(BOOL)isLogin
{
    MTAccountInfo * info = [MTAccountMgr getLoginInfo];
    if([info.loginState boolValue])
    {
        return YES;
    }
    return NO;
}

+(NSString *)userName
{
    MTAccountInfo * info = [MTAccountMgr getLoginInfo];
    return info.userName;
}

+(NSNumber *) userID
{
    MTAccountInfo * info = [MTAccountMgr getLoginInfo];
    return info.userID;
}

+(NSArray *)getMainPageItemArray
{
    if([self isLogin])
    {
        NSString * basePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        NSString * finalPath = [NSString stringWithFormat:@"%@/%@_mainPageItem",basePath,[self userName]];
        
        NSArray * myArray = [NSKeyedUnarchiver unarchiveObjectWithFile:finalPath];
        return myArray;
    }else{
        NSLog(@"you can't call this method while not login");
        exit(1);
    }
    return nil;
}

+(void)setMainPageItemArray:(NSArray *)array
{
    if([self isLogin])
    {
        NSString * basePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        NSString * finalPath = [NSString stringWithFormat:@"%@/%@_mainPageItem",basePath,[self userName]];
        [NSKeyedArchiver archiveRootObject:array toFile:finalPath];
    }else{
        NSLog(@"you can't call this method while not login");
        exit(1);
    }
}

+(NSArray *)getMyItemArray
{
    if([self isLogin])
    {
        NSString * basePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        NSString * finalPath = [NSString stringWithFormat:@"%@/%@_myItemArray",basePath,[self userName]];
        
        NSArray * myArray = [NSKeyedUnarchiver unarchiveObjectWithFile:finalPath];
        return myArray;
    }else{
        NSLog(@"you can't call this method while not login");
        exit(1);
    }
    return nil;
}

+(void)setMyItemArray:(NSArray *)array
{
    if([self isLogin])
    {
        NSString * basePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        NSString * finalPath = [NSString stringWithFormat:@"%@/%@_myItemArray",basePath,[self userName]];
        [NSKeyedArchiver archiveRootObject:array toFile:finalPath];
    }else{
        NSLog(@"you can't call this method while not login");
        exit(1);
    }
}

+(NSArray *)getUserItemArray
{
    if([self isLogin])
    {
        NSString * basePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        NSString * finalPath = [NSString stringWithFormat:@"%@/%@_userItemArray",basePath,[self userName]];
        
        NSArray * myArray = [NSKeyedUnarchiver unarchiveObjectWithFile:finalPath];
        return myArray;
    }else{
        NSLog(@"you can't call this method while not login");
        exit(1);
    }
    return nil;
}

+(void)setUserItemArray:(NSArray *)array
{
    if([self isLogin])
    {
        NSString * basePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        NSString * finalPath = [NSString stringWithFormat:@"%@/%@_userItemArray",basePath,[self userName]];
        [NSKeyedArchiver archiveRootObject:array toFile:finalPath];
    }else{
        NSLog(@"you can't call this method while not login");
        exit(1);
    }
}

+(NSArray *)getMyFocusUser
{
    if([self isLogin])
    {
        NSString * basePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        NSString * finalPath = [NSString stringWithFormat:@"%@/%@_myFocusUser",basePath,[self userName]];
        
        NSArray * myArray = [NSKeyedUnarchiver unarchiveObjectWithFile:finalPath];
        return myArray;
    }else{
        NSLog(@"you can't call this method while not login");
        exit(1);
    }
    return nil;
}

+(void)setMyFocusUser:(NSArray *)array
{
    if([self isLogin])
    {
        NSString * basePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        NSString * finalPath = [NSString stringWithFormat:@"%@/%@_myFocusUser",basePath,[self userName]];
        [NSKeyedArchiver archiveRootObject:array toFile:finalPath];
    }else{
        NSLog(@"you can't call this method while not login");
        exit(1);
    }
 
}

+(NSArray *)getNearbyItemArray
{
    if([self isLogin])
    {
        NSString * basePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        NSString * finalPath = [NSString stringWithFormat:@"%@/%@_nearByItemArray",basePath,[self userName]];
        
        NSArray * myArray = [NSKeyedUnarchiver unarchiveObjectWithFile:finalPath];
        return myArray;
    }else{
        NSLog(@"you can't call this method while not login");
        exit(1);
    }
    return nil;
}

+(void)setNearbyItemArray:(NSArray *)array
{
    if([self isLogin])
    {
        NSString * basePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        NSString * finalPath = [NSString stringWithFormat:@"%@/%@_nearByItemArray",basePath,[self userName]];
        [NSKeyedArchiver archiveRootObject:array toFile:finalPath];
    }else{
        NSLog(@"you can't call this method while not login");
        exit(1);
    }
}

+(void)setAccountInfo:(MTAccountInfo *)info
{
    if(![NSKeyedArchiver archiveRootObject:info toFile:[self getArchivePath]])
    {
        NSLog(@"archeive error");
        exit(1);
    }
}

@end
