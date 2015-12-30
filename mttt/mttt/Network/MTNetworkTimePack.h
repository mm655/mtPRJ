//
//  MTNetworkTimePack.h
//  mttt
//
//  Created by 张勐 on 15/12/30.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface MTNetworkTimePack : JSONModel
@property (strong, nonatomic) NSNumber <Optional> * date;
@property (strong, nonatomic) NSNumber <Optional> * day;
@property (strong, nonatomic) NSNumber <Optional> * hours;
@property (strong, nonatomic) NSNumber <Optional> * minutes;
@property (strong, nonatomic) NSNumber <Optional> * month;
@property (strong, nonatomic) NSNumber <Optional> * seconds;
@property (strong, nonatomic) NSNumber <Optional> * time;
@property (strong, nonatomic) NSNumber <Optional> * year;

@end
