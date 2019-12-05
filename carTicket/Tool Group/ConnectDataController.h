//
//  ConnectDataController.h
//  carTicket
//
//  Created by LXX on 2019/12/4.
//  Copyright © 2019年 LXX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController(netDateDeal)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define kIs_iphone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define kIs_iPhoneX SCREEN_WIDTH >=375.0f && SCREEN_HEIGHT >=812.0f&& kIs_iphone
/*状态栏高度*/
#define kStatusBarHeight (CGFloat)(kIs_iPhoneX?(44.0):(20.0))


/*
 查找条件以字符串形式 NSString *sqltStr =@"name = '王五' AND phoneNumber = '18895322310'";
 修改内容以字典形式 NSDictionary *dic = @{@"phoneNumber" : @“18862033568”};
 */

/*单表查询*/
- (NSArray*)selectDataBase:(NSString *)sheet;
/*条件查询*/
- (NSArray *)searchDataBase:(NSString*)content InSheet:(NSString *)sheet OrderBy:(NSString *)str;
/*插入数据*/
- (NSString*)insertDataBase:(NSDictionary *)dict ToSheet:(NSString *)sheet;
/*修改数据*/
- (NSString*)modifyDataBase:(NSDictionary *)dict WithConditiom:(NSString*)con ToSheet:(NSString *)sheet;

- (void)createTitle:(NSString *)title ;

- (void)showError:(NSString *)errorMsg;

@end

NS_ASSUME_NONNULL_END
