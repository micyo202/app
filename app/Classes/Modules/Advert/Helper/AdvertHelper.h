//
//  AdvertHelper.h
//  app
//
//  Created by apple on 2020/12/29.
//

#import <Foundation/Foundation.h>
#import "AdvertView.h"

NS_ASSUME_NONNULL_BEGIN

@interface AdvertHelper : NSObject

SingletonH(AdvertHelper)

+ (void)showAdvertView:(NSArray<NSString *> *)imageArray;

@end

NS_ASSUME_NONNULL_END
