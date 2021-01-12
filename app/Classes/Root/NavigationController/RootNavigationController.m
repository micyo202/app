//
//  RootNavigationController.m
//  app
//
//  Created by apple on 2020/12/28.
//

#import "RootNavigationController.h"

@interface RootNavigationController () <UIGestureRecognizerDelegate>

@end

@implementation RootNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    // 右滑返回手势代理
    self.interactivePopGestureRecognizer.delegate = self;
}

#pragma mark - 重写pushViewController:方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    //viewController.modalPresentationStyle = UIModalPresentationFullScreen;
    if (self.viewControllers.count > 0) {
        [viewController setHidesBottomBarWhenPushed:YES];   // 隐藏底部tabBar
    }
    [super pushViewController:viewController animated:animated];
}

#pragma mark - 设置右滑返回手势代理在根视图不启用
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return self.childViewControllers.count > 1;
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
