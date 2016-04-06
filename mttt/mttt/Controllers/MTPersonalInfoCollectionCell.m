//
//  MTPersonalInfoCollectionCell.m
//  mttt
//
//  Created by pengkuncai on 16/1/17.
//  Copyright © 2016年 ZhangMeng. All rights reserved.
//

#import "MTPersonalInfoCollectionCell.h"


@implementation MTPersonalInfoCollectionCell
{
    UIImageView *_iconImgView;
    UILabel *_nickName;
    UILabel *_publishTime;
    UIButton *_mainButton;
}

//-(instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    _mainButton = [[UIButton alloc] init];
//    _mainButton.userInteractionEnabled = NO;
//    [self addSubview:_mainButton];
//    PREPCONSTRAINTS(_mainButton);
//    ALIGN_LEFT(_mainButton, 0);
//    ALIGN_TOP(_mainButton, 0);
//    ALIGN_RIGHT(_mainButton, 0);
//    ALIGN_BOTTOM(_mainButton, 0);
//    
//    
//    
//    return self;
//}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initWithCellUI];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)initWithCellUI
{
    _mainButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 40, SCWidth, self.height - 40)];
    _mainButton.userInteractionEnabled = NO;
    [self addSubview:_mainButton];
//    PREPCONSTRAINTS(_mainButton);
//    ALIGN_LEFT(_mainButton, 0);
//    ALIGN_TOP(_mainButton, 30);
//    ALIGN_RIGHT(_mainButton, 0);
//    ALIGN_BOTTOM(_mainButton, 0);
    
    _iconImgView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 0, 40, 40)];
    [self addSubview:_iconImgView];
//    PREPCONSTRAINTS(_iconImgView);
//    ALIGN_TOP(_iconImgView, 0);
//    ALIGN_LEFT(_iconImgView, 20);
//    ALIGN_BOTTOM(_mainButton, 0);
    
    _nickName = [[UILabel alloc]initWithFrame:CGRectMake(_iconImgView.right + 10, 0, 180, 40)];
    _nickName.font = kFontSize14;
    [self addSubview:_nickName];
    
    _publishTime = [[UILabel alloc]initWithFrame:CGRectMake(SCWidth - 100, 0, 80, 40)];
    _publishTime.font = kFontSize14;
    [self addSubview:_publishTime];
    
}

-(void)setInfoPack:(MTPicInfoPack *)infoPack
{
    _infoPack = infoPack;
    [_mainButton sd_setBackgroundImageWithURL:[NSURL URLWithString:infoPack.pictureUrl] forState:UIControlStateNormal];
    
    [_iconImgView sd_setImageWithURL:[NSURL URLWithString:infoPack.pictureUrl] placeholderImage:nil];
    
    _nickName.text = infoPack.user.nickName;
    
    _publishTime.text = infoPack.showTime;
}


@end
