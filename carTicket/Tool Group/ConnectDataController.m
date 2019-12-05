//
//  ConnectDataController.m
//  carTicket
//
//  Created by LXX on 2019/12/4.
//  Copyright © 2019年 LXX. All rights reserved.
//

#import "ConnectDataController.h"
#import <OHMySQL.h>

@implementation  UIViewController(netDateDeal)


- (NSArray *)selectDataBase:(NSString *)sheet{
    // 初始化数据库连接用户
    OHMySQLUser *usr = [[OHMySQLUser alloc] initWithUserName:@"root" password:@"031702433" serverName:@"localhost" dbName:@"car_base" port:3306 socket:nil];
    // 初始化连接器
    OHMySQLStoreCoordinator *coordinator = [[OHMySQLStoreCoordinator alloc] initWithUser:usr];
    // 连接到数据库
    [coordinator connect];
    // 初始化设备上下文
    OHMySQLQueryContext *queryContext = [OHMySQLQueryContext new];
    // 设置连接器
    queryContext.storeCoordinator = coordinator;
    // 获取log表中的数据
    OHMySQLQueryRequest *query = [OHMySQLQueryRequestFactory SELECT:sheet condition:nil];
    NSError *error = nil;
    // task用于存放数据库返回的数据
    NSArray *tasks = [queryContext executeQueryRequestAndFetchResult:query error:&error];
    if (tasks != nil) {
        NSLog(@"%@",tasks);
    }else {
        NSLog(@"data error!!!");
        [self showError:error.description];
    }
    return tasks;
}

- (NSArray *)searchDataBase:(NSString*)content InSheet:(NSString *)sheet OrderBy:(NSString *)str{
    // 初始化数据库连接用户
    OHMySQLUser *usr = [[OHMySQLUser alloc] initWithUserName:@"root" password:@"031702433" serverName:@"localhost" dbName:@"car_base" port:3306 socket:nil];
    // 初始化连接器
    OHMySQLStoreCoordinator *coordinator = [[OHMySQLStoreCoordinator alloc] initWithUser:usr];
    // 连接到数据库
    [coordinator connect];
    // 初始化设备上下文
    OHMySQLQueryContext *queryContext = [OHMySQLQueryContext new];
    // 设置连接器
    queryContext.storeCoordinator = coordinator;
    // 获取log表中的数据
   // OHMySQLQueryRequest *query = [OHMySQLQueryRequestFactory SELECT:sheet condition:nil];
    
    OHMySQLQueryRequest *query = [OHMySQLQueryRequestFactory SELECT:sheet condition:content orderBy:@[str] ascending:YES];
    
    NSError *error = nil;
    // task用于存放数据库返回的数据
    NSArray *tasks = [queryContext executeQueryRequestAndFetchResult:query error:&error];
    if (tasks != nil) {
        NSLog(@"%@",tasks);
    }else {
        NSLog(@"data error!!!");
        [self showError:error.description];
    }
    return tasks;
}

- (NSString*)insertDataBase:(NSDictionary *)dict ToSheet:(NSString *)sheet{
    // 初始化数据库连接用户
    OHMySQLUser *usr = [[OHMySQLUser alloc] initWithUserName:@"root" password:@"031702433" serverName:@"localhost" dbName:@"car_base" port:3306 socket:nil];
    // 初始化连接器
    OHMySQLStoreCoordinator *coordinator = [[OHMySQLStoreCoordinator alloc] initWithUser:usr];
    // 连接到数据库
    [coordinator connect];
    // 初始化设备上下文
    OHMySQLQueryContext *queryContext = [OHMySQLQueryContext new];
    // 设置连接器
    queryContext.storeCoordinator = coordinator;
    
    OHMySQLQueryRequest *query = [OHMySQLQueryRequestFactory INSERT:sheet set:dict];
    NSError *error;
    [queryContext executeQueryRequest:query error:&error];
    NSString *result = [[NSString alloc]init];
    if (!error) {
        result = @"添加成功";
        NSLog(@"%@",result);
        return result;
    }else {
        NSLog(@"data error!!!");
        [self showError:error.description];
        return result;
    }
}

- (NSString*)modifyDataBase:(NSDictionary *)dict WithConditiom:(NSString*)con ToSheet:(NSString *)sheet{
    // 初始化数据库连接用户
    OHMySQLUser *usr = [[OHMySQLUser alloc] initWithUserName:@"root" password:@"031702433" serverName:@"localhost" dbName:@"car_base" port:3306 socket:nil];
    // 初始化连接器
    OHMySQLStoreCoordinator *coordinator = [[OHMySQLStoreCoordinator alloc] initWithUser:usr];
    // 连接到数据库
    [coordinator connect];
    // 初始化设备上下文
    OHMySQLQueryContext *queryContext = [OHMySQLQueryContext new];
    // 设置连接器
    queryContext.storeCoordinator = coordinator;
    
    OHMySQLQueryRequest *query = [OHMySQLQueryRequestFactory UPDATE:sheet set:dict condition:con];

    NSError *error;
    [queryContext executeQueryRequest:query error:&error];
    NSString *result = [[NSString alloc]init];
    if (!error) {
        result = @"修改成功";
        NSLog(@"%@",result);
        return result;
    }else {
        NSLog(@"data error!!!");
        [self showError:error.description];
        return result;
    }
}

-(void)createTitle:(NSString *)title {
    if(title) {
        UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectZero];
        titleLabel.backgroundColor=[UIColor clearColor];
        titleLabel.textAlignment=NSTextAlignmentCenter;
        [titleLabel setTextColor:[UIColor whiteColor]];
        titleLabel.font=[UIFont fontWithName:@"Helvetica" size:18.0];
        [titleLabel setText:title];
        self.navigationItem.titleView=titleLabel;
        //自适应
        [titleLabel sizeToFit];
    }
}
- (void)showError:(NSString *)errorMsg {
    // 1.弹框提醒
    // 初始化对话框
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:errorMsg preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    // 弹出对话框
    [self presentViewController:alert animated:true completion:nil];
}

@end
