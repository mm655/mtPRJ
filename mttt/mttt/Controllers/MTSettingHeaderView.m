//
//  MTSettingHeaderView.m
//  mttt
//
//  Created by 张勐 on 16/1/6.
//  Copyright © 2016年 ZhangMeng. All rights reserved.
//

#import "MTSettingHeaderView.h"
#import "MTEditViewController.h"
#import "MTMainTabViewController.h"

@implementation MTSettingHeaderView
{
    UIImageView * _headImageView;
    UILabel * _photoLabel;
    UILabel * _photoNumLabel;
    UILabel * _focusLabel;
    UILabel * _focusNumLabel;
    UILabel * _fansLabel;
    UILabel * _fansNumLabel;
    
    UIButton * _focusButton;
    UITextView * _introTView;
    
    UIButton * _bigButton;
    UIButton * _smallButton;
}


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 20, 64, 64)];
    _headImageView.layer.masksToBounds = YES;
    _headImageView.layer.cornerRadius = 32;
    _headImageView.image = [UIImage imageNamed:@"login_pic1"];
    [self addSubview:_headImageView];
    
    _photoLabel = [[UILabel alloc] init];
    [self addSubview:_photoLabel];
    PREPCONSTRAINTS(_photoLabel);
    [self addConstraint:CONSTRAINT_LEFT2RIGHT(_photoLabel, _headImageView, 10)];
    [self addConstraint:CONSTRAINT_SETTING_HEIGHT(_photoLabel, 30)];
    ALIGN_TOP(_photoLabel, 45);
    _photoLabel.textAlignment = NSTextAlignmentCenter;
    _photoLabel.text = @"照片";
    _photoLabel.backgroundColor = MTBlue;
    
    _focusLabel = [[UILabel alloc] init];
    [self addSubview:_focusLabel];
    PREPCONSTRAINTS(_focusLabel);
    MATCH_HEIGHT(_focusLabel, _photoLabel);
    [self addConstraint:CONSTRAINT_LEFT2RIGHT(_focusLabel, _photoLabel, 0)];
    _focusLabel.textAlignment = NSTextAlignmentCenter;
    MATCH_WIDTH(_focusLabel, _photoLabel);
    MATCH_CENTERV(_focusLabel, _photoLabel);
    _focusLabel.text = @"关注";
    _focusLabel.backgroundColor = MTGreen;
    
    _fansLabel = [[UILabel alloc] init];
    [self addSubview:_fansLabel];
    PREPCONSTRAINTS(_fansLabel);
    MATCH_HEIGHT(_fansLabel, _photoLabel);
    [self addConstraint:CONSTRAINT_LEFT2RIGHT(_fansLabel, _focusLabel, 0)];
    MATCH_CENTERV(_fansLabel, _photoLabel);
    ALIGN_RIGHT(_fansLabel, 10);
    MATCH_WIDTH(_fansLabel, _photoLabel);
    _fansLabel.textAlignment = NSTextAlignmentCenter;
    _fansLabel.text = @"粉丝";
    _fansLabel.backgroundColor = MTGray;
    
    _photoNumLabel = [[UILabel alloc] init];
    [self addSubview:_photoNumLabel];
    PREPCONSTRAINTS(_photoNumLabel);
    [self addConstraint:CONSTRAINT_LEFT2RIGHT(_photoNumLabel, _headImageView, 10)];
    [self addConstraint:CONSTRAINT_SETTING_HEIGHT(_photoNumLabel, 30)];
    ALIGN_TOP(_photoNumLabel, 24);
    _photoNumLabel.textAlignment = NSTextAlignmentCenter;
    _photoNumLabel.text = @"74";
    _photoNumLabel.backgroundColor = MTBlue;
    
    _focusNumLabel = [[UILabel alloc] init];
    [self addSubview:_focusNumLabel];
    PREPCONSTRAINTS(_focusNumLabel);
    MATCH_HEIGHT(_focusNumLabel, _photoNumLabel);
    [self addConstraint:CONSTRAINT_LEFT2RIGHT(_focusNumLabel, _photoNumLabel, 0)];
    _focusNumLabel.textAlignment = NSTextAlignmentCenter;
    MATCH_WIDTH(_focusNumLabel, _photoNumLabel);
    MATCH_CENTERV(_focusNumLabel, _photoNumLabel);
    _focusNumLabel.text = @"104";
    _focusNumLabel.backgroundColor = MTGreen;
    
    _fansNumLabel = [[UILabel alloc] init];
    [self addSubview:_fansNumLabel];
    PREPCONSTRAINTS(_fansNumLabel);
    MATCH_HEIGHT(_fansNumLabel, _photoNumLabel);
    [self addConstraint:CONSTRAINT_LEFT2RIGHT(_fansNumLabel, _focusNumLabel, 0)];
    MATCH_CENTERV(_fansNumLabel, _photoNumLabel);
    ALIGN_RIGHT(_fansNumLabel, 10);
    MATCH_WIDTH(_fansNumLabel, _photoNumLabel);
    _fansNumLabel.textAlignment = NSTextAlignmentCenter;
    _fansNumLabel.text = @"224";
    _fansNumLabel.backgroundColor = MTGray;
    
    UIButton * settingButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCWidth / 2, 30)];
    [self addSubview:settingButton];
    settingButton.layer.masksToBounds = YES;
    settingButton.layer.cornerRadius = 5;
    settingButton.backgroundColor = MTGreen;
    [settingButton setAttributedTitle:[[NSAttributedString alloc] initWithString:@"修改个人信息" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20.0f],NSForegroundColorAttributeName : MTWhite}] forState:UIControlStateNormal];
    [settingButton addTarget:self action:@selector(settingButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    PREPCONSTRAINTS(settingButton);
    ALIGN_BOTTOM(settingButton, 75);
    
    [self addConstraint:CONSTRAINT_SETTING_WIDTH(settingButton, SCWidth / 2)];
    [self addConstraint:CONSTRAINT_SETTING_HEIGHT(settingButton, 30)];
    [settingButton addTarget:self action:@selector(settingButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    MATCH_CENTERH(settingButton, _focusLabel);
    
    UIButton * bigButton = [[UIButton alloc] initWithFrame:CGRectMake(-1, 0, SCWidth / 2 + 2, 60)];
    bigButton.bottom = 200;
    _bigButton = bigButton;
    [bigButton setImage:[UIImage imageNamed:@"bigImageImageS"] forState:UIControlStateNormal];
    [self addSubview:bigButton];
    bigButton.layer.borderColor = MTBlack.CGColor;
    bigButton.layer.borderWidth = 1;
    bigButton.tag = 1001;
    [bigButton addTarget:self action:@selector(bsButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * smallButton = [[UIButton alloc] initWithFrame:bigButton.frame];
    smallButton.left = bigButton.right - 1;
    _smallButton = smallButton;
    [smallButton setImage:[UIImage imageNamed:@"smallImageImgeDS"] forState:UIControlStateNormal];
    [self addSubview:smallButton];
    smallButton.tag = 1002;
    smallButton.layer.borderWidth = 1;
    smallButton.layer.borderColor = MTBlack.CGColor;
    [smallButton addTarget:self action:@selector(bsButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return self;
}

-(void) settingButtonClick : (UIButton *) button
{
    MTEditViewController * eVC = [MTEditViewController new];
    MTMainTabViewController * mTVC = (MTMainTabViewController *)[[UIApplication sharedApplication].delegate window].rootViewController;
    mTVC.tabBar.hidden = YES;
    UINavigationController * vc = (UINavigationController *)mTVC.selectedViewController;
    [vc pushViewController:eVC animated:YES];
}

-(void) bsButtonClick : (UIButton *) button
{
    if(button.tag == 1001)
    {
        [_bigButton setImage:[UIImage imageNamed:@"bigImageImageS"] forState:UIControlStateNormal];
        [_smallButton setImage:[UIImage imageNamed:@"smallImageImgeDS"] forState:UIControlStateNormal];
        [[NSNotificationCenter defaultCenter] postNotificationName:MTChangeBigLayout object:nil];
    }else{
        [_bigButton setImage:[UIImage imageNamed:@"bigImageImageDS"] forState:UIControlStateNormal];
        [_smallButton setImage:[UIImage imageNamed:@"smallImageImgeS"] forState:UIControlStateNormal];
        [[NSNotificationCenter defaultCenter] postNotificationName:MTChangeSmallLayout object:nil];
    }
}
@end
