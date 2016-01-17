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
#import "MTNetworkGetMyFocusUser.h"
#import "MTUserInfoPack.h"
#import "MTNetworkGetUserPic.h"
#import "MTPicInfoPack.h"


@interface MTFindViewController () <UICollectionViewDataSource, UICollectionViewDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    int _nearbyPage;
    int _userPage;
    BOOL _isAddingMoreUser;
    BOOL _isAddingMoreNearby;
    NSMutableArray * _nearbyArray;
    NSMutableArray * _userInfoArray;
    NSMutableArray * _userArray;
    NSMutableArray * _focusArray;
    dispatch_semaphore_t mySemaphore;
    
    UIButton * _leftNearButton;
    UIButton * _rightUserButton;
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
    mySemaphore = dispatch_semaphore_create(1);
    UITableView * fakeTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCWidth, SCHeight) style:UITableViewStyleGrouped];
    fakeTable.backgroundColor = MTClear;
    [self.view addSubview:fakeTable];
    
//    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton * leftNearButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCWidth / 2, 40)];
    NSAttributedString * lAString = [[NSAttributedString alloc] initWithString:@"附近" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20.0f], NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [leftNearButton setAttributedTitle:lAString forState:UIControlStateNormal];
    leftNearButton.left = 0;
    leftNearButton.top = 20;
    leftNearButton.tag = 1000;
    _leftNearButton = leftNearButton;
    [leftNearButton addTarget:self action:@selector(topButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.view addSubview:leftNearButton];
    
    self.view.backgroundColor = MTGray;
    
    UIButton * rightUserButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCWidth / 2, 40)];
    NSAttributedString * rAString = [[NSAttributedString alloc] initWithString:@"用户" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20.0f], NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [rightUserButton setAttributedTitle:rAString forState:UIControlStateNormal];
    [rightUserButton addTarget:self action:@selector(topButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    rightUserButton.tag = 1001;
    rightUserButton.right = SCWidth;
    rightUserButton.top = 20;
    _rightUserButton = rightUserButton;
    [self.navigationController.view addSubview:rightUserButton];
    
    self.whiteLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCWidth / 2 - 20, 2)];
    self.whiteLineView.backgroundColor = [UIColor whiteColor];
    self.whiteLineView.top = 60;
    self.whiteLineView.left = 10;
    [self.navigationController.view addSubview:self.whiteLineView];
    
    MTNearbyCollectionViewLayout * nearLayout = [MTNearbyCollectionViewLayout new];
    MTNearbyCollectionView * nearView = [[MTNearbyCollectionView alloc] initWithFrame:CGRectMake(0, 64, SCWidth, SCHeight - 44 - 64) collectionViewLayout:nearLayout];
    nearView.showsVerticalScrollIndicator = NO;
    nearView.backgroundColor = [UIColor blueColor];
    nearView.delegate = self;
    nearView.dataSource = self;
    [self.view addSubview:nearView];
    self.nearByCollectionView = nearView;
    self.nearByCollectionView.tag = 1011;
    self.nearByCollectionView.contentOffset = CGPointMake(0, 44);
    self.nearByCollectionView.backgroundColor = MTGray;
    
    MTUserTableView * tableView;
    tableView = [[MTUserTableView alloc] initWithFrame:CGRectMake(0, 64, SCWidth, SCHeight - 44 - 64) style:UITableViewStyleGrouped];
    tableView.contentOffset = CGPointMake(0, 0);
    tableView.backgroundColor = MTGray;
    self.userTableView = tableView;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.delegate = self;
    tableView.dataSource = self;
    
//    [self.view addSubview:tableView];
    tableView.tag = 1022;
    tableView.right = 0;
    tableView.contentOffset = CGPointMake(0, 44);
    [self.view insertSubview:tableView belowSubview:self.nearByCollectionView];
    
    
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
    _focusArray = [[MTAccountMgr getMyFocusUser] mutableCopy];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self updateUser];
    });
    
    _leftNearButton.hidden  = NO;
    _rightUserButton.hidden = NO;
    _whiteLineView.hidden   = NO;
    self.tabBarController.tabBar.hidden = NO;
//    [self updateUser];
}


-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self getUserInfoArray];
    
    [self updateNearbyArray];
    
