//
//  LZBMenuListView.m
//  LZBMeituanSort
//
//  Created by apple on 16/6/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LZBMenuListView.h"

@interface LZBMenuListView ()

@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, strong) UIImageView *backImageView;
@end

@implementation LZBMenuListView

- (instancetype)initWithListArray:(NSArray *)array
{
  if(self = [super init])
  {
      self.titles = array;
      [self addSubview:self.backImageView];
      
  }
    return self;
}

- (void)setTitles:(NSArray *)titles
{
    if(titles.count == 0) return;
    _titles = titles;
   
    
}

- (UIButton *)creatNewButton
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    return btn;
}


#pragma mark - 懒加载

- (UIImageView *)backImageView
{
  if(_backImageView == nil)
  {
      _backImageView = [UIImageView new];
       UIImage *image = [UIImage imageNamed:@"MenuListBg"];
      UIImage *newImage =[image stretchableImageWithLeftCapWidth:0 topCapHeight:0];
      _backImageView.image = newImage;
      _backImageView.contentMode = UIViewContentModeScaleAspectFill;
      _backImageView.clipsToBounds = YES;
      
  }
    return _backImageView;
}

@end
