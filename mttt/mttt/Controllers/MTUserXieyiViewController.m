//
//  MTUserXieyiViewController.m
//  mttt
//
//  Created by 张勐 on 16/1/7.
//  Copyright © 2016年 ZhangMeng. All rights reserved.
//

#import "MTUserXieyiViewController.h"

@interface MTUserXieyiViewController ()

@end

@implementation MTUserXieyiViewController
{
    NSString * _xieyiString;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _xieyiString = [[NSString alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"userXieyi" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
    UITableView * fakeView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCWidth, SCHeight)];
    [self.view addSubview:fakeView];
    
    UITextView * xyView = [[UITextView alloc] initWithFrame:CGRectMake(0, 64, SCWidth, SCHeight - 64)];
    xyView.text = _xieyiString;
//    xyView.userInteractionEnabled = NO;
    xyView.editable = NO;
    [self.view addSubview:xyView];
    
    self.navigationItem.title = @"用户协议";
    
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_array_left"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonClick)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIView * topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCWidth, 64)];
    topView.backgroundColor = MTGreen;
    [self.view addSubview:topView];
    UIButton * backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 64, 64)];
    [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [backButton setImage:[UIImage imageNamed:@"back_array_left"] forState:UIControlStateNormal];
    [self.view addSubview:backButton];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) backButtonClick
{
    if(self.navigationController)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
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
