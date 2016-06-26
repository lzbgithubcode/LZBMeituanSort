//
//  LZBChooseView.m
//  LZBMeituanSort
//
//  Created by apple on 16/6/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LZBChooseView.h"

#define lineView_TopMargin  15
#define lineView_Width 2

@interface LZBSingleView ()



@property (nonatomic, strong) UIView *lineView;

@end

@implementation LZBSingleView

- (void)setTitle:(NSString *)title
{
    if(title.length == 0) return;
    _title = title;
    [self.btn setTitle:title forState:UIControlStateNormal];
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    self.btn.frame = CGRectMake(0, 0, self.frame.size.width-lineView_Width, self.frame.size.height);
    self.lineView.frame = CGRectMake(self.frame.size.width-lineView_Width, lineView_TopMargin, lineView_Width, self.frame.size.height- 2*lineView_TopMargin);
}

- (void)seperatorIsHide:(BOOL)hide
{
    if(hide != self.lineView.hidden)
    self.lineView.hidden = hide;
}

#pragma mark - 懒加载
- (UIButton *)btn
{
    if(_btn == nil)
    {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn setTitle:self.title forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:_btn];
    }
    return _btn;
    
}

- (UIView *)lineView
{
    if(_lineView == nil)
    {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor grayColor];
        [self addSubview:_lineView];
    }
    return _lineView;
}

@end




@interface LZBChooseView ()

@property (nonatomic, strong) UIView *topLineView;

@property (nonatomic,strong) UIView *bottomLineView;

@end



@implementation LZBChooseView

- (instancetype)initWithTitles:(NSArray <NSString *>*)titles
{
  if(self = [super init])
  {
      [self  setUpUIWithTitles:titles];
      self.titles = titles;
      
      self.backgroundColor = [UIColor whiteColor];
  }
    return self;
}

-(void)setUpUIWithTitles:(NSArray *)titles
{
    NSInteger count = titles.count;
    for (NSInteger i = 0; i < count; i++) {
        LZBSingleView *single = [[LZBSingleView alloc]init];
        single.tag = i;
        [self addSubview:single];
        [single.btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [single seperatorIsHide:(i == count -1)];
        
    }
 
}

- (void)setTitles:(NSArray<NSString *> *)titles
{
    if(titles.count == 0) return;
    _titles = titles;
    for (NSInteger i = 0; i < titles.count; i++) {
        LZBSingleView *single = self.subviews[i];
        single.title =  titles[i];
    }
    
}

- (void)btnClick:(UIButton *)btn
{
    LZBChooseViewType type = 0;
    switch (btn.tag) {
        case 0:
            type = LZBChooseViewType_Allcategory;
            break;
        case 1:
            type = LZBChooseViewType_AllCity;
            break;
        case 2:
            type = LZBChooseViewType_Sort;
            break;
            
        default:
            break;
    }
    
    if(self.clickChooseView)
        self.clickChooseView(type);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    CGFloat singleX = 0;
    CGFloat singleY = 15;
    CGFloat singleW = width/self.subviews.count;
    CGFloat singleH = height - singleY-1;
    for (NSInteger i = 0; i < self.subviews.count; i++) {
        LZBSingleView *single = self.subviews[i];
        singleX = i * singleW;
        single.frame = CGRectMake(singleX, singleY, singleW, singleH);
    }
    
    self.bottomLineView.frame = CGRectMake(0, height-1, width, 1);
}

- (UIView *)bottomLineView
{
  if(_bottomLineView == nil)
  {
      _bottomLineView = [UIView new];
      _bottomLineView.backgroundColor = [UIColor grayColor];
      [self addSubview:_bottomLineView];
  }
    return _bottomLineView;
}

@end
