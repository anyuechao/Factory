//
//  BaseModel.m
//  Factory
//
//  Created by DJnet on 2017/3/9.
//  Copyright © 2017年 YueChao An. All rights reserved.
//

#import "BaseModel.h"
#import "OneModel.h"
#import "TwoModel.h"
#import "ThreeModel.h"

@implementation BaseModel

//根据传过来的数据源(字典)判断,并且进行对应Model映射
+(instancetype)modelWithDictionary:(NSDictionary *)dic {

    BaseModel *model = nil;
    
    if ([dic[@"tag"] isEqualToString:@"Top News"]) {
        
        model = [OneModel new];
        
    }else if ([dic[@"tag"] isEqualToString:@"imgextra"]){
        
        model = [TwoModel new];
    
    }else if ([dic[@"tag"] isEqualToString:@"music"]){
        
        model = [ThreeModel new];
    
    }

    //字典对Model赋值
    [model setValuesForKeysWithDictionary:dic];

    return model;
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key {


}


@end
