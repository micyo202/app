//
//  BasePageScrollViewController.m
//  app
//
//  Created by apple on 2021/1/7.
//

#import "BasePageScrollViewController.h"

@interface BasePageScrollViewController ()

@end

@implementation BasePageScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initializeNavigation];
}

#pragma mark - 初始化导航栏样式
- (void)initializeNavigation {
    
    // 原生导航栏属性设置
    /*
    self.navigationController.navigationBar.barTintColor = DEFAULT_ORANGE_COLOR;// 设置导航栏背景颜色
    self.navigationController.navigationBar.tintColor = UIColor.whiteColor;// 设置导航栏 itemBar 字体颜色
    self.navigationController.navigationBar.translucent = NO;// 半透明效果，默认 YES
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_background"] forBarMetrics:UIBarMetricsDefault];// 导航栏背景图
    //self.navigationController.navigationBar.hidden = YES;// 隐藏导航栏
    //self.navigationController.navigationBar.clipsToBounds = YES;// 隐藏导航栏分割线
    [self.navigationController.navigationBar setShadowImage:[UIImage imageWithColor:HexColor(@"#ffffff", 0.f)]];  // 导航栏分割线颜色为透明
    self.navigationController.navigationBar.titleTextAttributes = @{ NSForegroundColorAttributeName : [UIColor whiteColor] };// 设置导航栏字体颜色
    */
    
    // 设置导航栏统一返回按钮样式
    NSInteger vcCount = self.navigationController.viewControllers.count;
    if (vcCount > 1 || self.navigationController.presentingViewController != nil) {
        [self addNavigationItemWithImageNames:@[@"navigation_back_white"] isLeft:YES target:self action:@selector(backBarButtonItemClicked) tags:nil];
    } else {
        self.navigationItem.hidesBackButton = YES;
        UIBarButtonItem *nilBar = [[UIBarButtonItem alloc] initWithCustomView:[UIView new]];
        self.navigationItem.leftBarButtonItem = nilBar;
    }
    
}

#pragma mark - 设置导航栏图片Item按钮
- (void)addNavigationItemWithImageNames:(NSArray *)imageNames isLeft:(BOOL)isLeft target:(id)target action:(SEL)action tags:(NSArray *)tags {
    NSMutableArray *items = [[NSMutableArray alloc] init];
    NSInteger i = 0;
    for (NSString *imageName in imageNames) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        btn.frame = CGRectMake(0, 0, 30, 30);
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        // 设置偏移
        if (isLeft) {
            [btn setContentEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
        }else{
            [btn setContentEdgeInsets:UIEdgeInsetsMake(0, 10, 0, -10)];
        }
        
        btn.tag = [tags[i++] integerValue];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
        [items addObject:item];
    }
    if (isLeft) {
        self.navigationItem.leftBarButtonItems = items;
    } else {
        self.navigationItem.rightBarButtonItems = items;
    }
}

#pragma mark - 导航栏返回按钮点击事件
- (void)backBarButtonItemClicked {
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
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
