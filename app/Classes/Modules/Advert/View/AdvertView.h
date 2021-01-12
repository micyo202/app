//
//  AdvertView.h
//  app
//
//  Created by apple on 2020/12/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

UIKIT_EXTERN NSString *const NotificationContants_Advert_Key;

@interface AdvertView : UIView

// 显示广告页面方法
- (void)show;

// 图片路径
@property (nonatomic, copy) NSString *filePath;

@end

NS_ASSUME_NONNULL_END
