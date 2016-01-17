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
#import "MTPicInfoPack.h"
#import "MTNetworkGetUserPic.h"
#import "MTItemDetailViewController.h"


@interface MTSettingViewController () <UICollectionViewDataSource,UICollectionViewDelegate>
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
    
    NSMutableArray * _myItemArray;
    
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
    _mainCollectionView.delegate = self;
    _mainCollectionView.backgroundColor = MTWhite;
    [self.view addSubview:_mainCollectionView];
    
    _myItemArray = [[MTAccountMgr getMyItemArray] mutableCopy];
    if(_myItemArray == nil)
    {
        _myItemArray = [NSMutableArray array];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeBig) name:MTChangeBigLayout object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeSmall) name:MTChangeSmallLayout object:nil];
    // Do any additional setup after loading the view.
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    [self updateMyItemArray];
}

-(void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [MTAccountMgr setMyItemArray:_myItemArray];
}


#pragma mark collectionView dataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _myItemArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MTSettingCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"testa" forIndexPath:indexPath];
    cell.backgroundColor = MTGray;
    cell.infoPack = (MTPicInfoPack *) [_myItemArray objectAtIndex:indexPath.row];
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

#pragma mark collectionView delegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MTPicInfoPack * picInfo = [_myItemArray objectAtIndex:indexPath.row];
    MTItemDetailViewController * dC = [MTItemDetailViewController new];
    dC.infoPack = picInfo;
    [self.navigationController pushViewController:dC animated:YES];
}

-(BOOL) collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
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

-(void) updateMyItemArray
{
    MTNetworkGetUserPic * getUPic = [MTNetworkGetUserPic new];
    
    dispatch_semaphore_t tmpSemaphore = dispatch_semaphore_create(1);
    __block BOOL continueWhile = YES;
    __block int page = 1;
    __block NSMutableArray * resultArray = [NSMutableArray array];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        while(continueWhile)
        {
//            NSLog(@"1");
            continueWhile = NO;
            dispatch_semaphore_wait(tmpSemaphore, DISPATCH_TIME_FOREVER);
            [getUPic getUserPicByUserID:GetMyUserID page:@(page) rBlock:^(MTNetworkResultType resultType, NSObject *addInfo) {
                if(resultType == MTNetworkResultTypeSuccess)
                {
                    NSArray * rArray = (NSArray *)addInfo;
                    if(rArray.count > 0)
                    {
                        page += 1;
                        continueWhile = YES;
                        resultArray = [[resultArray arrayByAddingObjectsFromArray:rArray] mutableCopy];
                    }
                }
                dispatch_semaphore_signal(tmpSemaphore);
            }];
            dispatch_semaphore_wait(tmpSemaphore, DISPATCH_TIME_FOREVER);
            dispatch_semaphore_signal(tmpSemaphore);
//            NSLog(@"2");
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            _myItemArray = resultArray;
            [_mainCollectionView reloadData];;
        })
        ;
    });
    ;
}

-(void) changeBig
{
    [_mainCollectionView setCollectionViewLayout:[MTSettingFlowLayoutBig new] animated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_mainCollectionView setContentOffset:CGPointMake(0, 0) animated:YES];
    });
}

-(void) changeSmall
{
    [_mainCollectionView setCollectionViewLayout:[MTSettingFlowLayoutSmall new] animated:YES];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_mainCollectionView setContentOffset:CGPointMake(0, 0) animated:YES];
    });
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
