//
//  ViewController.m
//  LZBMeituanSort
//
//  Created by apple on 16/6/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ViewController.h"
#import "LZBFoodTableViewCell.h"
#import "LZBChooseView.h"
#import "LZBMenuListView.h"

static NSString *LZBFoodTableViewCellID = @"LZBFoodTableViewCellID";

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *foodModes;

@property (nonatomic, strong) LZBMenuListView  *listView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"LZBFoodTableViewCell" bundle:nil] forCellReuseIdentifier:LZBFoodTableViewCellID];
}


#pragma mark -加载数据

- (NSMutableArray *)foodModes
{
  if(_foodModes == nil)
  {
      _foodModes = [NSMutableArray array];
      NSString *fullPath = [[NSBundle mainBundle] pathForResource:@"foodsList.plist" ofType:nil];
      NSArray *tempArray = [NSArray arrayWithContentsOfFile:fullPath];
      for (NSDictionary *dict in tempArray) {
          LZBBaseModel *model = [[LZBBaseModel alloc]initWithDict:dict];
          [_foodModes addObject:model];
      }
  }
    return _foodModes;
}


#pragma mark - dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.foodModes.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LZBFoodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LZBFoodTableViewCellID];
    cell.model = self.foodModes[indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray *arr = @[@"全部分类",@"全城",@"智能排序"];
    LZBChooseView *chooseView = [[LZBChooseView alloc]initWithTitles:arr];
    CGFloat height = [self tableView:tableView heightForHeaderInSection:section];
    chooseView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, height);
    
    [chooseView setClickChooseView:^(LZBChooseViewType type) {
       
        [self.listView showPoint:CGPointMake([UIScreen mainScreen].bounds.size.width-10-70, height) WithInView:self.view];
    }];
    return chooseView;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 64;
}



- (LZBMenuListView *)listView
{
  if(_listView == nil)
  {
       NSArray *array = @[@"价格排序",@"评分排序",@"智能排序"];
      _listView = [[LZBMenuListView alloc]initWithListArray:array];
  }
    return _listView;
}

- (UITableView *)tableView
{
  if(_tableView == nil)
  {
      _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
      _tableView.delegate = self;
      _tableView.dataSource =self;
    
  }
    return _tableView;
}

@end
