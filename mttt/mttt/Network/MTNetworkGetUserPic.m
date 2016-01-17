//
//  MTNetworkGetUserPic.m
//  mttt
//
//  Created by 张勐 on 16/1/6.
//  Copyright © 2016年 ZhangMeng. All rights reserved.
//

#import "MTNetworkGetUserPic.h"
#import "MTPicInfoPack.h"
#import "MTNetworkGetUserPicResponseTopPack.h"

@implementation MTNetworkGetUserPic

-(void)getUserPicByUserID:(NSNumber *)userID page : (NSNumber *)page rBlock:(MTNetworkUniversalBlock)block
{
    MTNetworkHttpSession * sessoin = [MTNetworkHttpSession new];
    [sessoin oPostWithSubURL:MTNetworkGetUserPicURL params:@{@"fkUserId":userID,@"begin":page} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        ;
    } success:^(NSObject *responseObj) {
        MTNetworkGetUserPicResponseTopPack * rPack = [[MTNetworkGetUserPicResponseTopPack alloc] initWithDictionary:(NSDictionary *)responseObj error:nil];
        if([rPack.status boolValue] == YES)
        {
            NSMutableArray * rArray = [NSMutableArray array];
           
            for(NSDictionary * tmpDic in rPack.aResult.picList)
            {
                MTPicInfoPack * picInfo = [[MTPicInfoPack alloc] initWithDictionary:tmpDic error:nil];
                [rArray addObject:picInfo];
            }
            block(MTNetworkResultTypeSuccess,rArray);
        }else{
            block(MTNetworkResultTypeError,rPack.message);
        }
    } failure:^(NSString *failString) {
        block(MTNetworkResultTypeNetFail,failString);
        ;
    }];
}

-(void)getUserPicByUserID:(NSNumber *)userID rBlock:(MTNetworkUniversalBlock)block
{
    MTNetworkHttpSession * sessoin = [MTNetworkHttpSession new];
    [sessoin oPostWithSubURL:MTNetworkGetUserPicURL params:@{@"fkUserId":userID,@"begin":@(1)} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        ;
    } success:^(NSObject *responseObj) {
        MTNetworkGetUserPicResponseTopPack * rPack = [[MTNetworkGetUserPicResponseTopPack alloc] initWithDictionary:(NSDictionary *)responseObj error:nil];
        if([rPack.status boolValue] == YES)
        {
            NSMutableArray * rArray = [NSMutableArray array];
            
            for(NSDictionary * tmpDic in rPack.aResult.picList)
            {
                MTPicInfoPack * picInfo = [[MTPicInfoPack alloc] initWithDictionary:tmpDic error:nil];
                [rArray addObject:picInfo];
            }
            block(MTNetworkResultTypeSuccess,rArray);
        }else{
            block(MTNetworkResultTypeError,rPack.message);
        }
    } failure:^(NSString *failString) {
        block(MTNetworkResultTypeNetFail,failString);
        ;
    }];
}


@end
