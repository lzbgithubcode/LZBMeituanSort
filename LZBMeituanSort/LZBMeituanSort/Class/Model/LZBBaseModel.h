//
//  LZBBaseModel.h
//  LZBMeituanSort
//
//  Created by apple on 16/6/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <AVKit/AVKit.h>

@interface LZBBaseModel : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, assign) CGFloat price;

@property (nonatomic, assign) CGFloat  evaluation;


- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)baseModelWithDict:(NSDictionary *)dict;


@end
