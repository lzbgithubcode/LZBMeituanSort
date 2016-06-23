//
//  LZBMenuListView.m
//  LZBMeituanSort
//
//  Created by apple on 16/6/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LZBMenuListView.h"

#define btn_Height 30
#define MenuListView_Width 70

//线的高度
#define linView_Height 1

@interface LZBSigneMenu()



@end


@implementation LZBSigneMenu

- (instancetype)initWithFrame:(CGRect)frame
{
  if(self = [super initWithFrame:frame])
  {
      [self setupUI];
  }
    return self;
}

- (void)setupUI
{
    self.btn = [self creatNewButton];
    [self addSubview:self.btn];
    [self addSubview:self.lineView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.lineView.frame = CGRectMake(0, 0, self.frame.size.width, linView_Height);
    self.btn.frame = CGRectMake(0, linView_Height, self.frame.size.width, self.frame.size.height -linView_Height);
}

- (UIView *)lineView
{
    if(_lineView == nil)
    {
        _lineView = [UIView new];
       _lineView.backgroundColor = [UIColor grayColor];
    }
    return _lineView;
}

- (UIButton *)creatNewButton
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    return btn;
}

@end


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
      UIImage *image = [UIImage imageNamed:@"MenuListBg"];
      CGFloat top = image.size.height * 0.5; // 顶端盖高度
      CGFloat bottom = image.size.height * 0.5 - 1;// 底端盖高度
      CGFloat left = image.size.width * 0.5; // 左端盖宽度
      CGFloat right = image.size.width * 0.5 -1; // 右端盖宽度
      UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
      // 指定为拉伸模式，伸缩后重新赋值
      UIImage  *newImage = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
      self.backImageView.image = newImage;
      self.backImageView.frame = CGRectMake(0, 0, MenuListView_Width, 0);
      
      
  }
    return self;
}

- (void)setTitles:(NSArray *)titles
{
    if(titles.count == 0) return;
    if(self.backImageView.subviews.count) return;
    _titles = titles;
    
    for(NSInteger i = 0; i < titles.count; i++)
    {
        LZBSigneMenu *memu = [[LZBSigneMenu alloc]init];
        [memu.btn setTitle:titles[i] forState:UIControlStateNormal];
        [self.backImageView addSubview:memu];
        //布局
        CGFloat memuX = 0;
        CGFloat memuY = i * btn_Height;
        CGFloat memuW = MenuListView_Width;
        CGFloat memuH = btn_Height;
       __block CGRect backImageFrame = self.backImageView.frame;
        [UIView animateWithDuration:1.0 animations:^{
            memu.frame = CGRectMake(memuX, memuY, memuW, memuH);
            backImageFrame.size.height = btn_Height *(i +1);
            self.backImageView.frame = backImageFrame;
        }];
      
        memu.lineView.hidden = (i == 0)?YES:NO;
        [self addTrastitonAnimationWithView:memu];
    }
}

- (void)showPoint:(CGPoint)point WithInView:(UIView *)partentView
{
  if(partentView == nil)
      partentView = [UIApplication sharedApplication].keyWindow;
    
    
    partentView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    
    [partentView addSubview:self];
    CGFloat h = self.titles.count * btn_Height;
     self.frame =  CGRectMake(point.x, point.y, MenuListView_Width, h);
     self.backImageView.frame = CGRectMake(0, 0, MenuListView_Width, h);
    
    
   
   
}

#pragma mark - 动画效果
- (void)addTrastitonAnimationWithView:(UIView *)view
{
    CABasicAnimation *basic = [CABasicAnimation animationWithKeyPath:@"path"];
    [view.layer addAnimation:basic forKey:@"basicAnimation"];
}



#pragma mark - 懒加载

- (UIImageView *)backImageView
{
  if(_backImageView == nil)
  {
      _backImageView = [UIImageView new];
      _backImageView.userInteractionEnabled = YES;
      
  }
    return _backImageView;
}

@end
