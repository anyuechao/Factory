//
//  ThreeModelCell.m
//  Factory
//
//  Created by DJnet on 2017/3/9.
//  Copyright © 2017年 YueChao An. All rights reserved.
//

#import "ThreeModelCell.h"
#import "ThreeModel.h"
#define kWidth ([UIScreen mainScreen].bounds.size.width)

@implementation ThreeModelCell
{
    UIImageView * _imageView;
    UILabel * _singerName;
    UILabel * _musicName;
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
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 80, 80)];
    
    [self.contentView addSubview:_imageView];
    _singerName = [[UILabel alloc] initWithFrame:CGRectMake(110, 10, kWidth - 120, 30)];
    _singerName.textAlignment = NSTextAlignmentCenter;
    _singerName.font = [UIFont systemFontOfSize:23];
    [self.contentView addSubview:_singerName];
    
    _musicName = [[UILabel alloc] initWithFrame:CGRectMake(110, 60,  kWidth - 120, 30)];
    _musicName.textAlignment = NSTextAlignmentCenter;
    _musicName.font = [UIFont systemFontOfSize:17];
    [self.contentView addSubview:_musicName];
    
}

+ (CGFloat)cellHeightWithModel:(BaseModel *)baseModel {

    return 100;
    
}

- (void)setModel:(BaseModel *)model {

    ThreeModel *threeModel = (ThreeModel *)model;
    [_imageView yc_setImageURLStr:threeModel.picUrl];
    _singerName.text = threeModel.singer;
    _musicName.text = threeModel.name;
    

}


@end
