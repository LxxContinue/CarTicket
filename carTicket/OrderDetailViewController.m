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

@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:80.0/255 green:141.0/255 blue:219.0/255 alpha:1.0];
    
    [self setDataView];
}
-(void)setDataView{
    self.orderID.text = @"20190122214";
    self.timeLabel.text = [NSString stringWithFormat:@"时间：%@",[self.routeDic objectForKey:@"time"]];
    self.beginLabel.text = [NSString stringWithFormat:@"出发地：：%@",[self.routeDic objectForKey:@"departure"]];
    self.endLabel.text = [NSString stringWithFormat:@"目的地：%@",[self.routeDic objectForKey:@"destination"]];
    self.priceLabel.text = [NSString stringWithFormat:@"%@元",[self.routeDic objectForKey:@"price"]];
}

- (IBAction)confirmBtn:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
