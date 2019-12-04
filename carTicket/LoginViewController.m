//
//  LoginViewController.m
//  carTicket
//
//  Created by LXX on 2019/12/4.
//  Copyright © 2019年 LXX. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "TabBarViewController.h"
#import "ConnectDataController.h"
#import <OHMySQL.h>

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneInput;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *nameLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sexBtn;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)loginAction:(UIButton *)sender {
    if([self.phoneInput.text  isEqual: @""] || [self.password.text isEqual:@""] || [self.nameLabel.text isEqual:@""]){
        return;
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    
    [dic setObject:self.phoneInput.text forKey:@"user_phone"];
    [dic setObject:self.password.text forKey:@"password"];
    [dic setObject:self.nameLabel.text forKey:@"user_name"];
    if (self.sexBtn.selectedSegmentIndex==0) {
        [dic setObject:@"男"  forKey:@"user_sex"];
    }else {
        [dic setObject:@"女"  forKey:@"user_sex"];
    }
    
    NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:dic requiringSecureCoding:YES error:nil];
    [[NSUserDefaults standardUserDefaults] setObject:userData forKey:@"userInfo"];
    
    [self addUserToDataBase:dic];
    
    TabBarViewController *tvc = [[TabBarViewController alloc ] init];
    AppDelegate *delegete = (AppDelegate *)[[UIApplication  sharedApplication] delegate];
    delegete.window.rootViewController = tvc;
    
}
//注册插入信息
-(void)addUserToDataBase:(NSDictionary *)info{
    
    [self insertDataBase:info ToSheet:@"user_info"];
    
}


@end
