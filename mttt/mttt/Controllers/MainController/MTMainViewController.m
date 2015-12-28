//
//  MTMainViewController.m
//  mttt
//
//  Created by 张勐 on 15/12/21.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import "MTMainViewController.h"
#import "MTMainTableViewCell.h"

@interface MTMainViewController () <UITableViewDelegate,UITableViewDataSource>
{
    UITableView * _mainTableView;
    NSMutableArray * _mainItemArray;
    UIView * _nothingShadowView;
}
@end

@implementation MTMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"陌图";
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCWidth, SCHeight - 44)];
    _mainTableView.backgroundColor = [UIColor orangeColor];
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
    
    

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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
    return 10;
}

-(BOOL) tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130 + SCWidth;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MTMainTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MainCell"];

    if(indexPath.row % 2)
    {
        cell.backgroundColor = [UIColor orangeColor];
    }else{
        cell.backgroundColor = [UIColor greenColor];
    }
    return cell;
}


-(void)enterFindButtonClick
{
    [self.navigationController.tabBarController setSelectedIndex:1];
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
