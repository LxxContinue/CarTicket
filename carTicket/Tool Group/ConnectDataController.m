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
    }
    return tasks;
}

- (void)insertDataBase:(NSDictionary *)dict ToSheet:(NSString *)sheet{
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
    NSLog(@"insere error%@",error);
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
@end
