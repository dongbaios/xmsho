//
//  XMStockViewController.m
//  XMShop
//
//  Created by apple on 2018/3/9.
//  Copyright © 2018年 RM. All rights reserved.
//

#import "XMStockViewController.h"
#import "XMGoodCell.h"
#import "XMDetailPopview.h"
#import "XMGoodModel.h"
@interface XMStockViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UITextField *searchBar;

/** 类型 */
@property (copy,nonatomic)NSArray <XMGoodType*>*typeArray;
/** 商品 */
@property (copy,nonatomic)NSArray <NSArray*>*goodModelArray;
@end

@implementation XMStockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableview registerNib:[UINib nibWithNibName:@"XMGoodCell" bundle:nil]  forCellReuseIdentifier:@"XMGoodCell"];
    [self requsetData];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

#pragma mark - 查询数据
- (void)requsetData{
    self.typeArray = [NSMutableArray array];
    self.goodModelArray = [NSArray array];
    [SVProgressHUD show];
    /** 方法一 先查出各种类型,再查每种类型的商品 */
    [XMGoodType bg_findAllAsync:nil complete:^(NSArray * _Nullable array) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.typeArray = array;
            [self findBytypeId];
        });

    }];
    /** 方法二 常规用SQL分组
     select a.sid,a.goodName,b.id,b.typeId from tableA a, typeTB b where a.type = b.typeId group by b.id
     */
//    NSString *sql = [NSString stringWithFormat:@"select * from xm_goodStoreTable a, XMGoodType b where a.BG_typeId = b.BG_typeId group by b.BG_typeId"];
//    NSDictionary *dic = bg_executeSql(sql, xm_goodStoreTable, nil);
    

    
//    [XMGoodType bg_findAllAsync:nil complete:^(NSArray * _Nullable array) {
//
//    }];
////
//    NSString * where = [NSString stringWithFormat:@"where %@",bg_keyPathValues(@[@"goodType.typeId",bg_equal,@(27)])];
//    [XMGoodModel bg_findAsync:xm_goodStoreTable where:where complete:^(NSArray * _Nullable array) {
//        for (XMGoodModel *model in array) {
//            NSLog(@"%@",model.description);
//        }
//        [SVProgressHUD dismiss];
//    }];
}

//根据查出来的typeID遍历查询商品
- (void)findBytypeId{
    __block NSMutableArray *goodModelArr = [NSMutableArray array];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_apply(self.typeArray.count, queue, ^(size_t index) {
        NSString *where = [NSString stringWithFormat:@"where %@ = %ld ",bg_sqlKey(@"typeId"),(long)self.typeArray[index].typeId];
         NSArray *models = [XMGoodModel bg_find:xm_goodStoreTable where:where];
        for (XMGoodModel *model in models) {
            NSLog(@"%@",model.description);
        }
        [goodModelArr addObject:models];
    });
    self.goodModelArray = goodModelArr.copy;
    [self.tableview reloadData];
    [SVProgressHUD dismiss];
}


#pragma mark - 处理键盘点击下一步
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    return YES;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 表视图 tableviewDelegate/Datasouce
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.typeArray.count;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.goodModelArray[section] count];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    XMGoodCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XMGoodCell" forIndexPath:indexPath];
    XMGoodModel *model = self.goodModelArray[indexPath.section][indexPath.row];
    cell.name.text = model.goodName;
    cell.num.text = [NSString stringWithFormat:@"库存：%ld%@",model.storeNum,model.goodUnit];
    cell.imgV.image = model.image;
    cell.payNum.text = [NSString stringWithFormat:@"%0.2lf元／%@",model.sellPrice,model.goodUnit];
    return cell;
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = [UIView new];
    header.frame = CGRectMake(0, 0, ScreenW, 30);
    
    XMGoodType *model = self.typeArray[section];
    FTLabel *label = [FTLabel  getLabelWithText:model.typeName textColor:HEXCOLOR(0x6c6c6c) fontSize:14 frame:CGRectMake(16, 0, ScreenW, 30)];
    [header addSubview:label];
    return header;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

#pragma mark - 点击cell 查看详情

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XMGoodModel *model = self.goodModelArray[indexPath.section][indexPath.row];
    XMDetailPopview *popview = [XMDetailPopview dc_viewFromXib];
    popview.model = model;
    popview.width = ScreenW;
    [popview sizeToFit];
    popview.y = self.view.height;
    popview.y = self.view.height - popview.height;
    popview.userInteractionEnabled = YES;
    [self.view popview:popview];
}

#pragma mark - 添加商品

- (IBAction)addGood:(UIButton *)sender {
    UIStoryboard *stroyBoard=[UIStoryboard storyboardWithName:@"XMAddGood" bundle:nil];
    UIViewController *vc=[stroyBoard instantiateInitialViewController];
    [self.navigationController pushViewController:vc animated:YES];
}




@end
