//
//  OneModelCell.m
//  Factory
//
//  Created by DJnet on 2017/3/9.
//  Copyright © 2017年 YueChao An. All rights reserved.
//

#import "OneModelCell.h"
#import "OneModel.h"
#define kWidth ([UIScreen mainScreen].bounds.size.width)

@implementation OneModelCell
{
    UIImageView * _imageView;
    UILabel * _label;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setLayoutViews];
    }
    return self;
}

//对cell进行布局
- (void)setLayoutViews
{
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, kWidth - 20, 80)];
    
    [self.contentView addSubview:_imageView];
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, kWidth - 20,30)];
    
    [self.contentView addSubview:_label];
}

+ (CGFloat)cellHeightWithModel:(BaseModel *)baseModel {

    return 140;

}

- (void)setModel:(BaseModel *)model {

    OneModel *oneModel = (OneModel *)model;
    [_imageView yc_setImageURLStr:oneModel.imgsrc];
    _label.text = oneModel.title;
    
}


@end
