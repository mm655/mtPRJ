//
//  MTNetworkFindPass.m
//  mttt
//
//  Created by 张勐 on 15/12/29.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import "MTNetworkFindPass.h"

@implementation MTNetworkFindPass

-(void)findpassWithEmailAddress:(NSString *)email resultBLock:(MTNetworkUniversalBlock)block
{
    MTNetworkHttpSession * session = [MTNetworkHttpSession new];
    [session oPostWithSubURL:MTFindPass params:@{@"email" : email} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        ;
    } success:^(NSObject *responseObj) {
        MTNetworkResponseBasePack * pack = [[MTNetworkResponseBasePack alloc] initWithDictionary:(NSDictionary *)responseObj error:nil];
        if([pack.status boolValue] == YES)
        {
            block(MTNetworkResultTypeSuccess,pack.message);
        }else{
            block(MTNetworkResultTypeError,pack.message);
        }
        ;
    } failure:^(NSString *failString) {
        block(MTNetworkResultTypeNetFail,failString);
    }];
}

@end
