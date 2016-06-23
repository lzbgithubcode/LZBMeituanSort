//
//  LZBMenuListView.h
//  LZBMeituanSort
//
//  Created by apple on 16/6/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LZBSigneMenu : UIView

@property (nonatomic, strong) UIButton *btn;

@property (nonatomic, strong) UIView *lineView;

@end


@interface LZBMenuListView : UIView

- (instancetype)initWithListArray:(NSArray *)array;

- (void)showPoint:(CGPoint)point WithInView:(UIView *)partentView;

@end
