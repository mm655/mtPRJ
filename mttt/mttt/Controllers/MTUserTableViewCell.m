//
//  MTUserTableViewCell.m
//  motu
//
//  Created by 张勐 on 15/11/21.
//  Copyright © 2015年 ___ZM___. All rights reserved.
//

#import "MTUserTableViewCell.h"

static CGFloat const mtUserTableMargin = 2;

@implementation MTUserTableViewCell
{
    UIButton * _headButton;
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
    [self addSubview:leftButton];
    PREPCONSTRAINTS(leftButton);
    [self addConstraint:CONSTRAINT_SETTING_WIDTH(leftButton, buttonWidth)];
    [self addConstraint:CONSTRAINT_SETTING_HEIGHT(leftButton, buttonWidth)];
    ALIGN_LEFT(leftButton, 0);
    ALIGN_BOTTOM(leftButton, 0);
    leftButton.backgroundColor = [UIColor clearColor];
    leftButton.tag = 10001;
    [leftButton addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, buttonWidth, buttonWidth)];
    [self addSubview:rightButton];
    PREPCONSTRAINTS(rightButton);
    [self addConstraint:CONSTRAINT_SETTING_WIDTH(rightButton, buttonWidth)];
    [self addConstraint:CONSTRAINT_SETTING_HEIGHT(rightButton, buttonWidth)];
    ALIGN_RIGHT(rightButton, 0);
    ALIGN_BOTTOM(rightButton, 0);
    rightButton.backgroundColor = [UIColor clearColor];
    rightButton.tag = 10003;

    UIButton * centerButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, buttonWidth, buttonWidth)];
    [self addSubview:centerButton];
    PREPCONSTRAINTS(centerButton);
    [self addConstraint:CONSTRAINT_SETTING_WIDTH(centerButton, buttonWidth)];
    [self addConstraint:CONSTRAINT_SETTING_HEIGHT(centerButton, buttonWidth)];
    ALIGN_CENTER_H(centerButton);
    ALIGN_BOTTOM(centerButton, 0);
    centerButton.backgroundColor = [UIColor clearColor];
    centerButton.tag = 10002;

    UIButton * headButton = [[UIButton alloc] init];
    _headButton = headButton;
    [self addSubview:headButton];
    PREPCONSTRAINTS(headButton);
    ALIGN_LEFT(headButton, 10);
    ALIGN_TOP(headButton, 10);
    [self addConstraint:CONSTRAINT_SETTING_WIDTH(headButton, 44)];
    [self addConstraint:CONSTRAINT_SETTING_HEIGHT(headButton, 44)];
    headButton.backgroundColor = [UIColor clearColor];
    headButton.layer.cornerRadius = 22;
    headButton.layer.masksToBounds = YES;
    headButton.tag = 10004;
    
    UITextField * userName = [[UITextField alloc] init];
    [self addSubview:userName];
    userName.userInteractionEnabled = NO;
    userName.textAlignment = NSTextAlignmentLeft;
    PREPCONSTRAINTS(userName);
    [self addConstraint:CONSTRAINT_SETTING_WIDTH(userName, SCWidth / 3)];
    [self addConstraint:CONSTRAINT_SETTING_HEIGHT(userName, 20)];
    ALIGN_TOP(userName, 12);
    ALIGN_LEFT(userName, 60);
    userName.backgroundColor = [UIColor clearColor];
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
    mySpeak.backgroundColor = [UIColor clearColor];
    mySpeak.tag = 10006;
    
    
    UIButton * focusButton = [[UIButton alloc] init];
    [self addSubview:focusButton];
    PREPCONSTRAINTS(focusButton);
    MATCH_CENTERV(focusButton, headButton);
    ALIGN_RIGHT(focusButton, 6);
    [self addConstraint:CONSTRAINT_SETTING_WIDTH(focusButton, 64)];
    [self addConstraint:CONSTRAINT_SETTING_HEIGHT(focusButton, 28)];
    focusButton.layer.cornerRadius = 6;
    focusButton.layer.masksToBounds = YES;
    focusButton.backgroundColor = [UIColor colorWithRed:0x2c/255.0f green:0xce/255.0f blue:0x75/255.0f alpha:1.0f];
    focusButton.tag = 10007;
    
}

-(void) leftButtonClick
{
    NSLog(@"left button click");
}

-(void)setTImage:(UIImage *)tImage
{
    [_headButton setBackgroundImage:tImage forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
