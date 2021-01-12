//
//  BaseViewController.h
//  app
//
//  Created by apple on 2020/12/28.
//

#import <UIKit/UIKit.h>
#import <WRNavigationBar.h>
#import "AppDelegate.h"
#import "AppDelegate+Service.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController

@property (nonatomic, assign) BOOL isWhiteNavigationBar;    // 导航栏是否为白色

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *collectionView;

/**
 * 导航栏添加文本按钮（自定义导航栏按钮）
 *
 * @param titles 文本数组
 * @param isLeft 是否是左边 非左即右
 * @param target 目标
 * @param action 点击方法
 * @param tags tags数组 回调区分用
 */
- (void)addNavigationItemWithTitles:(NSArray *)titles isLeft:(BOOL)isLeft target:(id)target action:(SEL)action tags:(NSArray * _Nullable)tags;

/**
 * 导航栏添加图片按钮（自定义导航栏按钮）
 *
 * @param imageNames 图标数组
 * @param isLeft 是否是左边 非左即右
 * @param target 目标
 * @param action 点击方法
 * @param tags tags数组 回调区分用
 */
- (void)addNavigationItemWithImageNames:(NSArray *)imageNames isLeft:(BOOL)isLeft target:(id)target action:(SEL)action tags:(NSArray * _Nullable)tags;

#pragma mark - 点击返回按钮
- (void)backBarButtonItemClicked;

@end

NS_ASSUME_NONNULL_END
