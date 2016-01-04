//
//  MTNetworkCommentPack.h
//  mttt
//
//  Created by 张勐 on 16/1/4.
//  Copyright © 2016年 ZhangMeng. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "MTUserInfoPack.h"


@interface MTCommentPack : JSONModel

@property (strong, nonatomic) NSString <Optional> * comments;
@property (strong, nonatomic) MTUserInfoPack <Optional> * user;

@end
