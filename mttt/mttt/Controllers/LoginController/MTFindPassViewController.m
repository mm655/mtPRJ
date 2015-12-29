//
//  MTFindPassViewController.m
//  mttt
//
//  Created by 张勐 on 15/12/29.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import "MTFindPassViewController.h"
#import "MTNetworkFindPass.h"

@interface MTFindPassViewController ()
{
    UITextField * _emailField;
}
@end

@implementation MTFindPassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = MTWhite;
    UIView * topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCWidth, 64)];
    topView.backgroundColor = MTGreen;
    [self.view addSubview:topView];
    
    UIButton * rtButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 44, 44)];
    [rtButton setImage:[UIImage imageNamed:@"back_array_left"] forState:UIControlStateNormal];
    [rtButton addTarget:self action:@selector(rtButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rtButton];
    
    UILabel * cLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCWidth / 1.5f, 44)];
    cLabel.textAlignment = NSTextAlignmentCenter;
    cLabel.textColor = [UIColor whiteColor];
    cLabel.font = [UIFont systemFontOfSize:20.0f];
    cLabel.text = @"找回密码";
    cLabel.top = 20;
    cLabel.x = SCWidth / 2;
    [self.view addSubview:cLabel];
    
    UITextField * emailField;
    emailField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, SCWidth - 20, 54)];
    _emailField = emailField;
    emailField.x = SCWidth / 2;
    emailField.top = 74;
    UILabel * eFLLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 54)];
    eFLLabel.textColor = [UIColor lightGrayColor];
    eFLLabel.text = @"邮箱:";
    eFLLabel.font = [UIFont systemFontOfSize:18.0f];
    eFLLabel.textAlignment = NSTextAlignmentLeft;
    emailField.leftView = eFLLabel;
    emailField.leftViewMode = UITextFieldViewModeAlways;
    emailField.backgroundColor = [UIColor clearColor];
    [self.view addSubview:emailField];
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCWidth - 10, 1)];
    lineView.backgroundColor = MTGray;
    lineView.top = emailField.bottom + 5;
    lineView.x = SCWidth / 2;
    [self.view addSubview:lineView];
    
    UIButton * cButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCWidth - 20, 44)];
    cButton.x = SCWidth / 2;
    cButton.top = emailField.bottom + 40;
    cButton.backgroundColor = MTGreen;
    cButton.layer.masksToBounds = YES;
    cButton.layer.cornerRadius = 6;
    [cButton setAttributedTitle:[[NSAttributedString alloc] initWithString:@"找回密码" attributes:@{NSForegroundColorAttributeName : MTWhite, NSFontAttributeName : [UIFont systemFontOfSize:20.0f]}] forState:UIControlStateNormal];
    [self.view addSubview:cButton];
    [cButton addTarget:self action:@selector(cButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) rtButtonClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) cButtonClick
{
//    NSLog(@"cButtonClick");
    if(_emailField.text.length != 0)
    {
        MTNetworkFindPass * find = [MTNetworkFindPass new];
        [find findpassWithEmailAddress:_emailField.text resultBLock:^(MTNetworkResultType resultType, NSObject *addInfo) {
            if(resultType == MTNetworkResultTypeSuccess)
            {
                [SVProgressHUD showSuccessWithStatus:(NSString *)addInfo];
                [self dismissViewControllerAnimated:YES completion:nil];
            }else{
                [SVProgressHUD showErrorWithStatus:(NSString *)addInfo];
            }
        }];
    }else{
        [SVProgressHUD showErrorWithStatus:@"请输入注册邮箱"];
    }
}

-(BOOL) prefersStatusBarHidden
{
    return NO;
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
