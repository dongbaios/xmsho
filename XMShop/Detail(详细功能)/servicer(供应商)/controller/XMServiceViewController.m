//
//  XMServiceViewController.m
//  XMShop
//
//  Created by lidong on 2019/2/24.
//  Copyright © 2019年 RM. All rights reserved.
//

#import "XMServiceViewController.h"
#import "XMContacts.h"

@interface XMServiceCell:UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *phoneNo;

@end
@implementation XMServiceCell

@end

@interface XMServiceViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (copy,nonatomic)NSMutableArray<XMContacts *>*models;
@end

@implementation XMServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestData];
}
/** 请求类型数据 */
- (void)requestData{
    WEAKSELF
    [SVProgressHUD show];
    [XMContacts bg_findAllAsync:nil complete:^(NSArray * _Nullable array) {
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
    XMServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DCCategaryCell"];
    cell.title.text = self.models[indexPath.row].companyName;
    cell.phoneNo.text = self.models[indexPath.row].phoneNo;
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
    
    [XMContacts bg_delete:nil row:indexPath.row +1];
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
    UIAlertController *alter = [UIAlertController alertControllerWithTitle:@"添加联系人" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alter addTextFieldWithConfigurationHandler:nil];
    [alter addTextFieldWithConfigurationHandler:nil];
    
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alter addAction:cancleAction];
    WEAKSELF
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        XMContacts *model = [XMContacts new];
        model.companyName = alter.textFields.firstObject.text;
        model.phoneNo = alter.textFields.lastObject.text;
        [model bg_saveAsync:^(BOOL isSuccess) {
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
