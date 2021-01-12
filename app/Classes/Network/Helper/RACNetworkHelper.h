//
//  RACNetworkHelper.h
//  app
//
//  Created by apple on 2020/12/29.
//

#import <Foundation/Foundation.h>
#import "RequestModel.h"
#import "ResponseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RACNetworkHelper : NSObject

SingletonH(RACNetworkHelper)

// 网络请求（base64图片上传）
- (RACSignal *)requestModel:(RequestModel *)requestModel url:(NSString *)url loading:(BOOL)loading;

// 网络请求（file图片上传）
- (RACSignal *)requestModel:(RequestModel *)requestModel imageNames:(NSArray *)imageNames url:(NSString *)url loading:(BOOL)loading;

@end

NS_ASSUME_NONNULL_END
