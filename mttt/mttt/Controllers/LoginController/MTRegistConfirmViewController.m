//
//  MTRegistConfirmViewController.m
//  mttt
//
//  Created by 张勐 on 15/12/25.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import "MTRegistConfirmViewController.h"
#import "MTNetworkRegist.h"


@interface MTRegistConfirmViewController ()
{
    UITextField * _emailField;
    UITextField * _userNameField;
    UITextField * _passWordField;
    
//    UIButton * _findPassButton;
}

@end

@implementation MTRegistConfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView * navBackView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, SCWidth, 64)];
    navBackView.backgroundColor = MTRGBColor(44, 206, 117);
    [self.navigationController.navigationBar insertSubview:navBackView atIndex:0];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bigShadow"] forBarMetrics:UIBarMetricsCompact];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_array_left"] style:UIBarButtonItemStylePlain target:self action:@selector(leftItemClick)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UILabel * cLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCWidth / 1.5f, 44)];
    cLabel.textAlignment = NSTextAlignmentCenter;
    cLabel.textColor = [UIColor whiteColor];
    cLabel.font = [UIFont systemFontOfSize:20.0f];
    cLabel.text = @"注册信息确认";
    self.navigationItem.titleView = cLabel;
    
    _emailField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, SCWidth - 20, 54)];
    _emailField.x = SCWidth / 2;
    _emailField.top = 64 + 5;
    UILabel * eFLLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 65, 54)];
    eFLLabel.textColor = [UIColor lightGrayColor];
    eFLLabel.text = @"   邮箱:";
    eFLLabel.font = [UIFont systemFontOfSize:18.0f];
    eFLLabel.textAlignment = NSTextAlignmentLeft;
    _emailField.leftView = eFLLabel;
    _emailField.leftViewMode = UITextFieldViewModeAlways;
    _emailField.backgroundColor = [UIColor clearColor];
    _emailField.text = self.emailAddress;
    _emailField.userInteractionEnabled = NO;
    [self.view addSubview:_emailField];
    
    _userNameField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, SCWidth - 20, 54)];
    _userNameField.x = SCWidth / 2;
    _userNameField.top = _emailField.bottom + 5;
    UILabel * uNLLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 65, 54)];
    uNLLabel.textColor = [UIColor lightGrayColor];
    uNLLabel.text = @"用户名:";
    uNLLabel.font = [UIFont systemFontOfSize:18.0f];
    uNLLabel.textAlignment = NSTextAlignmentLeft;
    _userNameField.leftView = uNLLabel;
    _userNameField.leftViewMode = UITextFieldViewModeAlways;
    _userNameField.backgroundColor = [UIColor clearColor];
    _userNameField.text = self.userName;
    _userNameField.userInteractionEnabled = NO;
    [self.view addSubview:_userNameField];
    
    _passWordField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, SCWidth - 20, 54)];
    _passWordField.x = SCWidth / 2;
    _passWordField.top = _userNameField.bottom + 5;
    UILabel * pWLLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 65, 54)];
    pWLLabel.textColor = [UIColor lightGrayColor];
    pWLLabel.text = @"   密码:";
    pWLLabel.font = [UIFont systemFontOfSize:18.0f];
    pWLLabel.textAlignment = NSTextAlignmentLeft;
    _passWordField.leftView = pWLLabel;
    _passWordField.leftViewMode = UITextFieldViewModeAlways;
    _passWordField.backgroundColor = [UIColor clearColor];
    _passWordField.text = self.passWord;
    [self.view addSubview:_passWordField];
    
    UIView * lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCWidth - 10, 1)];
    lineView1.backgroundColor = [UIColor lightGrayColor];
    lineView1.x = SCWidth / 2;
    lineView1.top = _emailField.bottom + 1;
    [self.view addSubview:lineView1];
    
    UIView * lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCWidth - 10, 1)];
    lineView2.backgroundColor = [UIColor lightGrayColor];
    lineView2.x = SCWidth / 2;
    lineView2.top = _userNameField.bottom + 1;
    [self.view addSubview:lineView2];
    
    UIView * lineView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCWidth - 10, 1)];
    lineView3.backgroundColor = [UIColor lightGrayColor];
    lineView3.x = SCWidth / 2;
    lineView3.top = _passWordField.bottom + 1;
    [self.view addSubview:lineView3];
    
    UIButton * registConfirmButton = [[UIButton alloc] initWithFrame:CGRectMake(SCWidth - 20, 44, SCWidth - 20, 44)];
    registConfirmButton.backgroundColor = MTGreen;
    registConfirmButton.x = SCWidth / 2;
    registConfirmButton.top = lineView3.bottom + 15;
    registConfirmButton.layer.masksToBounds = YES;
    registConfirmButton.layer.cornerRadius = 6;
    [registConfirmButton setAttributedTitle:[[NSAttributedString alloc] initWithString:@"注 册" attributes:@{NSForegroundColorAttributeName : MTWhite, NSFontAttributeName : [UIFont systemFontOfSize:20.0f]}] forState:UIControlStateNormal];
    [registConfirmButton addTarget:self action:@selector(registButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registConfirmButton];
    
    _emailField.userInteractionEnabled = NO;
    _userNameField.userInteractionEnabled = NO;
    _passWordField.userInteractionEnabled = NO;
    // self.navigationController.navigationBar
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) leftItemClick
{
    [self dismissViewControllerAnimated:YES completion:^{
        ;
    }];
}

-(void) registButtonClick
{
//    NSLog(@"regist click here");
    MTNetworkRegist * regist = [MTNetworkRegist new];
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [regist registWithEmail:_emailAddress userName:_userName passWord:_passWord interests:nil rBlock:^(MTNetworkResultType resultType, NSObject *addInfo) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if(resultType == MTNetworkResultTypeSuccess)
        {
            [SVProgressHUD showSuccessWithStatus:(NSString *)addInfo];
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            [SVProgressHUD showErrorWithStatus:(NSString *)addInfo];
        }
        ;
    }];
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
