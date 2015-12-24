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

@interface MTLoginViewController ()

@end

@implementation MTLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton * loginButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    loginButton.tag = 101116;
    loginButton.backgroundColor = [UIColor blueColor];
    [loginButton addTarget:self action:@selector(loginButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    LoginTrangleView * tView = [[LoginTrangleView alloc] initWithFrame:CGRectMake(100, 100, 100, 77)];
    tView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tView];
    
    // Do any additional setup after loading the view.
}

-(void) loginButtonClick
{
//    [[UIApplication sharedApplication].delegate window].rootViewController = [[MTMainViewController alloc] init];
//    [[[UIApplication sharedApplication].delegate window] makeKeyAndVisible];
//    UIView * tv = [self.view viewWithTag:101115];
//    tv.x += 30;
//    UIButton * bV = [self.view viewWithTag:101116];
//    
//    if(tv.x > SCWidth / 2)
//    {
//        UIView * aV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
//        [bV addSubview:aV];
//        aV.backgroundColor = [UIColor redColor];
//    }
//    [self.view setNeedsDisplay];
    
    MTNetworkLogin * login = [[MTNetworkLogin alloc] init];
    [login loginWithUserName:@"kimi" andPassWord:@"1234" rBlock:^(MTNetworkResultType resultType, NSObject *addInfo) {
        ;
    }];
    
//    MTNetworkRegist * regist = [MTNetworkRegist new];
//    [regist registWithEmail:@"kimizhang655@126.com" userName:@"kimi" passWord:@"1234" interests:nil rBlock:^(MTNetworkResultType resultType, NSObject *addInfo) {
//        ;
//    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UIView * tv1 = [[UIView alloc] init];
    tv1.backgroundColor = [UIColor yellowColor];
    tv1.tag = 101115;
    [self.view addSubview:tv1];
    PREPCONSTRAINTS(tv1);
    CONSTRAIN_SIZE(tv1, 30, 30);
    ALIGN_BOTTOM(tv1, 30);
    ALIGN_LEFT(tv1, 30);
    
    UIView * tv2 = [[UIView alloc] init];
    tv2.backgroundColor = [UIColor greenColor];
    [self.view addSubview:tv2];
    PREPCONSTRAINTS(tv2);
    CONSTRAIN_SIZE(tv2, 30, 30);
    ALIGN_BOTTOM(tv2, 70);
    ALIGN_PAIR_LEFT(tv1, tv2);
    
    
    
}


-(void)dealloc
{
//    NSLog(@"dealloc called");
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
