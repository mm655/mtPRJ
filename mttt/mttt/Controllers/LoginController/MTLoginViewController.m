//
//  MTLoginViewController.m
//  mttt
//
//  Created by 张勐 on 15/12/21.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import "MTLoginViewController.h"
#import "MTMainViewController.h"
#import "LoginTrangleView.h"
#import "MTNetworkLogin.h"
#import "MTNetworkRegist.h"
#import "LoginTrangleView.h"

#define LoginUITag 10892
#define RegistUITag 10992


typedef NS_ENUM(NSInteger,MTLRState)
{
    MTLRStateRegistState1,
    MTLRStateRegistState2,
    MTLRStateLoginState1,
    MTLRStateLoginState2
};

@interface MTLoginViewController ()
{
    UIImageView * _topImageView1;
    UIImageView * _topImageView2;
    UIButton * _registButton;
    UIButton * _loginButton;
    LoginTrangleView * _trangleView;
    MTLRState _curState;
    UIView * _backLine1;
    UIView * _backLine2;
    UIView * _backLine3;
    
    UITextField * _emailField;
    UITextField * _userNameField;
    UITextField * _passWordField;
    
    UIButton * _registNext1;
    UIButton * _RLConfirmButton;
    
}
@end

@implementation MTLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(someFieldBeginEditing) name:UITextFieldTextDidBeginEditingNotification object:nil];
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(someFieldEndEditing) name:UITextFieldTextDidEndEditingNotification object:nil];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    _curState = MTLRStateRegistState1;
    _topImageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCWidth, SCWidth * 0.75)];
    [self.view addSubview:_topImageView1];
    _topImageView1.image = [UIImage imageNamed:@"login_pic1"];
    _topImageView1.contentMode = UIViewContentModeScaleAspectFill;
    
    _topImageView2 = [[UIImageView alloc] initWithFrame:_topImageView1.frame];
    _topImageView2.image = [UIImage imageNamed:@"login_pic2"];
    _topImageView2.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:_topImageView2];
    _topImageView2.alpha = 0.0f;
    
    _registButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCWidth / 2, 44)];
    _registButton.bottom = _topImageView1.bottom;
    _registButton.left = 0;
    [_registButton setAttributedTitle:[[NSAttributedString alloc] initWithString:@"注册" attributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName : [UIFont systemFontOfSize:20.0f]}] forState:UIControlStateNormal];
    [self.view addSubview:_registButton];
    _registButton.tag = 101;
    [_registButton addTarget:self action:@selector(rlButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _loginButton = [[UIButton alloc] initWithFrame:_registButton.frame];
    _loginButton.bottom = _topImageView1.bottom;
    _loginButton.right = SCWidth;
    [_loginButton setAttributedTitle:[[NSAttributedString alloc] initWithString:@"登陆" attributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName : [UIFont systemFontOfSize:20.0f]}] forState:UIControlStateNormal];
    [self.view addSubview:_loginButton];
    _loginButton.tag = 102;
    [_loginButton addTarget:self action:@selector(rlButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _trangleView = [[LoginTrangleView alloc] initWithFrame:CGRectMake(0, 0, 14, 10)];
    _trangleView.bottom = _loginButton.bottom;
    _trangleView.x = _registButton.x;
//    _trangleView.y += 1;
    [self.view addSubview:_trangleView];
    
    _emailField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, SCWidth - 20, 54)];
    _emailField.x = SCWidth / 2;
    _emailField.top = _loginButton.bottom + 5;
    UILabel * eFLLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 54)];
    eFLLabel.textColor = [UIColor lightGrayColor];
    eFLLabel.text = @"邮箱:";
    eFLLabel.font = [UIFont systemFontOfSize:18.0f];
    eFLLabel.textAlignment = NSTextAlignmentLeft;
    _emailField.leftView = eFLLabel;
    _emailField.leftViewMode = UITextFieldViewModeAlways;
    _emailField.backgroundColor = [UIColor clearColor];
    _emailField.tag = RegistUITag;
    [self.view addSubview:_emailField];
    
    _backLine1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCWidth - 10, 1)];
    _backLine1.backgroundColor = [UIColor blackColor];
    _backLine1.alpha = 0.3;
    _backLine1.x = SCWidth / 2;
    _backLine1.top = ceilf(_emailField.bottom + 1);
    [self.view addSubview:_backLine1];
    
    _registNext1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 30)];
