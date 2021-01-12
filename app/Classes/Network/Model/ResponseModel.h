//
//  ResponseModel.h
//  app
//
//  Created by apple on 2020/12/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ResponseModel : NSObject

@property (nonatomic, assign) long timestamp;   // 时间戳
@property (nonatomic, assign) NSInteger code;   // 代码（0成功，否则失败）
@property (nonatomic, copy) NSString *msg;      // 消息
@property (nonatomic, strong) id data;          // 数据

@property (nonatomic, strong) NSError *error;   // 错误信息

// 请求错误的初始化code msg
- (instancetype)initWithResponseErrorCode:(NSInteger)code msg:(NSString *)msg;
// 请求错误的初始化
- (instancetype)initWithResponseError:(NSError *)error;

@end

NS_ASSUME_NONNULL_END
