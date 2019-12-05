//
//  OrderDetailViewController.m
//  carTicket
//
//  Created by LXX on 2019/12/4.
//  Copyright © 2019年 LXX. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "ConnectDataController.h"
#import <OHMySQL.h>

@interface OrderDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *orderID;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *beginLabel;
@property (weak, nonatomic) IBOutlet UILabel *endLabel;

@property (weak, nonatomic) IBOutlet UILabel *driverName;
@property (weak, nonatomic) IBOutlet UILabel *driverPhone;
@property (weak, nonatomic) IBOutlet UILabel *driverID;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *seatLabel;

@property (weak, nonatomic) IBOutlet UITextField *seatInput;

@property(nonatomic) NSMutableDictionary *driveDic;

@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:80.0/255 green:141.0/255 blue:219.0/255 alpha:1.0];
    
    self.driveDic = [[NSMutableDictionary alloc]init];
    
    
    [self searchDriveData];
    [self setDataView];
}

-(void)searchDriveData{
    NSString * content = [NSString stringWithFormat:@"driver_id = '%@'",[self.routeDic objectForKey:@"driver_id"]];
    
    
    NSArray * task = [self searchDataBase:content InSheet:@"driver_info" OrderBy:@"driver_id"];
    NSLog(@"search task:%@",task);
    self.driveDic = [[NSMutableDictionary alloc]init];
    self.driveDic  = task[0];
    
    self.driverName.text =[NSString stringWithFormat:@"%@",[self.driveDic objectForKey:@"driver_name"]];
    self.driverID.text =[NSString stringWithFormat:@"司机编号：%@",[self.driveDic objectForKey:@"driver_id"]];
    self.driverPhone.text =[NSString stringWithFormat:@"联系方式：%@",[self.driveDic objectForKey:@"driver_phone"]];
}

-(void)setDataView{
    self.orderID.text = self.order_id;
    
    self.timeLabel.text = [NSString stringWithFormat:@"时间：%@",[self.routeDic objectForKey:@"time"]];
    self.beginLabel.text = [NSString stringWithFormat:@"出发地：%@",[self.routeDic objectForKey:@"departure"]];
    self.endLabel.text = [NSString stringWithFormat:@"目的地：%@",[self.routeDic objectForKey:@"destination"]];
    self.priceLabel.text = [NSString stringWithFormat:@"%@元",[self.routeDic objectForKey:@"price"]];
    self.seatLabel.text = [NSString stringWithFormat:@"剩余%@票",[self.routeDic objectForKey:@"seat"]];
    
}

- (IBAction)confirmBtn:(UIButton *)sender {
    
    int count = (int)[self.seatInput.text integerValue];//购票
    int sum = (int)[[self.routeDic objectForKey:@"seat"] integerValue];//剩余
    if(count > sum)
       [self showError:@"购票数大于剩余票数"];
    
    NSData *deData = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    NSDictionary * userInfo = [NSKeyedUnarchiver unarchiveObjectWithData:deData];
    
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    
    [dic setObject:[userInfo objectForKey:@"user_id"] forKey:@"user_id"];
    [dic setObject:[self.driveDic objectForKey:@"driver_id"] forKey:@"driver_id"];

    //注册插入信息
    NSString *str =[self insertDataBase:dic ToSheet:@"user_info"];
    
    if (![str isEqualToString:@""]) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"购票成功" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

            [self.navigationController popViewControllerAnimated:YES];
            
        }];
        [alertController addAction:defaultAction];
        [self.navigationController presentViewController:alertController animated:YES completion:nil];
        
        NSLog(@"order %@",dic);

    }
}

@end
