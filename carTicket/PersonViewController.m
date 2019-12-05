//
//  PersonViewController.m
//  carTicket
//
//  Created by LXX on 2019/12/4.
//  Copyright © 2019年 LXX. All rights reserved.
//

#import "PersonViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "SettingViewController.h"

@interface PersonViewController ()

@end

@implementation PersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的";
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:80.0/255 green:141.0/255 blue:219.0/255 alpha:1.0];
    
    
}
- (IBAction)showUserInfo:(UIButton *)sender {
    NSData *deData = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    NSMutableDictionary * userInfo = [NSKeyedUnarchiver unarchiveObjectWithData:deData];
    
    SettingViewController *svc = [[SettingViewController alloc]init];
    svc.userInfo = userInfo;
    svc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:svc animated:YES];
    
}
- (IBAction)logoutAction:(UIButton *)sender {
    NSString *msg = [NSString stringWithFormat:@"\n确定要退出购票吗？"];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *appDomainStr = [[NSBundle mainBundle] bundleIdentifier];
        [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomainStr];
        LoginViewController *lvc = [[LoginViewController alloc] init];
        //UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:lvc];
        
        AppDelegate *delegete = (AppDelegate *)[[UIApplication  sharedApplication] delegate];
        //delegete.window.rootViewController = nav;
        delegete.window.rootViewController = lvc;
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:nil];
    [alertController addAction:cancelAction];
    [alertController addAction:defaultAction];
    [self.navigationController presentViewController:alertController animated:YES completion:nil];
    
}



@end
