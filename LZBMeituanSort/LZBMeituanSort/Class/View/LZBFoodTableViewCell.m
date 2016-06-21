//
//  LZBFoodTableViewCell.m
//  LZBMeituanSort
//
//  Created by apple on 16/6/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LZBFoodTableViewCell.h"

@interface LZBFoodTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *numberLab;

@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;

@property (weak, nonatomic) IBOutlet UILabel *starLab;






@end

@implementation LZBFoodTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
 
}

- (void)setModel:(LZBBaseModel *)model
{
    if(model == nil) return;
    _model = model;
    self.numberLab.text = [NSString stringWithFormat:@"%ld",model.ID];
    self.nameLab.text = model.name;
    self.priceLab.text = [NSString stringWithFormat:@"价格：%.2lf",model.price];
    self.starLab.text = [NSString stringWithFormat:@"星级分：%.2lf",model.evaluation];
    

}




@end
