//
//  LZBMenuListView.h
//  LZBMeituanSort
//
//  Created by apple on 16/6/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,LZBMenuListViewType)
{
    LZBMenuListViewType_Price,  //价格
    LZBMenuListViewType_Mark,  //评分
    LZBMenuListViewType_Auto,  //智能

};

typedef void(^LZBMenuListViewClickBlock)(LZBMenuListViewType type,NSString *text);

@interface LZBSigneMenu : UIView

@property (nonatomic, strong) UIButton *btn;

@property (nonatomic, strong) UIView *lineView;

@end


@interface LZBMenuListView : UIView

- (instancetype)initWithListArray:(NSArray *)array;

- (void)showPoint:(CGPoint)point WithInView:(UIView *)partentView;

@property (nonatomic, copy) LZBMenuListViewClickBlock memuClick;
- (void)setMemuClick:(LZBMenuListViewClickBlock)memuClick;

@end
