//
//  MTNetworkAddComment.m
//  mttt
//
//  Created by 张勐 on 16/1/4.
//  Copyright © 2016年 ZhangMeng. All rights reserved.
//

#import "MTNetworkAddComment.h"

@implementation MTNetworkAddComment

-(void)commentByUserID:(NSNumber *)userID picID:(NSNumber *)picID comments:(NSString *)comments rBlock:(MTNetworkUniversalBlock)block
{
    MTNetworkHttpSession * session = [MTNetworkHttpSession new];
    
    [session oPostWithSubURL:MTAddComments params:@{@"userId" : userID,@"pictureId" : picID, @"comments" : comments} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        ;
    } success:^(NSObject *responseObj) {
        MTNetworkResponseBasePack * rPack = [[MTNetworkResponseBasePack alloc] initWithDictionary:(NSDictionary *)responseObj error:nil];
        if([rPack.status boolValue] == 1)
        {
            block(MTNetworkResultTypeSuccess,nil);
        }else{
            block(MTNetworkResultTypeError,rPack.message);
        }
        ;
    } failure:^(NSString *failString) {
        block(MTNetworkResultTypeNetFail,failString);
        ;
    }];
}

@end
