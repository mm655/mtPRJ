//
//  MTSettingFlowLayoutBig.m
//  mttt
//
//  Created by 张勐 on 16/1/6.
//  Copyright © 2016年 ZhangMeng. All rights reserved.
//

#import "MTSettingFlowLayoutBig.h"

@implementation MTSettingFlowLayoutBig

-(instancetype)init
{
    self = [super init];
    self.itemSize = CGSizeMake(SCWidth, SCWidth);
    self.headerReferenceSize = CGSizeMake(SCWidth, 100);
    self.minimumInteritemSpacing = 1;
    self.minimumLineSpacing = 1;
    return self;
}

@end
