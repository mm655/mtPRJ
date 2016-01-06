//
//  MTTestViewController.m
//  mttt
//
//  Created by 张勐 on 15/12/27.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import "MTTestViewController.h"
#import "CLBlurTool.h"
#import "MTNetworkLogin.h"
#import "MTTestEntity+CoreDataProperties.h"
#import "MTNetworkUpdateUserInfo.h"
#import "MTNetworkGetUserInfo.h"
#import "MTNetworkChangePassword.h"
#import "MTNetworkGetMainList.h"
#import "MTNetworkGetAllPictureList.h"
#import "MTNetworkGetMyFocusUser.h"



@interface MTTestViewController ()

@end

@implementation MTTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    MTNetworkGetMyFocusUser * getFocus = [MTNetworkGetMyFocusUser new];
    [getFocus getMyFocusUserByID:GetMyUserID rBlock:^(MTNetworkResultType resultType, NSObject *addInfo) {
        ;
    }];
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
