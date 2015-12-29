//
//  MTNetworkUpLoadPic.m
//  mttt
//
//  Created by 张勐 on 15/12/27.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import "MTNetworkUpLoadPic.h"

@implementation MTNetworkUpLoadPic

-(void)uploadPic:(UIImage *)pic userID:(NSNumber *)userID description:(NSString *)description block:(MTNetworkUniversalBlock)block cccBlock:(cccBlock)cccblock
{
    MTAccountInfo * info = [MTAccountMgr getLoginInfo];
    
    MTNetworkHttpSession * session = [MTNetworkHttpSession new];
    
    [session postWithSubURL:MTUpPicture params:@{@"userId" : info.userID, @"descriptions" : description} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSData * picData = UIImagePNGRepresentation(pic);
        if(!picData)
        {
            picData = UIImageJPEGRepresentation(pic, 1.0f);
        }
        [formData appendPartWithFileData:picData  name:@"picture" fileName:@"picture" mimeType:@"image/png"];
        [formData appendPartWithFileData:[description dataUsingEncoding:NSUTF8StringEncoding] name:@"descriptions" fileName:@"descriptions" mimeType:@"text/json"];
    } success:^(NSObject *responseObj) {
        MTNetworkResponseBasePack * pack = [[MTNetworkResponseBasePack alloc] initWithDictionary:(NSDictionary *)responseObj error:nil];
        NSLog(@"s responseObj : %@",pack);
        
        if([pack.status boolValue] == 1)
        {
            block(MTNetworkResultTypeSuccess,pack.message);
        }else{
            block(MTNetworkResultTypeError,pack.message);
        }
        
    } failure:^(NSString *failString) {
//        NSLog(@"f info : %@",failString);
        block(MTNetworkResultTypeNetFail,failString);
        ;
    } completeBlock:^(CGFloat completion) {
        cccblock(completion,nil);
    }];
    ;
}

@end
