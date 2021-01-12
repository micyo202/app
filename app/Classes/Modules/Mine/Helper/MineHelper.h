//
//  MineHelper.h
//  app
//
//  Created by apple on 2020/12/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineHelper : NSObject

SingletonH(MineHelper)

// 我的模块基本数据（第一级）
- (NSMutableArray *)infoData;

- (NSMutableArray *)settingData;

- (NSMutableArray *)generalData;

@end

NS_ASSUME_NONNULL_END
