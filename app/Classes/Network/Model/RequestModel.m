//
//  RequestModel.m
//  app
//
//  Created by apple on 2020/12/29.
//

#import "RequestModel.h"

@implementation RequestModel

#pragma mark - 初始化属性值
- (void)initializeProperty {
    _timestamp = [NSDate.date timeIntervalSince1970]*1000;
    YZDeviceModel *deviceModel = [[UIDevice alloc] yz_deviceInfo];
    _type = deviceModel.deviceModel;
    _os = deviceModel.systemVersion;
}

@end
