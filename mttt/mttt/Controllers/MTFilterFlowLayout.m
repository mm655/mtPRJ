//
//  MTFilterFlowLayout.m
//  mttt
//
//  Created by 张勐 on 15/12/26.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import "MTFilterFlowLayout.h"

@implementation MTFilterFlowLayout

-(instancetype)initWithItemHeight:(CGFloat)height
{
    self = [super init];
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.itemSize = CGSizeMake(height, height);
    self.minimumInteritemSpacing = 20;
    
    return self;
}

@end
