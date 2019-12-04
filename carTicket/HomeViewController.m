//
//  HomeViewController.m
//  carTicket
//
//  Created by LXX on 2019/12/4.
//  Copyright © 2019年 LXX. All rights reserved.
//

#import "HomeViewController.h"
#import "TicketTableViewCell.h"
#import "ConnectDataController.h"
#import "OrderDetailViewController.h"
#import <OHMySQL.h>

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property NSMutableArray *dataSource;

@property NSArray *routeData;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createTitle:@"路线"];
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:80.0/255 green:141.0/255 blue:219.0/255 alpha:1.0];
    
    self.dataSource = [[NSMutableArray alloc]init];
    self.routeData = [[NSArray alloc]init];
    
    [self connectBase];
    [self creatTable];
}

-(void)connectBase{
    //self.dataSource = [self connectDataBase:@"ios"];
    self.routeData = [self selectDataBase:@"route"];
}
-(void)creatTable{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT -  self.navigationController.navigationBar.frame.size.height- self.tabBarController.tabBar.bounds.size.height-kStatusBarHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    CGRect frame=CGRectMake(0, 0, 0, CGFLOAT_MIN);
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:frame];
    self.tableView.backgroundColor = [UIColor colorWithRed:242.0/255 green:242.0/255 blue:242.0/255 alpha:1.0];
    [self.view addSubview:self.tableView];

}


#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.routeData.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 220;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    TicketTableViewCell *cell = [TicketTableViewCell cellInit:self.tableView];
    NSDictionary *dic = self.routeData[indexPath.row];
    
    cell.timeLabel.text = [NSString stringWithFormat:@"时间：%@",[dic objectForKey:@"time"]];
    
    cell.beginLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"departure"]];
    
    cell.endLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"destination"]];
    
    cell.priceLabel.text = [NSString stringWithFormat:@"%@元",[dic objectForKey:@"price"]];
    
    cell.placeLabel.text = [NSString stringWithFormat:@"剩余%@票",[dic objectForKey:@"place"]];
    
    cell.driverLabel.text = [NSString stringWithFormat:@"司机%@",[dic objectForKey:@"driverID"]];
    
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dic = self.routeData[indexPath.row];
    
    OrderDetailViewController *ovc = [[OrderDetailViewController alloc]init];
    ovc.routeDic = dic;
    NSLog(@"route: %@",dic);
    
    [self.navigationController pushViewController:ovc animated:YES];
    
}



@end