//    [self updateUserArray];
}

-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    _leftNearButton.hidden = YES;
    _rightUserButton.hidden = YES;
    _whiteLineView.hidden = YES;
}

-(void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [MTAccountMgr setNearbyItemArray:_nearbyArray];
        [MTAccountMgr setUserItemArray:_userArray];
    });
    
    MTNetworkGetMyFocusUser * getFocus = [MTNetworkGetMyFocusUser new];
    [getFocus getMyFocusUserByID:GetMyUserID rBlock:^(MTNetworkResultType resultType, NSObject *addInfo) {
        if(resultType == MTNetworkResultTypeSuccess)
        {
            NSArray * rArray = (NSArray *) addInfo;
            if(rArray.count > 0)
            {
                [MTAccountMgr setMyFocusUser:rArray];
            }
        }
    }];
    
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
    if(_nearbyArray)
    {
        return _nearbyArray.count;
    }
    return 0;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MTNearbyCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"myCollectionViewCell" forIndexPath:indexPath];
    cell.picInfo = [_nearbyArray objectAtIndex:indexPath.row];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"kind is : %@",kind);
//    MTTableHeaderRefreshView * tV = [MTTableHeaderRefreshView new];
//    return
    MTTableHeaderRefreshView * view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"collectionHeader" forIndexPath:indexPath];
    view.backgroundColor = MTGray;
    return view;
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
    if(_userArray)
    {
        return _userArray.count;
    }
    return 0;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MTUserTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MTUserTableViewCell"];
    cell.backgroundColor = MTWhite;
    
    cell.infoDic = [_userArray objectAtIndex:indexPath.row];
    
//    if(indexPath.row % 2)
//    {
//        cell.backgroundColor = MTGray;
//    }else{
//        cell.backgroundColor = MTBlue;
//    }
    
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
    return 64 + SCWidth / 3;
}

-(BOOL) tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}
#pragma mark end

#pragma mark scrollView delegate

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if(scrollView.contentOffset.y < 0)
    {
        targetContentOffset->y = 0;
        [[NSNotificationCenter defaultCenter] postNotificationName:MTStartRefreshing object:nil];
        if(scrollView.tag == 1011)
        {
            [self updateNearbyArray];
        }else if(scrollView.tag == 1022)
        {
            [self getUserInfoArray];
        }
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
    if(_userInfoArray.count > 0)
    {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_group_t group = dispatch_group_create();
        
//        [_userArray removeAllObjects];
        __block NSMutableArray * newArray = [NSMutableArray array];
        for(MTUserInfoPack * userInfo in _userInfoArray)
        {
            dispatch_group_async(group, queue, ^{
                dispatch_semaphore_wait(mySemaphore, DISPATCH_TIME_FOREVER);
                MTNetworkGetUserPic * getPic = [MTNetworkGetUserPic new];
                [getPic getUserPicByUserID:userInfo.userID rBlock:^(MTNetworkResultType resultType, NSObject *addInfo) {
                    if(resultType == MTNetworkResultTypeSuccess)
                    {
                        NSArray * rArray = (NSArray *)addInfo;
                        if(rArray.count > 0)
                        {
                            NSDictionary * rDic = @{@"userInfo":userInfo,@"picArray":rArray};
                            [newArray addObject:rDic];
                        }
                    }
                    dispatch_semaphore_signal(mySemaphore);
                }];
                dispatch_semaphore_wait(mySemaphore, DISPATCH_TIME_FOREVER);
                dispatch_semaphore_signal(mySemaphore);
                ;
            });
        }
        dispatch_group_notify(group, queue, ^{
            while (newArray.count > 0 && newArray.count < 5)
            {
                newArray = [[newArray arrayByAddingObjectsFromArray:newArray] mutableCopy];
            }
            _userArray = newArray;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [_userTableView reloadData];
                if(_userTableView.contentOffset.y < 44)
                {
                    [_userTableView setContentOffset:CGPointMake(0, 44) animated:YES];
                }
            });
        });
    }
    
