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

@property (nonatomic, strong) NSMutableArray <LZBBaseModel *>*foodModes;

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
    
    __weak typeof(chooseView)  weakChooseView  = chooseView;
    __weak typeof (self) weakSelf = self;
    [chooseView setClickChooseView:^(LZBChooseViewType type) {
       
        [weakSelf.listView showPoint:CGPointMake([UIScreen mainScreen].bounds.size.width-10-70, height) WithInView:weakSelf.view];
        
        [weakSelf.listView setMemuClick:^(LZBMenuListViewType type, NSString *text) {
            weakChooseView.titles = @[text,text,text];
            [weakSelf sortWithType:type];
        }];
        
    }];
    return chooseView;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 64;
}

#pragma mark - 排序算法

- (void)sortWithType:(LZBMenuListViewType) type
{
    switch (type) {
        case LZBMenuListViewType_Price:
        {
          //冒泡排序-数组
            [self bubblingSort];

        }
            break;
        case LZBMenuListViewType_Mark:
        {
           //快速排序
            [self fastSortLeftIndex:0 WithRightIndex:self.foodModes.count -1];
            
        }
            break;
         case LZBMenuListViewType_Auto:
            {
                [self fastSortWithType:LZBMenuListViewType_Auto LeftIndex:0 WithRightIndex:self.foodModes.count -1];
            }
            break;
            
        default:
            break;
    }
    [self.tableView reloadData];
}
//冒泡排序 - 价格
- (void)bubblingSort
{
    
    //方法一:左边归位
//    for (NSInteger i = 0; i < self.foodModes.count ; i++)
//    {
//        for (NSInteger j = i; j < self.foodModes.count; j++)
//         {
//             LZBBaseModel *model_i  = self.foodModes[i];
//             LZBBaseModel *model_j = self.foodModes[j];
//            
//             if(model_i.price > model_j.price)
//             {
//                 [self.foodModes replaceObjectAtIndex:i withObject:model_j];
//                 [self.foodModes replaceObjectAtIndex:j withObject:model_i];
//             }
//            
//        }
//        
//    }
    
    //方法二：右边归位
    for(NSInteger i = 0; i < self.foodModes.count;i++)
    {
        for(NSInteger j = 0; j < self.foodModes.count - i; j++)
        {
            if(j == self.foodModes.count -1) break;
            LZBBaseModel *model_j = self.foodModes[j];
            LZBBaseModel *model_j1 = self.foodModes[j+1];
            if(model_j.price > model_j1.price)
            {
                 [self.foodModes replaceObjectAtIndex:j withObject:model_j1];
                 [self.foodModes replaceObjectAtIndex:j+1 withObject:model_j];
            }
        }
    }
    
    //冒泡排序是时间复杂度是N *（N - i）约N * N
}

//快速排序- 星级评分
- (void)fastSortLeftIndex:(NSInteger)left WithRightIndex:(NSInteger)right
{
    NSInteger i, j;
    if(left > right) return;
    LZBBaseModel *tempModel = self.foodModes[left]; //基准模型
    i = left;
    j = right;
    
    while (i != j) {
        //从右边开始找比基准模型的评分小的模型
      
        while (i<j && self.foodModes[j].evaluation>tempModel.evaluation) {
            j--;
        }
        //从左向右找
        while (i < j  && self.foodModes[i].evaluation <= tempModel.evaluation) {
            i++;
        }
        
        //如果左右都找到了就交换模型
        if(i < j)
        {
            LZBBaseModel *model_i = self.foodModes[i];
            LZBBaseModel *model_j = self.foodModes[j];
             [self.foodModes replaceObjectAtIndex:i withObject:model_j];
             [self.foodModes replaceObjectAtIndex:j withObject:model_i];
        }
    }
    
    //如果相遇了
    self.foodModes[left] = self.foodModes[i];
    self.foodModes[i] = tempModel;
    
    //第一轮结束之后，采用递归 - 二分法
    
    [self fastSortLeftIndex:left WithRightIndex:i-1];
    [self fastSortLeftIndex:i+1 WithRightIndex:right];
    return;
    
    //快速排序时间复杂度:N * logN - 所以我比较喜欢快速排序哦
}

//按照类型快速排序
- (void)fastSortWithType:(LZBMenuListViewType)type LeftIndex:(NSInteger)left WithRightIndex:(NSInteger)right
{
    NSInteger i, j;
    if(left > right) return;
    LZBBaseModel *tempModel = self.foodModes[left]; //基准模型
    i = left;
    j = right;
    
    while (i != j) {
        
        //从右边开始找比基准模型的评分小的模型
        if(type == LZBMenuListViewType_Auto)
        {
            while (i<j && self.foodModes[j].ID>tempModel.ID) {
                j--;
            }
            //从左向右找
            while (i < j  && self.foodModes[i].ID <= tempModel.ID) {
                i++;
            }
        }
        else if (type == LZBMenuListViewType_Mark)
        {
            while (i<j && self.foodModes[j].evaluation>tempModel.evaluation) {
                j--;
            }
            //从左向右找
            while (i < j  && self.foodModes[i].evaluation <= tempModel.evaluation) {
                i++;
            }
        }
        else
        {
            while (i<j && self.foodModes[j].price>tempModel.price) {
                j--;
            }
            //从左向右找
            while (i < j  && self.foodModes[i].price <= tempModel.price) {
                i++;
            }
            
        }

        //如果左右都找到了就交换模型
        if(i < j)
        {
            LZBBaseModel *model_i = self.foodModes[i];
            LZBBaseModel *model_j = self.foodModes[j];
            [self.foodModes replaceObjectAtIndex:i withObject:model_j];
            [self.foodModes replaceObjectAtIndex:j withObject:model_i];
        }
    }
    
    //如果相遇了
    self.foodModes[left] = self.foodModes[i];
    self.foodModes[i] = tempModel;
    
    //第一轮结束之后，采用递归 - 二分法
    [self fastSortWithType:type LeftIndex:left WithRightIndex:i-1];
    [self fastSortWithType:type LeftIndex:i+1 WithRightIndex:right];

    return;
}




#pragma mark - 懒加载

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
