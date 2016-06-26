//
//  UIView+Method.h
//  LZBMeituanSort
//
//  Created by apple on 16/6/26.
//  Copyright © 2016年 apple. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UIView(method)
//只能生成get/Set方法声明
@property (nonatomic,assign) CGFloat LZB_width;

@property (nonatomic,assign) CGFloat LZB_heigth;

@property (nonatomic,assign) CGFloat LZB_x;

@property (nonatomic,assign) CGFloat LZB_y;


@property (nonatomic,assign) CGFloat LZB_centerX;

@property (nonatomic,assign) CGFloat LZB_centerY;

- (void)removeAllSubviews;
@end
