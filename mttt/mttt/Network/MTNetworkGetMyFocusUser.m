//
//  MTNetworkGetMyFocusUser.m
//  mttt
//
//  Created by 张勐 on 16/1/6.
//  Copyright © 2016年 ZhangMeng. All rights reserved.
//

#import "MTNetworkGetMyFocusUser.h"
#import "MTNetworkGetMyFocusResponsePack.h"
#import "MTUserInfoPack.h"

@implementation MTNetworkGetMyFocusUser

-(void)getMyFocusUserByID:(NSNumber *)userID rBlock:(MTNetworkUniversalBlock)block
{
    MTNetworkHttpSession * session = [MTNetworkHttpSession new];
    [session oPostWithSubURL:MTNetworkGetMyFocus params:@{@"userId" : userID,@"begin" : @(1)} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        ;
    } success:^(NSObject *responseObj) {
        MTNetworkGetMyFocusResponsePack * rPack = [[MTNetworkGetMyFocusResponsePack alloc] initWithDictionary:(NSDictionary *)responseObj error:nil];
        if([rPack.status boolValue] == YES)
        {
            NSMutableArray * rArray = [NSMutableArray array];
            for(NSDictionary * tmpDic in rPack.aResult.userList)
            {
                MTUserInfoPack * userPack = [[MTUserInfoPack alloc] initWithDictionary:tmpDic error:nil];
                [rArray addObject:userPack];
            }
            block(MTNetworkResultTypeSuccess,rArray);
        }else{
            block(MTNetworkResultTypeError,(NSString *)rPack.message);
        }
    } failure:^(NSString *failString) {
        block(MTNetworkResultTypeNetFail,failString);
    }];
}

@end
