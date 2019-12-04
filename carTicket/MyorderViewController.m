//
//  MyorderViewController.m
//  carTicket
//
//  Created by LXX on 2019/12/4.
//  Copyright © 2019年 LXX. All rights reserved.
//

#import "MyorderViewController.h"
#import "ConnectDataController.h"

@interface MyorderViewController ()

@end

@implementation MyorderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createTitle:@"订单详情"];

    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:80.0/255 green:141.0/255 blue:219.0/255 alpha:1.0];
}



@end
