//
//  MTResetPassViewController.m
//  mttt
//
//  Created by 张勐 on 16/1/6.
//  Copyright © 2016年 ZhangMeng. All rights reserved.
//

#import "MTResetPassViewController.h"

@interface MTResetPassViewController ()

@end

@implementation MTResetPassViewController
{
    UITextField * _oldField;
    UITextField * _newField;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_array_left"] style:UIBarButtonItemStylePlain target:self action:@selector(backItemClick)];
    self.navigationItem.leftBarButtonItem = item;
    self.navigationItem.title = @"修改密码";
    
    self.view.backgroundColor = MTWhite;
    _oldField = [[UITextField alloc] initWithFrame:CGRectMake(15, 74, SCWidth - 30, 40)];
    _oldField.placeholder = @"旧密码";
    [self.view addSubview:_oldField];
   
    UIView * oldLine = [[UIView alloc] initWithFrame:CGRectMake(10, 0, SCWidth - 20, 1)];
    oldLine.top = _oldField.bottom + 2;
    oldLine.backgroundColor = MTGray;
    [self.view addSubview:oldLine];
    
    _newField = [[UITextField alloc] initWithFrame:_oldField.frame];
    _newField.top = _oldField.bottom + 10;
    _newField.placeholder = @"新密码";
    [self.view addSubview:_newField];
    UIView * newLine = [[UIView alloc] initWithFrame:CGRectMake(10, 0, SCWidth - 20, 1)];
    newLine.top = _newField.bottom + 2;
    newLine.backgroundColor = MTGray;
    [self.view addSubview:newLine];
    
    UIButton * button = [[UIButton alloc] initWithFrame:_newField.frame];
    button.top = _newField.bottom + 20;
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 6;
    [self.view addSubview:button];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = MTGreen;
    [button setAttributedTitle:[[NSAttributedString alloc] initWithString:@"确定" attributes:@{NSForegroundColorAttributeName : MTWhite, NSFontAttributeName : [UIFont systemFontOfSize:16.0f]}] forState:UIControlStateNormal];
    
    self.navigationItem.title = @"隐私政策";
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) buttonClick
{
    
}

-(void) backItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
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
