# Factory
##关于一个Cell工厂设计模式的 Demo
###一. Model层
####(1).首先建立 BaseModel并继承他建立OneModel,TwoModel,ThreeModel
####(2).在BaseModel中声明实现方法,根据传过来的数据源(字典)判断,并且进行对应Model映射
**关键代码`BaseModel`**

```
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface BaseModel : NSObject

//根据传过来的数据源(字典)判断,并且进行对应Model映射
+(instancetype)modelWithDictionary:(NSDictionary *)dic;

@end

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

```
###二. View 层 
####(1).首先建立 BaseCell并继承他建立OneModelCell,TwoModelCell,ThreeModelCell
####(2).在 BaseCell 中声明实现方法`cellWithModel:`根据Model返回对应的Cell,`cellHeightWithModel:`跟根据模型返回cell的高度
####(3).在OneModelCell,TwoModelCell,ThreeModelCell中重写他的方法`cellHeightWithModel:`并通过 setModel: 方法对其进行赋值

**关键代码`BaseCell`**

```
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

```
###三.  Controller层
####(1).数据请求并传给`BaseModel`,baseMode 通过`modelWithDictionary:`对Model映射
####(2).通过当前模型类名获取冲泳池中的 cell,若为空则根据Model返回对应的Cell
####(3).根据 model 返回cell的高度
**关键代码`RootTableViewController`**

```
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
    BaseCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName(model)]];
    
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

```

