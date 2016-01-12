//
//  MTUserTableViewCell.m
//  motu
//
//  Created by 张勐 on 15/11/21.
//  Copyright © 2015年 ___ZM___. All rights reserved.
//

#import "MTUserTableViewCell.h"
#import "MTUserInfoPack.h"
#import "MTPicInfoPack.h"
#import "MTItemDetailViewController.h"
#import "MTMainTabViewController.h"
#import "MTFindNavViewController.h"
#import "MTNetworkAddFocus.h"


static CGFloat const mtUserTableMargin = 2;

@implementation MTUserTableViewCell
{
    UIButton * _headButton;
    UIButton * _leftButton;
    UIButton * _rightButton;
    UIButton * _centerButton;
    UITextField * _nameFiled;
    UIButton * _focusButton;
}
- (void)awakeFromNib {
    // Initialization code
}

-(instancetype)init
{
    self = [super init];
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self continueMyInit];
    return self;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self continueMyInit];
    return self;
}

-(void) continueMyInit
{
    CGFloat buttonWidth = (SCWidth - 2*mtUserTableMargin) / 3;
    UIButton * leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, buttonWidth, buttonWidth)];
    _leftButton = leftButton;
    [self addSubview:leftButton];
    PREPCONSTRAINTS(leftButton);
    [self addConstraint:CONSTRAINT_SETTING_WIDTH(leftButton, buttonWidth)];
    [self addConstraint:CONSTRAINT_SETTING_HEIGHT(leftButton, buttonWidth)];
    ALIGN_LEFT(leftButton, 0);
    ALIGN_BOTTOM(leftButton, 0);
    leftButton.backgroundColor = MTClear;
    leftButton.tag = 10001;
//    [leftButton addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [leftButton addTarget:self action:@selector(bottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, buttonWidth, buttonWidth)];
    _rightButton = rightButton;
    [self addSubview:rightButton];
    PREPCONSTRAINTS(rightButton);
    [self addConstraint:CONSTRAINT_SETTING_WIDTH(rightButton, buttonWidth)];
    [self addConstraint:CONSTRAINT_SETTING_HEIGHT(rightButton, buttonWidth)];
    ALIGN_RIGHT(rightButton, 0);
    ALIGN_BOTTOM(rightButton, 0);
    rightButton.backgroundColor = MTClear;
    rightButton.tag = 10003;
    [rightButton addTarget:self action:@selector(bottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];

    UIButton * centerButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, buttonWidth, buttonWidth)];
    _centerButton = centerButton;
    [self addSubview:centerButton];
    PREPCONSTRAINTS(centerButton);
    [self addConstraint:CONSTRAINT_SETTING_WIDTH(centerButton, buttonWidth)];
    [self addConstraint:CONSTRAINT_SETTING_HEIGHT(centerButton, buttonWidth)];
    ALIGN_CENTER_H(centerButton);
    ALIGN_BOTTOM(centerButton, 0);
    centerButton.backgroundColor = MTClear;
    centerButton.tag = 10002;
    [centerButton addTarget:self action:@selector(bottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];

    UIButton * headButton = [[UIButton alloc] init];
    _headButton = headButton;
    [self addSubview:headButton];
    PREPCONSTRAINTS(headButton);
    ALIGN_LEFT(headButton, 10);
    ALIGN_TOP(headButton, 10);
    [self addConstraint:CONSTRAINT_SETTING_WIDTH(headButton, 44)];
    [self addConstraint:CONSTRAINT_SETTING_HEIGHT(headButton, 44)];
    headButton.backgroundColor = MTClear;
    headButton.layer.cornerRadius = 22;
    headButton.layer.masksToBounds = YES;
    headButton.tag = 10004;
    
    UITextField * userName = [[UITextField alloc] init];
    _nameFiled = userName;
    [self addSubview:userName];
    userName.userInteractionEnabled = NO;
    userName.textAlignment = NSTextAlignmentLeft;
    PREPCONSTRAINTS(userName);
    [self addConstraint:CONSTRAINT_SETTING_WIDTH(userName, SCWidth / 3)];
    [self addConstraint:CONSTRAINT_SETTING_HEIGHT(userName, 20)];
    ALIGN_TOP(userName, 12);
    ALIGN_LEFT(userName, 60);
    userName.backgroundColor = MTClear;
    userName.tag = 10005;
    
    UITextField * mySpeak = [[UITextField alloc] init];
    [self addSubview:mySpeak];
    mySpeak.userInteractionEnabled = NO;
    mySpeak.textAlignment = NSTextAlignmentLeft;
    PREPCONSTRAINTS(mySpeak);
    [self addConstraint:CONSTRAINT_SETTING_WIDTH(mySpeak, SCWidth / 3)];
    [self addConstraint:CONSTRAINT_SETTING_HEIGHT(mySpeak, 20)];
    ALIGN_TOP(mySpeak, 32);
    ALIGN_LEFT(mySpeak, 60);
    mySpeak.backgroundColor = MTClear;
    mySpeak.tag = 10006;
    
    UIButton * focusButton = [[UIButton alloc] init];
    _focusButton = focusButton;
    [self addSubview:focusButton];
    PREPCONSTRAINTS(focusButton);
    MATCH_CENTERV(focusButton, headButton);
    ALIGN_RIGHT(focusButton, 6);
    [self addConstraint:CONSTRAINT_SETTING_WIDTH(focusButton, 64)];
    [self addConstraint:CONSTRAINT_SETTING_HEIGHT(focusButton, 28)];
    focusButton.layer.cornerRadius = 6;
    focusButton.layer.masksToBounds = YES;
    focusButton.backgroundColor = [UIColor colorWithRed:0x2c/255.0f green:0xce/255.0f blue:0x75/255.0f alpha:1.0f];
    focusButton.backgroundColor = MTGreen;
    [focusButton setAttributedTitle:[[NSAttributedString alloc] initWithString:@"关注" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14.0f],NSForegroundColorAttributeName:MTWhite}] forState:UIControlStateNormal];
    focusButton.tag = 10007;
    [focusButton addTarget:self action:@selector(focusButtonClick :) forControlEvents:UIControlEventTouchUpInside];
}

