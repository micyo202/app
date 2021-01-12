//
//  RootTabBarController.m
//  app
//
//  Created by apple on 2020/12/28.
//

#import "RootTabBarController.h"
#import "RootNavigationController.h"

@interface RootTabBarController ()

@end

@implementation RootTabBarController

SingletonM(RootTabBarController)

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tabBar.tintColor = UIColor.blackColor; // 设置选中字体颜色
    
    // 设置顶部线条
    [self.tabBar setShadowImage:[self lineImageWithColor:UIColor.whiteColor]];
    
    // 设置背景图片
    [self.tabBar setBackgroundImage:[UIImage imageWithColor:UIColor.whiteColor]];
       
    // 初始化 TabBar 视图（必须先添加属性，在添加控制器，注意顺序）
    [self addTabBarItemsAttributes];
    [self addViewControllers];
}

#pragma mark - 添加 TabBar 属性
- (void)addTabBarItemsAttributes {
    NSArray *tabBarItemsAttributes = @[
                                       @{
                                           CYLTabBarItemTitle           :   @"首页",
                                           CYLTabBarItemImage           :   @"tabbar_home",
                                           CYLTabBarItemSelectedImage   :   @"tabbar_homeHL"
                                           },
                                       @{
                                           CYLTabBarItemTitle           :   @"位置",
                                           CYLTabBarItemImage           :   @"tabbar_location",
                                           CYLTabBarItemSelectedImage   :   @"tabbar_locationHL"
                                           },
                                       @{
                                           CYLTabBarItemTitle           :   @"",
                                           CYLTabBarItemImage           :   @"tabbar_add",
                                           CYLTabBarItemSelectedImage   :   @"tabbar_add"
                                           },
                                       @{
                                           CYLTabBarItemTitle           :   @"消息",
                                           CYLTabBarItemImage           :   @"tabbar_message",
                                           CYLTabBarItemSelectedImage   :   @"tabbar_messageHL"
                                           },
                                       @{
                                           CYLTabBarItemTitle           :   @"我的",
                                           CYLTabBarItemImage           :   @"tabbar_mine",
                                           CYLTabBarItemSelectedImage   :   @"tabbar_mineHL"
                                           }
                                       ];
    
    self.tabBarItemsAttributes = tabBarItemsAttributes;
}

#pragma mark - 添加 TabBar 子视图控制器
- (void)addViewControllers {
    
    // 设置 TabBar 包含的所有视图
    NSArray *controllers = @[
                             @"HomeViewController",
                             @"LocationViewController",
                             @"AddtionViewController",
                             @"MessageViewController",
                             @"InfoViewController"
                             ];
    
    NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
    
    // 使用 block 方法遍历集合
    [controllers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIViewController *viewController = [[NSClassFromString(obj) alloc] init];
        RootNavigationController *rootNavigationController = [[RootNavigationController alloc] initWithRootViewController:viewController];
        [viewControllers addObject:rootNavigationController];
    }];
    
    self.viewControllers = viewControllers;
}

#pragma mark - 自定义TabBar顶部线条
- (UIImage *)lineImageWithColor:(UIColor *)lineColor {

    CGRect rect = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0.5);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(ctx, lineColor.CGColor);
    CGContextFillRect(ctx, rect);
    
    UIImage *lineImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return lineImage;
}

#pragma mark - 点击事件，TabBar点击动画效果控制
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
    NSInteger ids = [self.tabBar.items indexOfObject:item];
    // 执行动画
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (UIView *view in self.tabBar.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [array addObject:view];
        }
    }
    
    // 添加动画,放大效果，并回到原位
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    // 速度控制函数，控制动画运行的节奏
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = 0.08;      // 执行时间
    animation.repeatCount = 1;      // 执行次数
    animation.autoreverses = YES;   // 完成动画后会回到执行动画之前的状态
    animation.fromValue = [NSNumber numberWithFloat:0.8];   // 初始伸缩倍数
    animation.toValue = [NSNumber numberWithFloat:1.2];     // 结束伸缩倍数
    UIView *view = [array objectAtIndex:ids];
    [view.layer addAnimation:animation forKey:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
