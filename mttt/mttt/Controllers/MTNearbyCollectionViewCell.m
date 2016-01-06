//
//  MTNearbyCollectionViewCell.m
//  motu
//
//  Created by 张勐 on 15/11/21.
//  Copyright © 2015年 ___ZM___. All rights reserved.
//

#import "MTNearbyCollectionViewCell.h"
#import "MTPicInfoPack.h"
#import "MTItemDetailViewController.h"
#import "MTMainTabViewController.h"
#import "MTFindNavViewController.h"

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
   
    UIButton * button = [[UIButton alloc] init];
    [self addSubview:button];
    PREPCONSTRAINTS(button);
    MATCH_SIZE(button, backImageView);
    MATCH_CENTERH(button, backImageView);
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    
    return self;
}

-(void)setPicInfo:(MTPicInfoPack *)picInfo
{
    _picInfo = picInfo;
    [_mainImageView sd_setImageWithURL:[NSURL URLWithString:picInfo.pictureUrl]];
}

-(void)setMainImage:(UIImage *)mainImage
{
    self.mainImageView.image = mainImage;
}

-(void)buttonClick
{
    MTItemDetailViewController * dC = [MTItemDetailViewController new];
    dC.infoPack = self.picInfo;
    
    MTMainTabViewController * mainTabVC = (MTMainTabViewController *)[[UIApplication sharedApplication].delegate window].rootViewController;
    //    mainTabVC.selectedViewController
    mainTabVC.tabBar.hidden = YES;
    MTFindNavViewController * findNavVC = mainTabVC.selectedViewController;
    [findNavVC pushViewController:dC animated:YES];
}

@end
