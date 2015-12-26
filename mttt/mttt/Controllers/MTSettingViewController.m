//
//  MTSettingViewController.m
//  mttt
//
//  Created by 张勐 on 15/12/24.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import "MTSettingViewController.h"

@interface MTSettingViewController ()
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
    
}
@end

@implementation MTSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"设置";
    
    _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5 + 64, 64, 64)];
    _headImageView.layer.masksToBounds = YES;
    _headImageView.layer.cornerRadius = 32;
    _headImageView.image = [UIImage imageNamed:@"login_pic1"];
    [self.view addSubview:_headImageView];
    
    _photoLabel = [[UILabel alloc] init];
    [self.view addSubview:_photoLabel];
    PREPCONSTRAINTS(_photoLabel);
    [self.view addConstraint:CONSTRAINT_LEFT2RIGHT(_photoLabel, _headImageView, 10)];
    [self.view addConstraint:CONSTRAINT_SETTING_HEIGHT(_photoLabel, 30)];
    ALIGN_TOP(_photoLabel, 104);
    _photoLabel.textAlignment = NSTextAlignmentCenter;
    _photoLabel.text = @"照片";
    _photoLabel.backgroundColor = MTBlue;
    
    _focusLabel = [[UILabel alloc] init];
    [self.view addSubview:_focusLabel];
    PREPCONSTRAINTS(_focusLabel);
    MATCH_HEIGHT(_focusLabel, _photoLabel);
    [self.view addConstraint:CONSTRAINT_LEFT2RIGHT(_focusLabel, _photoLabel, 0)];
    _focusLabel.textAlignment = NSTextAlignmentCenter;
    MATCH_WIDTH(_focusLabel, _photoLabel);
    MATCH_CENTERV(_focusLabel, _photoLabel);
    _focusLabel.text = @"关注";
    _focusLabel.backgroundColor = MTGreen;
    
    _fansLabel = [[UILabel alloc] init];
    [self.view addSubview:_fansLabel];
    PREPCONSTRAINTS(_fansLabel);
    MATCH_HEIGHT(_fansLabel, _photoLabel);
    [self.view addConstraint:CONSTRAINT_LEFT2RIGHT(_fansLabel, _focusLabel, 0)];
    MATCH_CENTERV(_fansLabel, _photoLabel);
    ALIGN_RIGHT(_fansLabel, 10);
    MATCH_WIDTH(_fansLabel, _photoLabel);
    _fansLabel.textAlignment = NSTextAlignmentCenter;
    _fansLabel.text = @"粉丝";
    _fansLabel.backgroundColor = MTGray;
    
    
    
    
    _photoNumLabel = [[UILabel alloc] init];
    [self.view addSubview:_photoNumLabel];
    PREPCONSTRAINTS(_photoNumLabel);
    [self.view addConstraint:CONSTRAINT_LEFT2RIGHT(_photoNumLabel, _headImageView, 10)];
    [self.view addConstraint:CONSTRAINT_SETTING_HEIGHT(_photoNumLabel, 30)];
    ALIGN_TOP(_photoNumLabel, 74);
    _photoNumLabel.textAlignment = NSTextAlignmentCenter;
    _photoNumLabel.text = @"74";
    _photoNumLabel.backgroundColor = MTBlue;
    
    _focusNumLabel = [[UILabel alloc] init];
    [self.view addSubview:_focusNumLabel];
    PREPCONSTRAINTS(_focusNumLabel);
    MATCH_HEIGHT(_focusNumLabel, _photoNumLabel);
    [self.view addConstraint:CONSTRAINT_LEFT2RIGHT(_focusNumLabel, _photoNumLabel, 0)];
    _focusNumLabel.textAlignment = NSTextAlignmentCenter;
    MATCH_WIDTH(_focusNumLabel, _photoNumLabel);
    MATCH_CENTERV(_focusNumLabel, _photoNumLabel);
    _focusNumLabel.text = @"104";
    _focusNumLabel.backgroundColor = MTGreen;
    
    _fansNumLabel = [[UILabel alloc] init];
    [self.view addSubview:_fansNumLabel];
    PREPCONSTRAINTS(_fansNumLabel);
    MATCH_HEIGHT(_fansNumLabel, _photoNumLabel);
    [self.view addConstraint:CONSTRAINT_LEFT2RIGHT(_fansNumLabel, _focusNumLabel, 0)];
    MATCH_CENTERV(_fansNumLabel, _photoNumLabel);
    ALIGN_RIGHT(_fansNumLabel, 10);
    MATCH_WIDTH(_fansNumLabel, _photoNumLabel);
    _fansNumLabel.textAlignment = NSTextAlignmentCenter;
    _fansNumLabel.text = @"224";
    _fansNumLabel.backgroundColor = MTGray;

    
    
    
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
