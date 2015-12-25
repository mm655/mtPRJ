//
//  MTMainTabViewController.m
//  mttt
//
//  Created by 张勐 on 15/12/24.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import "MTMainTabViewController.h"
#import "MTSettingViewController.h"
#import "MTMsgViewController.h"
#import "MTShotViewController.h"
#import "MTFindViewController.h"
#import "MTMainViewController.h"
#import "MTMainNavViewController.h"
#import "MTSettingNavViewController.h"
#import "MTMsgNavViewController.h"
#import "MTFindNavViewController.h"

@interface MTMainTabViewController () <UITabBarControllerDelegate>

@property (strong, nonatomic) MTMainViewController * mtMainViewController;
@property (strong, nonatomic) MTMainNavViewController * mtMainNavViewController;
@property (strong, nonatomic) MTFindViewController * mtFindViewController;
@property (strong, nonatomic) MTFindNavViewController * mtFindNavViewController;
@property (strong, nonatomic) MTShotViewController * mtShotViewController;
@property (strong, nonatomic) MTMsgViewController * mtMsgViewController;
@property (strong, nonatomic) MTMsgNavViewController * mtMsgNavViewController;
@property (strong, nonatomic) MTSettingViewController * mtSettingViewController;
@property (strong, nonatomic) MTSettingNavViewController * mtSettingNavViewController;

@property (strong, nonatomic) UIView * tabBackDarkView;
@end

@implementation MTMainTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    self.view.backgroundColor = [UIColor orangeColor];
    self.tabBar.frame = CGRectMake(0, SCHeight - 44, SCWidth, 44);
    UIView * tabBackGray = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCWidth, 44)];
    tabBackGray.backgroundColor = MTRGBColor(51, 51, 51);
    [self.tabBar insertSubview:tabBackGray atIndex:0];
   
    self.mtMainNavViewController = [[MTMainNavViewController alloc] initWithRootViewController:[MTMainViewController new]];
    self.mtFindNavViewController = [[MTFindNavViewController alloc] initWithRootViewController:[MTFindViewController new]];
    self.mtShotViewController = [MTShotViewController new];
    self.mtMsgNavViewController  = [[MTMsgNavViewController alloc] initWithRootViewController:[MTMsgViewController new]];
    self.mtSettingNavViewController = [[MTSettingNavViewController alloc] initWithRootViewController:[MTSettingViewController new]];
    self.viewControllers = @[
                                _mtMainNavViewController,
                                _mtFindNavViewController,
                                _mtShotViewController,
                                _mtMsgNavViewController,
                                _mtSettingNavViewController
                             ];
    
    [_mtMainNavViewController.tabBarItem setImage:[[UIImage imageNamed:@"tab_main_icon_d"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [_mtMainNavViewController.tabBarItem setSelectedImage:[[UIImage imageNamed:@"tab_main_icon_l"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    _mtMainNavViewController.tabBarItem.imageInsets = UIEdgeInsetsMake(2, 0, -2, 0);
    
    [_mtFindNavViewController.tabBarItem setSelectedImage:[[UIImage imageNamed:@"tab_find_icon_l"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [_mtFindNavViewController.tabBarItem setImage:[[UIImage imageNamed:@"tab_find_icon_d"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    _mtFindNavViewController.tabBarItem.imageInsets = UIEdgeInsetsMake(2, 0, -2, 0);
    
    [_mtShotViewController.tabBarItem setImage:[[UIImage imageNamed:@"tab_shot_icon_l"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [_mtShotViewController.tabBarItem setSelectedImage:[[UIImage imageNamed:@"tab_shot_icon_l"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    _mtShotViewController.tabBarItem.imageInsets = UIEdgeInsetsMake(2, 0, -2, 0);
    
    [_mtMsgNavViewController.tabBarItem setImage:[[UIImage imageNamed:@"tab_msg_icon_d"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [_mtMsgNavViewController.tabBarItem setSelectedImage:[[UIImage imageNamed:@"tab_msg_icon_l"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    _mtMsgNavViewController.tabBarItem.imageInsets = UIEdgeInsetsMake(2, 0, -2, 0);
    
    [_mtSettingNavViewController.tabBarItem setImage:[[UIImage imageNamed:@"tab_self_icon_d"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [_mtSettingNavViewController.tabBarItem setSelectedImage:[[UIImage imageNamed:@"tab_self_icon_l"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    _mtSettingNavViewController.tabBarItem.imageInsets = UIEdgeInsetsMake(2, 0, -2, 0);
    
    UIView * shotBackBlue = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCWidth / 5, 44)];
    shotBackBlue.x = SCWidth / 2;
    shotBackBlue.backgroundColor = MTRGBColor(9, 109, 187);
    [self.tabBar insertSubview:shotBackBlue aboveSubview:tabBackGray];
    
    UIView * tabBackDark = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCWidth / 5, 44)];
    tabBackDark.left = 0;
    tabBackDark.backgroundColor = MTRGBColor(38, 38, 38);
    self.tabBackDarkView = tabBackDark;
    [self.tabBar insertSubview:tabBackDark aboveSubview:tabBackGray];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController NS_AVAILABLE_IOS(3_0)
{
    if([viewController isMemberOfClass:[MTShotViewController class]])
    {
        return NO;
    }
    
    if([viewController isMemberOfClass:[MTMainNavViewController class]])
    {
        _tabBackDarkView.left = 0;
    }else if([viewController isMemberOfClass:[MTFindNavViewController class]])
    {
        _tabBackDarkView.left = SCWidth / 5;
    }else if([viewController isMemberOfClass:[MTMsgNavViewController class]])
    {
        _tabBackDarkView.right = SCWidth - SCWidth / 5;
    }else if([viewController isMemberOfClass:[MTSettingNavViewController class]])
    {
        _tabBackDarkView.right = SCWidth;
    }
    return YES;
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
