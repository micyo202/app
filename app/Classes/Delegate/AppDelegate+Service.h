//
//  AppDelegate+Service.h
//  app
//
//  Created by apple on 2020/12/28.
//

#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (Service)

//初始化Window组件
- (void)initializeWindow;

//初始化广告页
- (void)initializeAdvert;

//初始化顶部状态栏样式
- (void)initializeStatusBar;

//初始化导航栏样式
- (void)initializeNavigation;

//显示FPS监测
- (void)showFPS;

// 避免应用程序崩溃，在Crash时收集日志
- (void)initializeAvoidCrash;

@end

NS_ASSUME_NONNULL_END
