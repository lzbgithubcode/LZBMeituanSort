//
//  LZBChooseView.h
//  LZBMeituanSort
//
//  Created by apple on 16/6/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger,LZBChooseViewType) {
     LZBChooseViewType_Allcategory,   //全部分类
     LZBChooseViewType_AllCity,  //全城市
     LZBChooseViewType_Sort,    //排序
    
};

typedef void(^LZBChooseViewTargetBlock)(LZBChooseViewType type);

@interface LZBSingleView : UIView

@property (nonatomic, strong) UIButton *btn;

@property (nonatomic, strong) NSString *title;

- (void)seperatorIsHide:(BOOL)hide;

@end

@interface LZBChooseView : UIView

@property (nonatomic, strong) NSArray <NSString *>*titles;

@property (nonatomic, copy) LZBChooseViewTargetBlock clickChooseView;



- (instancetype)initWithTitles:(NSArray <NSString *>*)titles;

- (void)setClickChooseView:(LZBChooseViewTargetBlock)clickChooseView;






@end
