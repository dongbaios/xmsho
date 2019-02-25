//
//  DCCategrayViewController.m
//  CDDStoreDemo
//
//  Created by lidong on 2019/2/20.
//  Copyright © 2019年 RocketsChen. All rights reserved.
//

#import "DCCategrayViewController.h"
#import "XMGoodModel.h"
@interface DCCategaryCell:UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;

@end
@implementation DCCategaryCell

@end
@interface DCCategrayViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (copy,nonatomic)NSMutableArray<XMGoodType *>*models;

@end

@implementation DCCategrayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestData];
}
/** 请求类型数据 */
- (void)requestData{
    WEAKSELF
    [SVProgressHUD show];
    [XMGoodType bg_findAllAsync:nil complete:^(NSArray * _Nullable array) {
        [SVProgressHUD dismiss];
        weakSelf.models = array.mutableCopy;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableview reloadData];
        });
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.models.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DCCategaryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DCCategaryCell"];
    cell.title.text = self.models[indexPath.row].typeName;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_backBlock) _backBlock(self.models[indexPath.row]);
    [self.navigationController popViewControllerAnimated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{

    [XMGoodType bg_delete:nil row:indexPath.row +1];
    [self requestData];
//    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    XMGoodType *model = self.models[indexPath.row];
//    NSString *where = [NSString stringWithFormat:@"where %@=%@",bg_sqlKey(@"bg_id"),bg_sqlValue(model.bg_id)];
//    [model bg_updateWhere:where];
    
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

#pragma mark - 事件处理

- (IBAction)addType:(UIBarButtonItem *)sender {
    UIAlertController *alter = [UIAlertController alertControllerWithTitle:@"添加种类" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alter addTextFieldWithConfigurationHandler:nil];
    
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alter addAction:cancleAction];
    WEAKSELF
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {

        __block XMGoodType *type = [XMGoodType new];
        type.typeName = alter.textFields.firstObject.text;
        //插入数据
        [type bg_saveAsync:^(BOOL isSuccess) {
            //将bg_id值付给type_id
            bg_executeSql(@"update XMGoodType SET BG_typeId = BG_bg_id ", nil, nil);
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf requestData];
            });
        }];
    }];
    [alter addAction:okAction];
    
    
    [self presentViewController:alter animated:YES completion:nil];
}


-(void)dealloc{
    
}


@end


