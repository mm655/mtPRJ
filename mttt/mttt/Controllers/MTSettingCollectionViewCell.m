//
//  MTSettingCollectionViewCell.m
//  mttt
//
//  Created by 张勐 on 16/1/6.
//  Copyright © 2016年 ZhangMeng. All rights reserved.
//

#import "MTSettingCollectionViewCell.h"

@implementation MTSettingCollectionViewCell
{
    UIButton * _mainButton;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    _mainButton = [[UIButton alloc] init];
    _mainButton.userInteractionEnabled = NO;
    [self addSubview:_mainButton];
    PREPCONSTRAINTS(_mainButton);
    ALIGN_LEFT(_mainButton, 0);
    ALIGN_TOP(_mainButton, 0);
    ALIGN_RIGHT(_mainButton, 0);
    ALIGN_BOTTOM(_mainButton, 0);
    
    return self;
}

-(void)setInfoPack:(MTPicInfoPack *)infoPack
{
    _infoPack = infoPack;
    [_mainButton sd_setBackgroundImageWithURL:[NSURL URLWithString:infoPack.pictureUrl] forState:UIControlStateNormal];
}

@end
