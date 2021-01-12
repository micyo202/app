//
//  ResponseModel.m
//  app
//
//  Created by apple on 2020/12/29.
//

#import "ResponseModel.h"

@implementation ResponseModel

// 请求错误的初始化code msg
- (instancetype)initWithResponseErrorCode:(NSInteger)code msg:(NSString *)msg {
    if (self = [super init]) {
        self.code = code;
        self.msg = msg;
        self.timestamp = [NSDate.date timeIntervalSince1970]*1000;
    }
    return self;
}

// 请求错误的初始化
- (instancetype)initWithResponseError:(NSError *)error{
    if (self = [super init]) {
        self.code = error.code;
        self.msg = error.domain;
        self.timestamp = [NSDate.date timeIntervalSince1970]*1000;
    }
    return self;
}

#pragma mark - 设置黑名单属性
+ (nullable NSArray<NSString *> *)modelPropertyBlacklist {
    return @[@"error"];
}

@end