//    MTNetworkGetAllPictureList * getAll = [MTNetworkGetAllPictureList new];
//    [getAll getAllPictureByPage:@(1) resultBlock:^(MTNetworkResultType resultType, NSObject *addInfo) {
//        if(resultType == MTNetworkResultTypeSuccess)
//        {
//            _userPage = 1;
//            _userArray = (NSMutableArray *)addInfo;
//            [_userTableView reloadData];
//            if(_userTableView.contentOffset.y < 44)
//            {
//                [_userTableView setContentOffset:CGPointMake(0, 44) animated:YES];
//            }
//        }
//        ;
//    }];
}

-(void) updateNearbyArray
{
    dispatch_semaphore_t tmpSemaphore = dispatch_semaphore_create(1);
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        MTNetworkGetAllPictureList * getAll = [MTNetworkGetAllPictureList new];
        __block int page = 1;
        __block BOOL continueWhile = YES;
        __block NSMutableArray * rNArray = [NSMutableArray array];
        
        while(continueWhile)
        {
            dispatch_semaphore_wait(tmpSemaphore, DISPATCH_TIME_FOREVER);
            [getAll getAllPictureByPage:@(page) resultBlock:^(MTNetworkResultType resultType, NSObject *addInfo) {
                if(resultType == MTNetworkResultTypeSuccess)
                {
                    NSArray * tmpArr = (NSArray *)addInfo;
                    if(tmpArr.count == 0)
                    {
                        continueWhile = NO;
                    }
                    _nearbyPage = page++;
                    rNArray = [[rNArray arrayByAddingObjectsFromArray:(NSArray *)addInfo] mutableCopy];
    //                _nearbyArray = (NSMutableArray *)addInfo;
//                    [_nearByCollectionView reloadData];
//                    if(_nearByCollectionView.contentOffset.y < 44)
//                    {
//                        [_nearByCollectionView setContentOffset:CGPointMake(0, 44) animated:YES];
//                    }
                }
                dispatch_semaphore_signal(tmpSemaphore);
                ;
            }];
            dispatch_semaphore_wait(tmpSemaphore, DISPATCH_TIME_FOREVER);
            dispatch_semaphore_signal(tmpSemaphore);
        }
        
        _nearbyArray = rNArray;
        
        while(_nearbyArray.count > 0 && _nearbyArray.count < 50)
        {
            _nearbyArray = [[_nearbyArray arrayByAddingObjectsFromArray:_nearbyArray] mutableCopy];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [_nearByCollectionView reloadData];
            if(_nearByCollectionView.contentOffset.y < 44)
            {
                [_nearByCollectionView setContentOffset:CGPointMake(0, 44) animated:YES];
            }
        });

    });
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
    }];
}

-(void) updateUser
{
}

-(void) getUserInfoArray
{
    __block BOOL continueWhile = YES;
    __block int page = 1;
    NSMutableArray * userArray = [NSMutableArray new];
    dispatch_semaphore_t tmpSemephore = dispatch_semaphore_create(1);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        ;
        while (continueWhile) {
            dispatch_semaphore_wait(tmpSemephore, DISPATCH_TIME_FOREVER);
            MTNetworkGetAllPictureList * getList = [MTNetworkGetAllPictureList new];
            [getList getAllPictureByPage:@(page) resultBlock:^(MTNetworkResultType resultType, NSObject *addInfo) {
                BOOL shot = NO;
                
                if(resultType != MTNetworkResultTypeSuccess)
                {
                    dispatch_semaphore_signal(tmpSemephore);
                    return;
                }
                
                for(MTPicInfoPack * pInfoPack in (NSMutableArray *)addInfo)
                {
                    for(MTUserInfoPack * aPInfoPack in userArray)
                    {
                        if([pInfoPack.user.userID intValue] == [aPInfoPack.userID intValue])
                        {
                            shot = YES;
                            break;
                        }
                    }
                    if(!shot)
                    {
                        [userArray addObject:pInfoPack.user];
                    }
                    shot = NO;
                }
                NSMutableArray * rArray = (NSMutableArray *)addInfo;
                if(!(rArray.count > 0))
                {
                    continueWhile = NO;
                }else{
                    page += 1;
                }
                dispatch_semaphore_signal(tmpSemephore);
                ;
            }];
            dispatch_semaphore_wait(tmpSemephore, DISPATCH_TIME_FOREVER);
            dispatch_semaphore_signal(tmpSemephore);
        }
        _userInfoArray = userArray;
        [self updateUserArray];
    });
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
