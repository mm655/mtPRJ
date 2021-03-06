//
//  MTFindViewController.m
//  mttt
//
//  Created by 张勐 on 15/12/24.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import "MTFindViewController.h"
#import "MTNearbyCollectionViewLayout.h"
#import "MTNearbyCollectionView.h"
#import "MTNearbyCollectionViewCell.h"
#import "MTUserTableView.h"
#import "MTUserTableViewCell.h"
#import "MTTableHeaderRefreshView.h"
#import "MTPull2RefreshState.h"
#import "MTNetworkGetAllPictureList.h"

@interface MTFindViewController () <UICollectionViewDataSource, UICollectionViewDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    int _nearbyPage;
    int _userPage;
    BOOL _isAddingMoreUser;
    BOOL _isAddingMoreNearby;
    NSMutableArray * _nearbyArray;
    NSMutableArray * _userArray;
}
@property (strong, nonatomic) UIView * whiteLineView;
@property (strong, nonatomic) MTNearbyCollectionView * nearByCollectionView;
@property (strong, nonatomic) MTUserTableView * userTableView;

@property (assign, nonatomic) MTPull2RefreshState nearbyState;
@property (assign, nonatomic) MTPull2RefreshState userState;

@end

@implementation MTFindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView * fakeTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCWidth, SCHeight) style:UITableViewStyleGrouped];
    [self.view addSubview:fakeTable];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton * leftNearButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCWidth / 2, 40)];
    NSAttributedString * lAString = [[NSAttributedString alloc] initWithString:@"附近" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20.0f], NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [leftNearButton setAttributedTitle:lAString forState:UIControlStateNormal];
    leftNearButton.left = 0;
    leftNearButton.top = 20;
    leftNearButton.tag = 1000;
    [leftNearButton addTarget:self action:@selector(topButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.view addSubview:leftNearButton];
    
    UIButton * rightUserButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCWidth / 2, 40)];
    NSAttributedString * rAString = [[NSAttributedString alloc] initWithString:@"用户" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20.0f], NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [rightUserButton setAttributedTitle:rAString forState:UIControlStateNormal];
    [rightUserButton addTarget:self action:@selector(topButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    rightUserButton.tag = 1001;
    rightUserButton.right = SCWidth;
    rightUserButton.top = 20;
    [self.navigationController.view addSubview:rightUserButton];
    
    self.whiteLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCWidth / 2 - 20, 2)];
    self.whiteLineView.backgroundColor = [UIColor whiteColor];
    self.whiteLineView.top = 60;
    self.whiteLineView.left = 10;
    [self.navigationController.view addSubview:self.whiteLineView];
    
    MTNearbyCollectionViewLayout * nearLayout = [MTNearbyCollectionViewLayout new];
    MTNearbyCollectionView * nearView = [[MTNearbyCollectionView alloc] initWithFrame:CGRectMake(0, 64, SCWidth, SCHeight - 44 - 64) collectionViewLayout:nearLayout];
    nearView.backgroundColor = [UIColor blueColor];
    nearView.delegate = self;
    nearView.dataSource = self;
    [self.view addSubview:nearView];
    self.nearByCollectionView = nearView;
    
    MTUserTableView * tableView;
    tableView = [[MTUserTableView alloc] initWithFrame:CGRectMake(0, 64, SCWidth, SCHeight - 44 - 64) style:UITableViewStyleGrouped];
    tableView.contentOffset = CGPointMake(0, 0);
    tableView.backgroundColor = [UIColor redColor];
    self.userTableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    _nearbyArray = [[MTAccountMgr getNearbyItemArray] mutableCopy];
    _userArray = [[MTAccountMgr getUserItemArray] mutableCopy];
    if(!_nearbyArray)
    {
        _nearbyArray = [NSMutableArray array];
    }
    if(!_userArray)
    {
        _userArray = [NSMutableArray array];
    }
    
    // Do any additional setup after loading the view.
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [MTAccountMgr setNearbyItemArray:_nearbyArray];
        [MTAccountMgr setUserItemArray:_userArray];
        ;
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) topButtonClick : (UIButton *)button
{
    if(button.tag == 1000)
    {
        _whiteLineView.left = 10;
        [UIView animateWithDuration:0.2 animations:^{
            _userTableView.left = -SCWidth;
            _nearByCollectionView.left = 0;
        }];
    }else{
        _whiteLineView.right = SCWidth - 10;
        [UIView animateWithDuration:0.2 animations:^{
            _userTableView.left = 0;
            _nearByCollectionView.left = SCWidth;
        }];
    }
    
    
}


