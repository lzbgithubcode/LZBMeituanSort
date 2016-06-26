//
//  UIView+Method.m
//  LZBMeituanSort
//
//  Created by apple on 16/6/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIView+Method.h"

@implementation UIView (method)

-(void)setLZB_x:(CGFloat)LZB_x
{
    CGRect rect =self.frame;
    rect.origin.x =LZB_x;
    self.frame =rect;
}

-(void)setLZB_y:(CGFloat)LZB_y
{
    CGRect rect =self.frame;
    rect.origin.y =LZB_y;
    self.frame =rect;
}

- (void)setLZB_width:(CGFloat)LZB_width
{
    CGRect rect =self.frame;
    rect.size.width =LZB_width;
    self.frame =rect;
}

- (void)setLZB_heigth:(CGFloat)LZB_heigth
{
    CGRect rect =self.frame;
    rect.size.height =LZB_heigth;
    self.frame =rect;
}

- (CGFloat)LZB_width
{
    return self.frame.size.width;
}

- (CGFloat)LZB_heigth
{
    return self.frame.size.height;
}

- (CGFloat)LZB_x
{
    return self.frame.origin.x;
}
- (CGFloat)LZB_y
{
    return self.frame.origin.y;
}

- (void)setLZB_centerX:(CGFloat)LZB_centerX
{
    CGPoint center =self.center;
    center.x =LZB_centerX;
    self.center =center;
}

- (void)setLZB_centerY:(CGFloat)LZB_centerY
{
    CGPoint center =self.center;
    center.y =LZB_centerY;
    self.center =center;
}

-(CGFloat)LZB_centerX
{
    return self.center.x;
}

- (CGFloat)LZB_centerY
{
    return self.center.y;
}

- (void)removeAllSubviews
{
    while (self.subviews.count) {
        UIView *childView = self.subviews.lastObject;
        [childView removeFromSuperview];
    }
}
@end