-(void) leftButtonClick
{
    NSLog(@"left button click");
}

-(void)setInfoDic:(NSDictionary *)infoDic
{
    _infoDic = infoDic;
    MTUserInfoPack * userInfo = infoDic[@"userInfo"];
    NSArray * picArray = infoDic[@"picArray"];
    
    if(userInfo.headPic.length > 0)
    {
        [_headButton sd_setBackgroundImageWithURL:[NSURL URLWithString:userInfo.headPic] forState:UIControlStateNormal];
    }else{
        [_headButton setBackgroundImage:[UIImage imageNamed:@"login_pic2"] forState:UIControlStateNormal];
    }
    
    if(userInfo.nickName.length > 0)
    {
        _nameFiled.text = userInfo.nickName;
    }else{
        _nameFiled.text = @"无名氏";
    }
    
    int i = 0;
    [_leftButton setBackgroundImage:nil forState:UIControlStateNormal];
    _leftButton.enabled = NO;
    [_centerButton setBackgroundImage:nil forState:UIControlStateNormal];
    _centerButton.enabled = NO;
    [_rightButton setBackgroundImage:nil forState:UIControlStateNormal];
    _rightButton.enabled = NO;
    for(MTPicInfoPack * picPack in picArray)
    {
        i++;
        if(i > 3)
        {
            break;
        }

        if(i == 1)
        {
            [_leftButton sd_setBackgroundImageWithURL:[NSURL URLWithString:picPack.pictureUrl] forState:UIControlStateNormal];
            _leftButton.enabled = YES;
        }else if(i == 2)
        {
            [_centerButton sd_setBackgroundImageWithURL:[NSURL URLWithString:picPack.pictureUrl] forState:UIControlStateNormal];
            _centerButton.enabled = YES;
        }else{
            [_rightButton sd_setBackgroundImageWithURL:[NSURL URLWithString:picPack.pictureUrl] forState:UIControlStateNormal];
            _rightButton.enabled = YES;
        }
    }
    
}

-(void)setTImage:(UIImage *)tImage
{
    [_headButton setBackgroundImage:tImage forState:UIControlStateNormal];
}

-(void) bottomButtonClick : (UIButton *) button
{
    if(!button.enabled)
    {
        return;
    }
    NSArray * picArray = self.infoDic[@"picArray"];
    MTPicInfoPack * infoPack = [picArray objectAtIndex:button.tag - 10001];
    MTItemDetailViewController * dC = [MTItemDetailViewController new];
    dC.infoPack = infoPack;
    
    MTMainTabViewController * mainTabVC = (MTMainTabViewController *)[[UIApplication sharedApplication].delegate window].rootViewController;
//    mainTabVC.selectedViewController
    mainTabVC.tabBar.hidden = YES;
    MTFindNavViewController * findNavVC = mainTabVC.selectedViewController;
    [findNavVC pushViewController:dC animated:YES];
    
}

-(void) focusButtonClick : (UIButton *) button
{
    NSArray * picArray = self.infoDic[@"picArray"];
    MTPicInfoPack * infoPack = [picArray objectAtIndex:0];
    
    MTMainTabViewController * rootVC = (MTMainTabViewController *)[[UIApplication sharedApplication].delegate window].rootViewController;
    __block MTFindNavViewController * findVC = rootVC.selectedViewController;
    
//    __weak typeof(self) weakSelf = self;
    [MBProgressHUD showHUDAddedTo:findVC.view animated:YES];
    MTNetworkAddFocus * focus = [MTNetworkAddFocus new];
    [focus addFocusUser:infoPack.user.userID byUser:GetMyUserID rBlock:^(MTNetworkResultType resultType, NSObject *addInfo) {
        [MBProgressHUD hideAllHUDsForView:findVC.view animated:YES];
        if(resultType == MTNetworkResultTypeSuccess)
        {
            [SVProgressHUD showSuccessWithStatus:@"已关注"];
        }else{
            [SVProgressHUD showSuccessWithStatus:(NSString *) addInfo];
        }
    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
