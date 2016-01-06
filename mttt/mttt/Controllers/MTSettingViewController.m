//
//  MTSettingViewController.m
//  mttt
//
//  Created by 张勐 on 15/12/24.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import "MTSettingViewController.h"
#import "MTSettingFlowLayoutBig.h"
#import "MTSettingFlowLayoutSmall.h"
#import "MTSettingHeaderView.h"
#import "MTSettingCollectionViewCell.h"
#import "MTSettingTableViewController.h"
#import "MTEditViewController.h"

@interface MTSettingViewController () <UICollectionViewDataSource>
{
    UICollectionView * _mainCollectionView;
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
    
    UITableView * fakeView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCWidth, SCHeight)];
    [self.view addSubview:fakeView];
    
    self.view.backgroundColor = MTWhite;
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tab_set_icon_l"] style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"设置";
    
    _mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, SCWidth, SCHeight - 64 - 44) collectionViewLayout:[[MTSettingFlowLayoutBig alloc] init]];
    _mainCollectionView.dataSource = self;
    [self.view addSubview:_mainCollectionView];
    

    
    // Do any additional setup after loading the view.
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

#pragma mark collectionView dataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MTSettingCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"testa" forIndexPath:indexPath];
    cell.backgroundColor = MTGray;
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    [collectionView registerClass:[MTSettingCollectionViewCell class] forCellWithReuseIdentifier:@"testa"];
    [collectionView registerClass:[MTSettingHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MTSettingCollectionViewHeader"];
    return 1;
}

// The view that is returned must be retrieved from a call to -dequeueReusableSupplementaryViewOfKind:withReuseIdentifier:forIndexPath:
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    MTSettingHeaderView * header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"MTSettingCollectionViewHeader" forIndexPath:indexPath];
    header.backgroundColor = MTWhite;
    return header;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) rightItemClick
{
    self.tabBarController.tabBar.hidden = YES;
    MTSettingTableViewController * vC = [MTSettingTableViewController new];
    [self.navigationController pushViewController:vC animated:YES];
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
