//
//  YCWebImage.h
//  Factory
//
//  Created by DJnet on 2017/3/9.
//  Copyright © 2017年 YueChao An. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YCWebImage : NSObject
+ (void)downloadImageWithUrlStr:(NSString *)str result:(void(^)(UIImage *image,NSError *error))returnImage;
- (void)downloadImageWithUrlStr:(NSString *)str result:(void(^)(UIImage *image,NSError *error))returnImage;
@end
@interface UIImageView (ImageURL)
- (void)yc_setImageURLStr:(NSString *)str;
- (void)yc_setImageURLStr:(NSString *)str WithHolderImage:(UIImage *)image;
@end
