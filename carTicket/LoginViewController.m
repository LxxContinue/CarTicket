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
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *registBtn;


@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;

@property (nonatomic)BOOL isRegist;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nameLabel.hidden = YES;
    self.sexBtn.hidden = YES;
    
    
    self.phoneInput.text = @"13107936362";
    self.password.text = @"111";
}
- (IBAction)loginAction:(UIButton *)sender {
    self.isRegist = NO;
    [self.loginBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.registBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.confirmBtn setTitle:@"登录" forState:UIControlStateNormal];
    
    self.nameLabel.hidden = YES;
    self.sexBtn.hidden = YES;
    
}
- (IBAction)registAction:(UIButton *)sender {
    self.isRegist = YES;
    [self.loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.registBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.confirmBtn setTitle:@"注册" forState:UIControlStateNormal];
    
    self.nameLabel.hidden = NO;
    self.sexBtn.hidden = NO;
    
}



- (IBAction)confirmAction:(UIButton *)sender {
    if([self.phoneInput.text  isEqual: @""] || [self.password.text isEqual:@""]){
        return;
    }
    //注册
    if(self.isRegist){
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        
        [dic setObject:self.phoneInput.text forKey:@"user_phone"];
        [dic setObject:self.password.text forKey:@"password"];
        [dic setObject:self.nameLabel.text forKey:@"user_name"];
        if (self.sexBtn.selectedSegmentIndex==0) {
            [dic setObject:@"男"  forKey:@"user_sex"];
        }else {
            [dic setObject:@"女"  forKey:@"user_sex"];
        }
        //注册插入信息
        NSString *str =[self insertDataBase:dic ToSheet:@"user_info"];
        
        if (![str isEqualToString:@""]) {
            NSString * content = [NSString stringWithFormat:@"user_phone = '%@'",self.phoneInput.text];
            
            NSArray * task = [self searchDataBase:content InSheet:@"user_info" OrderBy:@"user_phone"];
            NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
            NSLog(@"search task:%@",task);
            dic = task[0];
                
            NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:dic requiringSecureCoding:YES error:nil];
            [[NSUserDefaults standardUserDefaults] setObject:userData forKey:@"userInfo"];
            
            NSLog(@"userinfo %@",dic);
            
            [self changeRootView];
        }
    }
    //登录
    else {
        //验证密码
        NSString * content = [NSString stringWithFormat:@"user_phone = '%@'",self.phoneInput.text];
        
        NSArray * task = [self searchDataBase:content InSheet:@"user_info" OrderBy:@"user_phone"];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        NSLog(@"search task:%@",task);
        dic = task[0];
        
        if([self.password.text isEqualToString:[dic objectForKey:@"password"]]){
            
            NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:dic requiringSecureCoding:YES error:nil];
            [[NSUserDefaults standardUserDefaults] setObject:userData forKey:@"userInfo"];
            
            NSLog(@"userinfo %@",dic);
            
            [self changeRootView];
        }
        else {
            [self showError:@"密码错误，请重试"];
        }
    }
}

-(void)changeRootView{
    //登入成功
    TabBarViewController *tvc = [[TabBarViewController alloc ] init];
    AppDelegate *delegete = (AppDelegate *)[[UIApplication  sharedApplication] delegate];
    delegete.window.rootViewController = tvc;
}


#pragma mark - UITextFieldDelegate
//点击return收起键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return [textField resignFirstResponder];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}



@end
