//
//  TabBarViewController.m
//  nuonuo
//
//  Created by LXX on 2019/11/9.
//  Copyright © 2019年 LXX. All rights reserved.
//

#import "TabBarViewController.h"
#import "HomeViewController.h"
#import "MyorderViewController.h"
#import "PersonViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置TabBarItemTestAttributes的颜色
    [self setUpTabBarItemTextAttributes];
    //设置子控制器
    [self setUpChildViewController];

    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UITabBar appearance] setBackgroundImage:[self imageWithColor:[UIColor whiteColor]]];
    
    // Do any additional setup after loading the view.
}


#pragma mark - Private Methods



//tabBarItem的选中和不选中文字属性
- (void) setUpTabBarItemTextAttributes {
    //普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    //选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:27.0/255 green:154.0/255 blue:230.0/255 alpha:1.0];
    
    //设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor grayColor],NSFontAttributeName:[UIFont fontWithName:@"Heiti SC" size:12.0]}            forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    //tabBar.badgeValue = @"99";
    
    
}


//添加四个子控制器
- (void) setUpChildViewController
{
    //如果要分段显示，使用FirstViewController
    HomeViewController *hvc = [[HomeViewController alloc] init];
    [self addOneChildViewController:[[UINavigationController alloc] initWithRootViewController:hvc] withTitle:@"首页" imageName:@"首页" selectedImageName:@"首页"];

    MyorderViewController *mvc = [[MyorderViewController alloc] init];
    [self addOneChildViewController:[[UINavigationController alloc] initWithRootViewController:mvc] withTitle:@"订单" imageName:@"订单" selectedImageName:@"订单"];
    
    PersonViewController *pvc = [[PersonViewController alloc] init];
    [self addOneChildViewController:[[UINavigationController alloc] initWithRootViewController:pvc] withTitle:@"我的" imageName:@"我的" selectedImageName:@"我的"];
    
}
/**
 *  添加一个子控制器
 *
 *  @param viewController    控制器
 *  @param title             标题
 *  @param imageName         图片
 *  @param selectedImageName 选中图片
 */
- (void)addOneChildViewController:(UIViewController *)viewController withTitle:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *) selectedImageName
{
    viewController.view.backgroundColor = [UIColor whiteColor];
    viewController.tabBarItem.title = title;
    viewController.tabBarItem.imageInsets = UIEdgeInsetsMake(-3, 0, 3, 0);
    viewController.tabBarItem.image = [UIImage imageNamed:imageName];
    UIImage *image = [UIImage imageNamed:selectedImageName];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.selectedImage = image ;
    
    [self addChildViewController:viewController];
}

- (UIImage *)imageWithColor:(UIColor *)color
{
    NSParameterAssert(color != nil);
    CGRect rect = CGRectMake(0,0,1,1);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);   // Fill it with your color
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
