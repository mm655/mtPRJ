//
//  MTEditViewController.m
//  mttt
//
//  Created by 张勐 on 16/1/6.
//  Copyright © 2016年 ZhangMeng. All rights reserved.
//

#import "MTEditViewController.h"

@interface MTEditViewController ()

@end

@implementation MTEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_array_left"] style:UIBarButtonItemStylePlain target:self action:@selector(backItemClick)];
    self.navigationItem.leftBarButtonItem = item;
    self.navigationItem.title = @"编辑个人资料";
    self.view.backgroundColor = MTWhite;
    UIImageView * leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 74, 44, 44)];
    leftImageView.image = [UIImage imageNamed:@"login_pic1"];
    [self.view addSubview:leftImageView];
    
    UITextField * descriptionField = [[UITextField alloc] initWithFrame:CGRectMake(64, 74, SCWidth - 74, 44)];
    //    descriptionView.
//    self.descriptionField = descriptionField;
    descriptionField.placeholder = @"添加图片说明";
    //    descriptionField
    [self.view addSubview:descriptionField];
    
    
    // Do any additional setup after loading the view.
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
