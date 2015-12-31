//
//  MTNetworkGetAllPictureList.m
//  mttt
//
//  Created by 张勐 on 15/12/30.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import "MTNetworkGetAllPictureList.h"
#import "MTPicInfoPack.h"
@implementation MTNetworkGetAllPictureList


-(void)getAllPictureByPage:(NSNumber *)page resultBlock:(MTNetworkUniversalBlock)block
{
    MTNetworkHttpSession * session = [MTNetworkHttpSession new];
    
    [session oPostWithSubURL:MTGetAllPictureList params:@{@"begin" : page} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        ;
    } success:^(NSObject *responseObj) {
        MTNetworkResponseBasePack * pack = [[MTNetworkResponseBasePack alloc] initWithDictionary:(NSDictionary *)responseObj error:nil];
//        NSLog(@"%@",pack);
        if([pack.status boolValue] == YES)
        {
            NSMutableArray * rstArray = [NSMutableArray array];
            for(NSDictionary * tmpDic in pack.result[@"picList"])
            {
                MTPicInfoPack * infoPack = [[MTPicInfoPack alloc] initWithDictionary:tmpDic error:nil];
                [rstArray addObject:infoPack];
            }
            
            block(MTNetworkResultTypeSuccess,rstArray);
        }else{
            block(MTNetworkResultTypeError, pack.message);
        }
        ;
    } failure:^(NSString *failString) {
        block(MTNetworkResultTypeNetFail, failString);
//        NSLog(@"failString : %@",failString);
    }];
}

@end
