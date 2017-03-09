//
//  YCWebImage.m
//  Factory
//
//  Created by DJnet on 2017/3/9.
//  Copyright © 2017年 YueChao An. All rights reserved.
//

#import "YCWebImage.h"
#import <CommonCrypto/CommonCrypto.h>

@interface YCWebImage ()

@end

@implementation YCWebImage
+ (instancetype)defaultManager {
    static YCWebImage *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [YCWebImage new];
    });
    return manager;
}
+ (void)downloadImageWithUrlStr:(NSString *)str result:(void (^)(UIImage *, NSError *))returnImage {
    YCWebImage *manager = [YCWebImage defaultManager];
    [manager downloadImageWithUrlStr:str result:^(UIImage *image, NSError *error) {
        returnImage(image, error);
    }];
}

- (void)downloadImageWithUrlStr:(NSString *)str result:(void (^)(UIImage *, NSError *))returnImage {
    NSURL *imageURL = [NSURL URLWithString:str];
    // 转换md5获取文件路径
    NSString *name = [self md5String:str];
    NSString *filePath = [[self caches]stringByAppendingPathComponent:name];
    NSData *imageData = [[NSData alloc]initWithContentsOfFile:filePath];
    if (imageData) {
        UIImage *image = [UIImage imageWithData:imageData];
        returnImage(image, nil);
        return;
    }
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession]dataTaskWithURL:imageURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"图片下载出错:%@",error);
            return;
        }
        UIImage *image = [[UIImage alloc]initWithData:data];
        if (!image) {
            NSLog(@"图片格式问题");
            return;
        }
        [data writeToFile:filePath atomically:YES];
        @autoreleasepool {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIImage *image = [[UIImage alloc]initWithData:data];
                returnImage(image,error);
            });
        }
    }];
    [dataTask resume];
}
// 文件路径
- (NSString *)caches {
    return NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
}
// 得到通用散列字符串
- (NSString *)md5String:(NSString *)str {
    unsigned char result[16];
    
    CC_MD5(str.UTF8String, (unsigned int)strlen(str.UTF8String), result);
    NSMutableString *resultStr = [NSMutableString string];
    for (int i = 0; i < 16; i++) {
        [resultStr appendFormat:@"%02x",result[i]];
    }
    return resultStr;
}
@end

@implementation UIImageView (ImageURL)

- (void)yc_setImageURLStr:(NSString *)str {
    [self yc_setImageURLStr:str WithHolderImage:nil];
}

-(void)yc_setImageURLStr:(NSString *)str WithHolderImage:(UIImage *)image {
    self.image = image;
    __weak UIImageView *myImageView = self;
    [YCWebImage downloadImageWithUrlStr:str result:^(UIImage *image, NSError *error) {
        if (error) {
            return;
        }
        if (!image) {
            return;
        }
        myImageView.image = image;
    }];
}

@end
