//
//  MTPicInfoPack.h
//  mttt
//
//  Created by 张勐 on 15/12/30.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "MTNetworkTimePack.h"
#import "MTUserInfoPack.h"

@interface MTPicInfoPack : JSONModel

@property (strong, nonatomic) NSArray <Optional> * comment;
@property (strong, nonatomic) MTNetworkTimePack <Optional> * createTime;
@property (strong, nonatomic) NSString <Optional> * descriptions;
@property (strong, nonatomic) NSNumber <Optional> * fkUserId;
@property (strong, nonatomic) NSNumber <Optional> * picID;
@property (strong, nonatomic) NSString <Optional> * pictureUrl;
@property (strong, nonatomic) NSArray <Optional> * praise;
@property (strong, nonatomic) NSNumber <Optional> * praiseCount;
@property (strong, nonatomic) NSString <Optional> * showTime;
@property (strong, nonatomic) MTUserInfoPack <Optional> * user;

@end


