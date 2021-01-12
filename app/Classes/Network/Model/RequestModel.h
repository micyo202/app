//
//  RequestModel.h
//  app
//
//  Created by apple on 2020/12/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RequestModel : NSObject

@property (nonatomic, assign) long timestamp;       // 时间戳
@property (nonatomic, copy) NSString *type;         // 设备类型
@property (nonatomic, copy) NSString *os;           // 系统：iOS / Android
@property (nonatomic, copy) NSDictionary *data;     // 请求数据

- (void)initializeProperty;                         // 初始化属性值

@end

NS_ASSUME_NONNULL_END
