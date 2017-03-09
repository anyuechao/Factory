//
//  BaseCell.h
//  Factory
//
//  Created by DJnet on 2017/3/9.
//  Copyright © 2017年 YueChao An. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BaseModel;

@interface BaseCell : UITableViewCell
@property (nonatomic, strong)BaseModel * model;
//简单工厂
//根据Model返回对应的Cell
+(instancetype)cellWithModel:(BaseModel *)model;
//返回cell的高度
+(CGFloat)cellHeightWithModel:(BaseModel *)baseModel;

@end
