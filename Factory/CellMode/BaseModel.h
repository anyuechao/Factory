//
//  BaseModel.h
//  Factory
//
//  Created by DJnet on 2017/3/9.
//  Copyright © 2017年 YueChao An. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface BaseModel : NSObject

//根据传过来的数据源(字典)判断,并且进行对应Model映射
+(instancetype)modelWithDictionary:(NSDictionary *)dic;

@end
