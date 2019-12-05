//
//  SettingViewController.m
//  carTicket
//
//  Created by LXX on 2019/12/5.
//  Copyright © 2019年 LXX. All rights reserved.
//

#import "SettingViewController.h"
#import "ConnectDataController.h"

@interface SettingViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property NSArray *dataSource;

@property (nonatomic, strong) NSString * nameStr;
@property (nonatomic, strong) NSString * phoneStr;
@property (nonatomic, strong) NSString * sexStr;
@property (nonatomic, strong) NSString * password;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIButton *rButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0,45,45)];
    [rButton setTitle:@"保存" forState:UIControlStateNormal];
    rButton.titleLabel.font = [UIFont systemFontOfSize:18.0];
    UIBarButtonItem  *rButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rButton];
    rButton.backgroundColor=[UIColor clearColor];
    [rButton addTarget:self action:@selector(confirmSave) forControlEvents:UIControlEventTouchDown];
    self.navigationItem.rightBarButtonItem = rButtonItem;
    
    
    [self dataConfiguration];
    [self creatTable];
}
#pragma mark - Private DataConfiguration
- (void)dataConfiguration{
    _dataSource = @[@"名字",@"手机",@"性别",@"密码"];
    
    self.nameStr = [self.userInfo objectForKey:@"user_name"];
    self.phoneStr = [self.userInfo objectForKey:@"user_phone"];
    self.sexStr = [self.userInfo objectForKey:@"user_sex"];
    self.password = [self.userInfo objectForKey:@"password"];
}

-(void)creatTable{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //    CGRect frame=CGRectMake(0, 0, 0, CGFLOAT_MIN);
    //    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:frame];
    self.tableView.backgroundColor = [UIColor colorWithRed:242.0/255 green:242.0/255 blue:242.0/255 alpha:1.0];
    
    [self.view addSubview:self.tableView];
}

-(void)confirmSave{
    
    [self.userInfo setObject:self.sexStr forKey:@"user_sex"];
    [self.userInfo setObject:self.password forKey:@"password"];
    
    
    //要修改的手机号以键值对的形式（phoneNumber是数据库存储的字段）
    NSDictionary *dic = @{@"user_sex":self.sexStr,@"password":self.password};
    //条件是名字叫王三
    NSString *con = [NSString stringWithFormat:@"user_phone = '%@'", self.phoneStr];

    [self modifyDataBase:dic WithConditiom:con ToSheet:@"user_info"];
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"修改成功" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSString * content = [NSString stringWithFormat:@"user_phone = '%@'",self.phoneStr];
        
        NSArray * task = [self searchDataBase:content InSheet:@"user_info" OrderBy:@"user_phone"];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        NSLog(@"search task:%@",task);
        dic = task[0];
        
        NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:dic requiringSecureCoding:YES error:nil];
        [[NSUserDefaults standardUserDefaults] setObject:userData forKey:@"userInfo"];
        
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [alertController addAction:defaultAction];
    [self.navigationController presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return  CGFLOAT_MIN;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if(!cell){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@", self.dataSource[indexPath.row]];
    if(indexPath.row ==0){
        cell.detailTextLabel.text = self.nameStr;
    }
    else if(indexPath.row ==1){
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", self.phoneStr];
    }
    else if(indexPath.row ==2){
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", self.sexStr];
    }
    else if(indexPath.row ==3){
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", self.password];
    }
    
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.navigationController.navigationBar.topItem.title = @"";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    if(indexPath.row ==2){
        [self showSexInput];
    }else if(indexPath.row ==3){
        [self showPasswordInput];
    }
    
}

- (void)showSexInput {
    UIAlertController *mailInputAlert = [UIAlertController alertControllerWithTitle:@"请输入您的性别" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [mailInputAlert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = self.sexStr;
        textField.returnKeyType = UIReturnKeyDone;
        [textField addTarget:self action:@selector(strDidChanged:)
            forControlEvents:UIControlEventEditingChanged];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.sexStr = mailInputAlert.textFields.firstObject.text;
        NSIndexPath *path = [NSIndexPath indexPathForRow:2 inSection:0];//指定cell
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:path,nil] withRowAnimation:UITableViewRowAnimationNone];
    }];
    saveAction.enabled = NO;
    [mailInputAlert addAction:cancelAction];
    [mailInputAlert addAction:saveAction];
    [self presentViewController:mailInputAlert animated:YES completion:nil];
}

- (void)showPasswordInput {
    UIAlertController *mailInputAlert = [UIAlertController alertControllerWithTitle:@"请输入您的密码" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [mailInputAlert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = self.password;
        textField.returnKeyType = UIReturnKeyDone;
        [textField addTarget:self action:@selector(strDidChanged:)
            forControlEvents:UIControlEventEditingChanged];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.password = mailInputAlert.textFields.firstObject.text;
        NSIndexPath *path = [NSIndexPath indexPathForRow:3 inSection:0];//指定cell
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:path,nil] withRowAnimation:UITableViewRowAnimationNone];
    }];
    saveAction.enabled = NO;
    [mailInputAlert addAction:cancelAction];
    [mailInputAlert addAction:saveAction];
    [self presentViewController:mailInputAlert animated:YES completion:nil];
}


- (void)strDidChanged:(UITextField *)sender {
    UIAlertController *alertController = (UIAlertController *)self.presentedViewController;
    if(alertController) {
        NSString *inputMail = alertController.textFields.firstObject.text;
        UIAlertAction *saveAction = alertController.actions.lastObject;
        if(![inputMail isEqualToString:@""]) {
            saveAction.enabled = YES;
        }
        
    }
}

@end
