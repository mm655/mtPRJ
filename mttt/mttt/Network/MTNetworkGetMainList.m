//
//  MTNetworkGetMainList.m
//  mttt
//
//  Created by 张勐 on 15/12/30.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import "MTNetworkGetMainList.h"
#import "MTNetworkGetMainListResponseTopPack.h"
#import "MTNetworkGetMainListResultPack.h"
#import "MTPicInfoPack.h"

@implementation MTNetworkGetMainList

-(void)getMainListByUserID:(NSNumber *)userID andBeginPage:(NSNumber *)beginPage resultBlock:(MTNetworkUniversalBlock)block
{
    MTNetworkHttpSession * session = [MTNetworkHttpSession new];
    [session oPostWithSubURL:MTGetMainList params:@{@"userId" : userID,@"begin" : beginPage} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        ;
    } success:^(NSObject *responseObj) {
        MTNetworkResponseBasePack * pack = [[MTNetworkResponseBasePack alloc] initWithDictionary:(NSDictionary *)responseObj error:nil];
        if([pack.status boolValue] == YES)
        {
            MTNetworkGetMainListResponseTopPack * rspPack = [[MTNetworkGetMainListResponseTopPack alloc] initWithDictionary:(NSDictionary *)responseObj error:nil];
            MTNetworkGetMainListResultPack * rstPack = [[MTNetworkGetMainListResultPack alloc] initWithDictionary:rspPack.result error:nil];
            NSMutableArray * resultArray = [NSMutableArray array];
            for(NSDictionary * tmpDic in rstPack.picList)
            {
                MTPicInfoPack * infoPack = [[MTPicInfoPack alloc] initWithDictionary:tmpDic error:nil];
                [resultArray addObject:infoPack];
            }
            block(MTNetworkResultTypeSuccess,resultArray);
        }else{
            block(MTNetworkResultTypeError,pack.message);
        }
    } failure:^(NSString *failString) {
        block(MTNetworkResultTypeNetFail, failString);
    }];
}

@end