#pragma mark collectionview datasource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    [collectionView registerClass:[MTTableHeaderRefreshView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"collectionHeader"];
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    [collectionView registerClass:[MTNearbyCollectionViewCell class] forCellWithReuseIdentifier:@"myCollectionViewCell"];
    return 100;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MTNearbyCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"myCollectionViewCell" forIndexPath:indexPath];
    cell.mainImage = [UIImage imageNamed:@"login_pic1"];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"kind is : %@",kind);
//    MTTableHeaderRefreshView * tV = [MTTableHeaderRefreshView new];
    return [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"collectionHeader" forIndexPath:indexPath];
}

//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
//{
//    return 1;
//}
#pragma mark end

#pragma mark tableview datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [tableView registerClass:[MTUserTableViewCell class] forCellReuseIdentifier:@"MTUserTableViewCell"];
    return 20;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MTUserTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MTUserTableViewCell"];
    
    if(indexPath.row % 2)
    {
        cell.backgroundColor = MTGray;
    }else{
        cell.backgroundColor = MTBlue;
    }
    
    return cell;
    
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    MTTableHeaderRefreshView * tV = [[MTTableHeaderRefreshView alloc] initWithFrame:CGRectMake(0, 0, SCWidth, 44)];
    tV.backgroundColor = MTGray;
    return tV;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}
#pragma mark end

#pragma mark scrollView delegate

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if(scrollView.contentOffset.y < 0)
    {
        targetContentOffset->y = 0;
        [[NSNotificationCenter defaultCenter] postNotificationName:MTStartRefreshing object:nil];
    }else if(scrollView.contentOffset.y > 44){
        if(targetContentOffset->y < 44)
        {
            targetContentOffset->y = 44;
        }
    }else{
        targetContentOffset->y = 44;
    }
    
}

-(void) updateUserArray
{
    MTNetworkGetAllPictureList * getAll = [MTNetworkGetAllPictureList new];
    [getAll getAllPictureByPage:@(1) resultBlock:^(MTNetworkResultType resultType, NSObject *addInfo) {
        if(resultType == MTNetworkResultTypeSuccess)
        {
            _userPage = 1;
            _userArray = (NSMutableArray *)addInfo;
            [_userTableView reloadData];
            if(_userTableView.contentOffset.y < 44)
            {
                [_userTableView setContentOffset:CGPointMake(0, 44) animated:YES];
            }
        }
        ;
    }];
}

-(void) updateNearbyArray
{
    MTNetworkGetAllPictureList * getAll = [MTNetworkGetAllPictureList new];
    [getAll getAllPictureByPage:@(1) resultBlock:^(MTNetworkResultType resultType, NSObject *addInfo) {
        if(resultType == MTNetworkResultTypeSuccess)
        {
            _nearbyPage = 1;
            _nearbyArray = (NSMutableArray *)addInfo;
            [_nearByCollectionView reloadData];
            if(_nearByCollectionView.contentOffset.y < 44)
            {
                [_nearByCollectionView setContentOffset:CGPointMake(0, 44) animated:YES];
            }
        }
        ;
    }];
}

-(void) addMoreUser
{
    MTNetworkGetAllPictureList * getAll = [MTNetworkGetAllPictureList new];
    [getAll getAllPictureByPage:@(_userPage + 1) resultBlock:^(MTNetworkResultType resultType, NSObject *addInfo) {
        if(resultType == MTNetworkResultTypeSuccess)
        {
            _userPage += 1;
            [_userArray addObjectsFromArray:(NSMutableArray *)addInfo];
            [_userTableView reloadData];
            if(_userTableView.contentOffset.y < 44)
            {
                [_userTableView setContentOffset:CGPointMake(0, 44) animated:YES];
            }
        }
        ;
    }];
}

-(void) addMoreNearby
{
    MTNetworkGetAllPictureList * getAll = [MTNetworkGetAllPictureList new];
    [getAll getAllPictureByPage:@(_nearbyPage + 1) resultBlock:^(MTNetworkResultType resultType, NSObject *addInfo) {
        if(resultType == MTNetworkResultTypeSuccess)
        {
            _nearbyPage += 1;
            [_nearbyArray addObjectsFromArray:(NSMutableArray *)addInfo];
            [_nearByCollectionView reloadData];
            if(_nearByCollectionView.contentOffset.y < 44)
            {
                [_nearByCollectionView setContentOffset:CGPointMake(0, 44) animated:YES];
            }
        }
        ;
    }];
}

// The view that is returned must be retrieved from a call to -dequeueReusableSupplementaryViewOfKind:withReuseIdentifier:forIndexPath:
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"kind is : %@",kind);
//    return nil;
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
