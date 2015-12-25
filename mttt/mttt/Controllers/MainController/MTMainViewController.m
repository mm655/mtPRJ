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
    [self.view addSubview:_mainTableView];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