//    [_registNext1 setTitle:@"下一步" forState:UIControlStateNormal];
    [_registNext1 setAttributedTitle:[[NSAttributedString alloc] initWithString:@"下一步" attributes:@{NSForegroundColorAttributeName : MTRGBColor(9, 109, 187),NSFontAttributeName : [UIFont systemFontOfSize:14.0f]}] forState:UIControlStateNormal];
    _registNext1.y = _emailField.y;
    _registNext1.right = _emailField.right - 4;
    _registNext1.tag = RegistUITag;
    [_registNext1 addTarget:self action:@selector(registNextStep1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_registNext1];
    
    _userNameField = [[UITextField alloc] initWithFrame:_emailField.frame];
    UILabel * uNLLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 65, 54)];
    uNLLabel.textColor = [UIColor lightGrayColor];
    uNLLabel.text = @"用户名:";
    uNLLabel.font = [UIFont systemFontOfSize:18.0f];
    uNLLabel.textAlignment = NSTextAlignmentLeft;
    _userNameField.leftView = uNLLabel;
    _userNameField.leftViewMode = UITextFieldViewModeAlways;
    _userNameField.tag = LoginUITag;
    _userNameField.alpha = 0.0f;
    [self.view addSubview:_userNameField];
    
    _passWordField = [[UITextField alloc] initWithFrame:_emailField.frame];
    UILabel * pWLLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 65, 54)];
    pWLLabel.textColor = [UIColor lightGrayColor];
    pWLLabel.text = @"   密码:";
    pWLLabel.font = [UIFont systemFontOfSize:18.0f];
    pWLLabel.textAlignment = NSTextAlignmentLeft;
    _passWordField.top = _userNameField.bottom + 2;
    _passWordField.leftView = pWLLabel;
    _passWordField.leftViewMode = UITextFieldViewModeAlways;
    _passWordField.tag = LoginUITag;
    [self.view addSubview:_passWordField];
    _passWordField.alpha = 0.0f;
    
    _backLine2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCWidth - 10, 1)];
    _backLine2.top = ceilf(_passWordField.bottom + 1);
    _backLine2.x = SCWidth / 2;
    _backLine2.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
//    _backLine2.alpha = 0.3f;
    [self.view addSubview:_backLine2];
    _backLine2.alpha = 0.0f;
    _backLine2.tag = LoginUITag;
    
    _RLConfirmButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCWidth - 26, 48)];
    _RLConfirmButton.x = SCWidth / 2;
    _RLConfirmButton.layer.cornerRadius = 8;
    _RLConfirmButton.backgroundColor = MTRGBColor(44, 206, 117);
    _RLConfirmButton.top = _backLine2.bottom + 25;
    [_RLConfirmButton setAttributedTitle:[[NSAttributedString alloc] initWithString:@"登陆" attributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName : [UIFont systemFontOfSize:20.0f]}] forState:UIControlStateNormal];
    _RLConfirmButton.hidden = YES;
    [self.view addSubview:_RLConfirmButton];
    
    
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) rlButtonClick : (UIButton *) button
{
    if(button.tag == 101)
    {
//        [UIView transitionWithView:self.view duration:0.1 options:UIViewAnimationOptionLayoutSubviews animations:^{
            _trangleView.x = _registButton.x;
            _topImageView1.alpha = 1.0f;
            _topImageView2.alpha = 0.0f;
            
            if(_curState != MTLRStateRegistState2 && _curState != MTLRStateRegistState1)
            {
                _RLConfirmButton.hidden = YES;
                _curState = MTLRStateRegistState1;
                for(UIView * tmpView in [self.view subviews])
                {
                    if(tmpView.tag == RegistUITag)
                    {
                        tmpView.alpha = 1.0f;
                    }else if(tmpView.tag == LoginUITag)
                    {
                        tmpView.alpha = 0.0f;
                    }
                }
            }
            
            ;
//        } completion:^(BOOL finished) {
//            ;
//        }];
    }else{
//        [UIView transitionWithView:self.view duration:0.1 options:UIViewAnimationOptionLayoutSubviews animations:^{
            _trangleView.x = _loginButton.x;
            _topImageView1.alpha = 0.0f;
            _topImageView2.alpha = 1.0f;
            
            if(_curState != MTLRStateLoginState1 && _curState != MTLRStateLoginState2)
            {
                _RLConfirmButton.hidden = NO;
                [_RLConfirmButton setAttributedTitle:[[NSAttributedString alloc] initWithString:@"登陆" attributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName : [UIFont systemFontOfSize:20.0f]}] forState:UIControlStateNormal];

                _curState = MTLRStateLoginState1;
                for(UIView * tmpView in [self.view subviews])
                {
                    if(tmpView.tag == LoginUITag)
                    {
                        tmpView.alpha = 1.0f;
                    }else if(tmpView.tag == RegistUITag)
                    {
                        tmpView.alpha = 0.0f;
                    }
                }
            }
            ;
//        } completion:^(BOOL finished) {
//            ;
//        }];
    }
}

-(BOOL) prefersStatusBarHidden
{
    return YES;
}

-(void) someFieldBeginEditing
{
    _loginButton.userInteractionEnabled = NO;
    _registButton.userInteractionEnabled = NO;
    _registNext1.userInteractionEnabled = NO;
}

-(void) someFieldEndEditing
{
    _loginButton.userInteractionEnabled = YES;
    _registButton.userInteractionEnabled = YES;
    _registNext1.userInteractionEnabled = YES;
}

-(void) registNextStep1
{
    _curState = MTLRStateRegistState2;
    for(UIView * tmpView in [self.view subviews])
    {
        if(tmpView.tag == LoginUITag)
        {
            tmpView.alpha = 1.0f;
        }else if(tmpView.tag == RegistUITag)
        {
            tmpView.alpha = 0.0f;
        }
    }
    _RLConfirmButton.hidden = NO;
    [_RLConfirmButton setAttributedTitle:[[NSAttributedString alloc] initWithString:@"注册" attributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName : [UIFont systemFontOfSize:20.0f]}] forState:UIControlStateNormal];

    
    
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
