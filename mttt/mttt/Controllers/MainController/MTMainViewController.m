//
//  MTMainViewController.m
//  mttt
//
//  Created by 张勐 on 15/12/21.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import "MTMainViewController.h"
#import "MTMainTableViewCell.h"
#import "MTNetworkGetMainList.h"
#import "MTPicInfoPack.h"
#import "MTTableHeaderRefreshView.h"

@interface MTMainViewController () <UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    UITableView * _mainTableView;
    NSMutableArray * _mainItemArray;
    UIView * _nothingShadowView;
    int _curPage;
    BOOL _isAddingMore;
}
@end

@implementation MTMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView * fakeTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCWidth, SCHeight) style:UITableViewStyleGrouped];
    [self.view addSubview:fakeTable];
    
    _isAddingMore = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"陌图";
//    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCWidth, SCHeight - 44)];
    
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCWidth, SCHeight - 44 - 64) style:UITableViewStyleGrouped];
    _mainTableView.contentOffset = CGPointMake(0, 44);
    _mainTableView.backgroundColor = [UIColor lightGrayColor];
    _mainTableView.delegate   = self;
    _mainTableView.dataSource = self;
    _mainItemArray = [[MTAccountMgr getMainPageItemArray] mutableCopy];
    [self.view addSubview:_mainTableView];
    
    if(_mainItemArray == nil || _mainItemArray.count == 0)
    {
        _nothingShadowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCWidth, SCHeight - 44)];
        _nothingShadowView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_nothingShadowView];
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, SCWidth, SCWidth)];
        imageView.image = [UIImage imageNamed:@"mainZCImage"];
        [_nothingShadowView addSubview:imageView];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        UIButton * enterFindButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 64 + SCWidth + 15, SCWidth - 20, 54)];
        enterFindButton.layer.masksToBounds = YES;
        enterFindButton.layer.cornerRadius = 10;
        enterFindButton.backgroundColor = MTGreen;
        
        [enterFindButton setAttributedTitle:[[NSAttributedString alloc] initWithString:@"发现和关注有趣的用户" attributes:@{NSForegroundColorAttributeName : MTWhite, NSFontAttributeName : [UIFont systemFontOfSize:18.0f]}] forState:UIControlStateNormal];
        [_nothingShadowView addSubview:enterFindButton];
        [enterFindButton addTarget:self action:@selector(enterFindButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self updateMainTable];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    dispatch_async(queue, ^{
        if(_mainItemArray.count != 0)
        {
            [MTAccountMgr setMainPageItemArray:[_mainItemArray copy]];
        }
        ;
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark tableView dataSource
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    [tableView registerClass:[MTMainTableViewCell class] forCellReuseIdentifier:@"MainCell"];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _mainItemArray ? _mainItemArray.count : 0;
}

-(BOOL) tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130 + SCWidth;
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    MTTableHeaderRefreshView * tV = [[MTTableHeaderRefreshView alloc] initWithFrame:CGRectMake(0, 0, SCWidth, 44)];
    tV.backgroundColor = MTGray;
    return tV;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MTMainTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MainCell"];

    MTPicInfoPack * infoPack = [_mainItemArray objectAtIndex:indexPath.row];
    
    [cell.mainImageView sd_setImageWithURL:[NSURL URLWithString:infoPack.pictureUrl]];
    cell.nameLabel.text = infoPack.user.userName;
    cell.zanField.text = [NSString stringWithFormat:@"%zi",infoPack.praiseCount.intValue];
    cell.pingField.text = [NSString stringWithFormat:@"%zi",infoPack.comment.count];
    
    return cell;
}

#pragma mark end
-(void)enterFindButtonClick
{
    [self.navigationController.tabBarController setSelectedIndex:1];
}

-(void) updateMainTable
{
    MTNetworkGetMainList * getMainList = [MTNetworkGetMainList new];
    [getMainList getMainListByUserID:[MTAccountMgr userID] andBeginPage:@(1) resultBlock:^(MTNetworkResultType resultType, NSObject *addInfo) {
        [[NSNotificationCenter defaultCenter] postNotificationName:MTEndRefreshing object:nil];
        if(_mainTableView.contentOffset.y < 44)
        {
            //                [_mainTableView setContentOffset:CGPointMake(0, 44)];
            [_mainTableView setContentOffset:CGPointMake(0, 44) animated:YES];
            
        }
        if(resultType != MTNetworkResultTypeSuccess)
        {
            return;
        }
        NSArray * tmpArray = (NSArray *)addInfo;
        if(tmpArray.count != 0)
        {
            _curPage = 1;
            if(_nothingShadowView)
            {
                [_nothingShadowView removeFromSuperview];
                _nothingShadowView = nil;
            }
            _mainItemArray = [tmpArray mutableCopy];
            [_mainTableView reloadData];
        }
        ;
    }];
}

-(void) getMoreMainTable
{
    MTNetworkGetMainList * getMainList = [MTNetworkGetMainList new];
//    _curPage += 1;
    [getMainList getMainListByUserID:[MTAccountMgr userID] andBeginPage: @(_curPage+1) resultBlock:^(MTNetworkResultType resultType, NSObject *addInfo) {
        [[NSNotificationCenter defaultCenter] postNotificationName:MTEndRefreshing object:nil];
        _isAddingMore = NO;
        NSArray * tmpArray = (NSArray *)addInfo;
        if(tmpArray.count != 0)
        {
            _curPage += 1;
            if(_nothingShadowView)
            {
                [_nothingShadowView removeFromSuperview];
                _nothingShadowView = nil;
            }
//            _mainItemArray = [tmpArray mutableCopy];
            if(_mainItemArray)
            {
                [_mainItemArray addObjectsFromArray:tmpArray];
            }
            
            [_mainTableView reloadData];
            
            if(_mainTableView.contentOffset.y < 44)
            {
                //                [_mainTableView setContentOffset:CGPointMake(0, 44)];
                [_mainTableView setContentOffset:CGPointMake(0, 44) animated:YES];
                
            }
        }
        ;
    }];
 
}



#pragma mark scrollview delegate

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if(scrollView.contentOffset.y < 0)
    {
        targetContentOffset->y = 0;
        [[NSNotificationCenter defaultCenter] postNotificationName:MTStartRefreshing object:nil];
        [self updateMainTable];
    }else if(scrollView.contentOffset.y > 44){
        if(targetContentOffset->y < 44)
        {
            targetContentOffset->y = 44;
        }
    }else{
        targetContentOffset->y = 44;
    }
    
    if(scrollView.contentOffset.y > scrollView.contentSize.height - 1000)
    {
        _isAddingMore = YES;
        [self getMoreMainTable];
    }
    
    
//    NSLog(@"target y : %f",targetContentOffset->y);
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
