//
//  LZBBaseModel.m
//  LZBMeituanSort
//
//  Created by apple on 16/6/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LZBBaseModel.h"

@implementation LZBBaseModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
  if(self = [super init])
  {
      [self setValuesForKeysWithDictionary:dict];
  }
    return self;
}

+ (instancetype)baseModelWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}
@end
