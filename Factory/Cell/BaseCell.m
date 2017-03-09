//
//  BaseCell.m
//  Factory
//
//  Created by DJnet on 2017/3/9.
//  Copyright © 2017年 YueChao An. All rights reserved.
//

#import "BaseCell.h"
#import "BaseModel.h"
#import <objc/runtime.h>

@implementation BaseCell

//简单工厂
//根据Model返回对应的Cell
+(instancetype)cellWithModel:(BaseModel *)model {

    NSString *modelName = [NSString stringWithUTF8String:object_getClassName(model)];
    NSString *cellName = [NSString stringWithFormat:@"%@Cell",modelName];
    BaseCell *cell = [[objc_getClass(cellName.UTF8String) alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    
    return cell;
    
}
//返回cell的高度
+(CGFloat)cellHeightWithModel:(BaseModel *)baseModel{

    NSString *modelName = [NSString stringWithUTF8String:object_getClassName(baseModel)];
    NSString *cellName = [NSString stringWithFormat:@"%@Cell",modelName];
    
    return [objc_getClass(cellName.UTF8String) cellHeightWithModel:baseModel];

}

@end
