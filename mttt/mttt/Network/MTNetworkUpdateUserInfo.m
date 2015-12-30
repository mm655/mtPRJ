//
//  MTNetworkUpdateUserInfo.m
//  mttt
//
//  Created by 张勐 on 15/12/30.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import "MTNetworkUpdateUserInfo.h"

@implementation MTNetworkUpdateUserInfo

-(void)updateUserInfoWithHeadPic:(UIImage *)headPic nickName:(NSString *)nickName city:(NSString *)city description:(NSString *)description userID:(NSNumber *)userID resultBlock:(MTNetworkUniversalBlock)block
{
    MTNetworkHttpSession * session = [MTNetworkHttpSession new];
    
    [session postWithSubURL:MTUpdateUserInfo params:@{@"nickName" : nickName,@"city" : city,@"description" : description,@"id" : userID} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
       
        NSData * headData = UIImagePNGRepresentation(headPic);
        if(!headData)
        {
            headData = UIImageJPEGRepresentation(headPic, 1.0f);
        }
        [formData appendPartWithFileData:headData name:@"headPic" fileName:@"headPic" mimeType:@"image/jpeg"];
        
        [formData appendPartWithFileData:[nickName dataUsingEncoding:NSUTF8StringEncoding] name:@"nickName" fileName:@"nickName" mimeType:@"text/json"];
        [formData appendPartWithFileData:[city dataUsingEncoding:NSUTF8StringEncoding] name:@"city" fileName:@"city" mimeType:@"text/json"];
        [formData appendPartWithFileData:[description dataUsingEncoding:NSUTF8StringEncoding] name:@"description" fileName:@"description" mimeType:@"text/json"];
        [formData appendPartWithFileData:[NSKeyedArchiver archivedDataWithRootObject:userID] name:@"id" fileName:@"id" mimeType:@"text/json"];
        
    } success:^(NSObject *responseObj) {
        MTNetworkResponseBasePack * pack = [[MTNetworkResponseBasePack alloc] initWithDictionary:(NSDictionary *)responseObj error:nil];
        NSLog(@"responseObj : %@  \n  %@",responseObj, pack);

        
        ;
    } failure:^(NSString *failString) {
        ;
    } completeBlock:^(CGFloat completion) {
        NSLog(@"completion : %f",completion);
    }];
}

@end
