//
//  RootTableViewController.m
//  Factory
//
//  Created by DJnet on 2017/3/9.
//  Copyright © 2017年 YueChao An. All rights reserved.
//

#import "RootTableViewController.h"
#import "BaseModel.h"
#import "BaseCell.h"

@interface RootTableViewController ()
@property (nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation RootTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"]];
    
    for (NSDictionary *dic  in array) {
        
        BaseModel *model = [BaseModel modelWithDictionary:dic];
        [self.dataArray addObject:model];
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BaseModel *model = self.dataArray[indexPath.row];
//    BaseCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"%@Cell",[NSString stringWithUTF8String:object_getClassName(model)]]];
    BaseCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName(model)]];
//    BaseCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName(model)] forIndexPath:indexPath];
    
    if (nil == cell){
        cell = [BaseCell cellWithModel:model];
    }
    cell.model = model;
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    BaseModel *model = self.dataArray[indexPath.row];
    return [BaseCell cellHeightWithModel:model];
    
}

#pragma mark- =====================getter method===================== 

- (NSMutableArray *)dataArray {

    if (!_dataArray){
    
        _dataArray = [[NSMutableArray alloc] initWithCapacity:10];
    }
    return _dataArray;
}

@end
