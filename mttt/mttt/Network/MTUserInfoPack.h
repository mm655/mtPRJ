//
//  MTUserInfoPack.h
//  mttt
//
//  Created by 张勐 on 15/12/28.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface MTUserInfoPack : JSONModel

@property (strong, nonatomic) NSString <Optional> * userName;
@property (strong, nonatomic) NSString <Optional> * nickName;
@property (strong, nonatomic) NSNumber <Optional> * userID;
@property (strong, nonatomic) NSString <Optional> * headPic;
@property (strong, nonatomic) NSString <Optional> * myDescription;
@property (strong, nonatomic) NSString <Optional> * city;

@end
