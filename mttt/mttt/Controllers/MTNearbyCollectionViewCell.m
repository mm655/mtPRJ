//
//  MTNearbyCollectionViewCell.m
//  motu
//
//  Created by 张勐 on 15/11/21.
//  Copyright © 2015年 ___ZM___. All rights reserved.
//

#import "MTNearbyCollectionViewCell.h"

@implementation MTNearbyCollectionViewCell
{
//    UIImageView * _mainImageView;
}
-(instancetype)init
{
    self = [super init];
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    UIImageView * backImageView = [[UIImageView alloc] init];
    _mainImageView = backImageView;
    [self addSubview:backImageView];
    PREPCONSTRAINTS(backImageView);
    ALIGN_TOP(backImageView, 0);
    ALIGN_BOTTOM(backImageView, 0);
    ALIGN_RIGHT(backImageView, 0);
    ALIGN_LEFT(backImageView, 0);
    backImageView.tag = 10002;
    
    return self;
}

-(void)setMainImage:(UIImage *)mainImage
{
    self.mainImageView.image = mainImage;
}

@end
