//
//  MTNetworkUpLoadPic.h
//  mttt
//
//  Created by 张勐 on 15/12/27.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import "MTNetworkBase.h"

@interface MTNetworkUpLoadPic : MTNetworkBase

-(void) uploadPic : (UIImage *) pic userID : (NSNumber *) userID description : (NSString *) description block : (MTNetworkUniversalBlock) block;


@end
