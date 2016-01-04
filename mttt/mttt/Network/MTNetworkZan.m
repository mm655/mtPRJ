//
//  MTNetworkZan.m
//  mttt
//
//  Created by 张勐 on 16/1/4.
//  Copyright © 2016年 ZhangMeng. All rights reserved.
//

#import "MTNetworkZan.h"

@implementation MTNetworkZan

-(void)zanByUserId:(NSNumber *)myId picId:(NSNumber *)picId rBlock:(MTNetworkUniversalBlock)block
{
    MTNetworkHttpSession * session = [MTNetworkHttpSession new];
    [session oPostWithSubURL:MTNetworkZanURL params:@{@"userId" : myId, @"pictureId" : picId} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        ;
    } success:^(NSObject *responseObj) {
        ;
        MTNetworkResponseBasePack * rPack = [[MTNetworkResponseBasePack alloc] initWithDictionary:(NSDictionary *)responseObj error:nil];
        if([rPack.status boolValue] == 1)
        {
            block(MTNetworkResultTypeSuccess,nil);
        }else{
            block(MTNetworkResultTypeError,rPack.message);
        }
        ;
    } failure:^(NSString *failString) {
        ;
        block(MTNetworkResultTypeNetFail,failString);
    }];
}

@end
