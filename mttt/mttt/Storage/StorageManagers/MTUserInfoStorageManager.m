
//
//  MTUserInfoStorageManager.m
//  mttt
//
//  Created by 张勐 on 15/12/28.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import "MTUserInfoStorageManager.h"

@implementation MTUserInfoStorageManager

+(void)setNewUserInfo:(MTUserInfoPack *)userInfo
{
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"userID == %@",userInfo.userID];
    
    UserInfo * info = [UserInfo MR_findAllWithPredicate:predicate inContext:[self sharedContext]].firstObject;
    
//    UserInfo * info = [UserInfo MR_findAllWithPredicate:predicate].firstObject;
    [info MR_inContext:[self sharedContext]];
    if(info == nil)
    {
        info = [UserInfo MR_createEntityInContext:[self sharedContext]];
    }
    
    [self setSInfo:info withPackInfo:userInfo];
    
    NSError * error;
    if([[self sharedContext] save:&error])
    {
//        NSLog(@"save success");
    }else{
        NSLog(@"save error info is : %@",error.localizedDescription);
        exit(1);
    }
}

+(MTUserInfoPack *)getUserInfoByID:(NSNumber *)userID
{
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"userID == %@",userID];
    UserInfo * info = [UserInfo MR_findAllWithPredicate:predicate].firstObject;
    MTUserInfoPack * pack = [MTUserInfoPack new];
    [self setPInfo:pack withStorageInfo:info];
    return pack;
}

+(void) setSInfo : (UserInfo *) sInfo withPackInfo : (MTUserInfoPack *) pInfo
{
    sInfo.userName = [NSString stringWithFormat:@"%@",pInfo.userName];
    sInfo.userID = @([pInfo.userID intValue]);
    sInfo.myDescription = [NSString stringWithFormat:@"%@",pInfo.myDescription];
    sInfo.city = [NSString stringWithFormat:@"%@",pInfo.city];
    sInfo.nickName = [NSString stringWithFormat:@"%@",pInfo.nickName];
    sInfo.headPic = [NSString stringWithFormat:@"%@",pInfo.headPic];
}

+(void) setPInfo : (MTUserInfoPack *) pInfo withStorageInfo : (UserInfo *) sInfo
{
    pInfo.userName = [NSString stringWithFormat:@"%@",sInfo.userName];
    pInfo.userID = @([sInfo.userID intValue]);
    pInfo.myDescription = [NSString stringWithFormat:@"%@",sInfo.myDescription];
    pInfo.city = [NSString stringWithFormat:@"%@",sInfo.city];
    pInfo.nickName = [NSString stringWithFormat:@"%@",sInfo.nickName];
    pInfo.headPic = [NSString stringWithFormat:@"%@",sInfo.headPic];
}

@end
