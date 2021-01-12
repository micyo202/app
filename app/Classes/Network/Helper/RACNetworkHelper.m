//
//  RACNetworkHelper.m
//  app
//
//  Created by apple on 2020/12/29.
//

#import "RACNetworkHelper.h"
#import <AFNetworking.h>
#import <AFNetworkActivityIndicatorManager.h>
#import "ServerMarcos.h"

@interface RACNetworkHelper ()

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation RACNetworkHelper

SingletonM(RACNetworkHelper)

#pragma mark - 初始化参数
- (AFHTTPSessionManager *)manager {
    if(!_manager){
        //_manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:SERVER_URL]];
        _manager = [AFHTTPSessionManager manager];
        
        // 设置请求头类型
        _manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [_manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        // 请求超时，时间设置
        _manager.requestSerializer.timeoutInterval = 20.f;
        // 关闭缓存避免干扰测试
        _manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        
        // 声明返回的结果类型
        // 不加上这句话，会报“Request failed: unacceptable content-type: text/plain”错误，因为我们要获取text/plain类型数据
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        // 如果报接受类型不一致请替换一致text/html  或者 text/plain
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                              @"text/json",
                                                              @"text/javascript",
                                                              @"text/html",
                                                              @"text/plain",
                                                              @"text/html; charset=UTF-8",
                                                              nil];
        
        // 开启网络监测
        /*
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
        [_manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            //AFNetworkReachabilityStatusUnknown          = -1,
            //AFNetworkReachabilityStatusNotReachable     = 0,
            //AFNetworkReachabilityStatusReachableViaWWAN = 1,
            //AFNetworkReachabilityStatusReachableViaWiFi = 2,
            DLog(@"当前网络状态：%ld", (long)status);
        }];
        [_manager.reachabilityManager startMonitoring];
        */
    }
    return _manager;
}

#pragma mark - 网络请求（base64图片上传）
- (RACSignal *)requestModel:(RequestModel *)requestModel url:(NSString *)url loading:(BOOL)loading {
        
    [requestModel initializeProperty];   // 初始化对象属性值
    
    DLog(@"\n请求对象：requestModel = \n%@", [requestModel modelToJSONString]);
    
    @weakify(self);
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        @strongify(self);
        // 获取request
        NSError *serializationError = nil;
        __block NSMutableURLRequest *request = [self.manager.requestSerializer requestWithMethod:@"POST" URLString:[NSString stringWithFormat:@"%@%@", SERVER_URL, url] parameters:[requestModel modelToJSONObject] error:&serializationError];
        
        // 设置 Token
        //NSString *token = @"ec5be095-f79f-4cb4-a21d-98145ffe3f06";
        //[request setValue:[NSString stringWithFormat:@"Bearer %@",token] forHTTPHeaderField:@"Authorization"];
        
        if (serializationError) {
            //初始化、返回数据模型
            ResponseModel *responseModel = [[ResponseModel alloc] initWithResponseError:[self transformError:serializationError]];
            [subscriber sendNext:responseModel];
            [subscriber sendCompleted];
        }
        
        //if(loading) [MBProgressHUD showActivityMessageInWindow:@""];    // 添加hud遮挡
        if(loading) [SVProgressHUD showActivity];    // 添加hud遮挡
        
        // 获取请求任务
        __block NSURLSessionDataTask *task = nil;
        task = [self.manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            
            //if(loading) [MBProgressHUD hideHUD];    // 取消遮挡
            if(loading) [SVProgressHUD hideHUD];    // 取消遮挡
            
            ResponseModel *responseModel = nil;
            
            if (error) {
                //初始化、返回数据模型
                responseModel = [[ResponseModel alloc] initWithResponseError:[self transformError:error]];
            } else {
                NSDictionary *responseDict = [YZJsonUtil dictionaryOrArrayWithJSONSData:responseObject];
                // 处理结果数据
                DLog(@"\n响应结果：responseDict = \n%@", responseDict);
                responseModel = [ResponseModel modelWithDictionary:responseDict];
            }
            [subscriber sendNext:responseModel];
            [subscriber sendCompleted];
        }];
        
        // 开启请求任务
        [task resume];
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
    
    return [signal replayLazily];   // 多次订阅同样的信号，执行一次
}

#pragma mark - 网络请求（file图片上传）
- (RACSignal *)requestModel:(RequestModel *)requestModel imageNames:(NSArray *)imageNames url:(NSString *)url loading:(BOOL)loading {
    
    [requestModel initializeProperty];   // 初始化对象属性值
    
    DLog(@"\n请求对象：requestModel = \n%@", [requestModel modelToJSONString]);
    
    @weakify(self);
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        @strongify(self);
        // 获取request
        NSError *serializationError = nil;
        __block NSMutableURLRequest *request = [self.manager.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:[NSString stringWithFormat:@"%@%@", SERVER_URL, url] parameters:[requestModel modelToJSONObject] constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            
            // 设置 Token
            //NSString *token = @"ec5be095-f79f-4cb4-a21d-98145ffe3f06";
            //[request setValue:[NSString stringWithFormat:@"Bearer %@",token] forHTTPHeaderField:@"Authorization"];
            
            // 上传文件，服务器对应 file[0,1,2...]
            int ids = 0;
            for (NSString *imageName in imageNames) {
                UIImage *image = [UIImage imageNamed:imageName];
                NSData *data = UIImageJPEGRepresentation(image, 1.f);
                [formData appendPartWithFileData:data name:[NSString stringWithFormat:@"file%d", ids] fileName:imageName mimeType:@"image/jpeg"];
                ids++;
            }
            
        } error:&serializationError];
        
        if (serializationError) {
            //初始化、返回数据模型
            ResponseModel *responseModel = [[ResponseModel alloc] initWithResponseError:[self transformError:serializationError]];
            [subscriber sendNext:responseModel];
            [subscriber sendCompleted];
        }
        
        if(loading) [SVProgressHUD showActivity];    // 添加hud遮挡
        
        // 获取请求任务
        __block NSURLSessionDataTask *task = [self.manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            
            //if(loading) [MBProgressHUD hideHUD];    // 取消遮挡
            if(loading) [SVProgressHUD hideHUD];    // 取消遮挡
            
            ResponseModel *responseModel = nil;
            
            if (error) {
                //初始化、返回数据模型
                responseModel = [[ResponseModel alloc] initWithResponseError:[self transformError:error]];
            } else {
                NSDictionary *responseDict = [YZJsonUtil dictionaryOrArrayWithJSONSData:responseObject];
                // 处理结果数据
                DLog(@"\n响应结果：responseDict = \n%@", responseDict);
                responseModel = [ResponseModel modelWithDictionary:responseDict];
            }
            [subscriber sendNext:responseModel];
            [subscriber sendCompleted];
        }];
        
        // 开启请求任务
        [task resume];
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
    
    return [signal replayLazily];   // 多次订阅同样的信号，执行一次
}

#pragma mark - 请求错误解析
- (NSError *)transformError:(NSError *)error {
    NSInteger errorCode = error.code;
    NSString *errorMsg = @"服务器出错了，请稍后重试~";
    // 其实这里需要处理后台数据错误
    // errorCode错误码解析
    // 1xx : 请求消息 [100  102]
    // 2xx : 请求成功 [200  206]
    // 3xx : 请求重定向[300  307]
    // 4xx : 请求错误  [400  417] 、[422 426] 、449、451
    // 5xx 、600: 服务器错误 [500 510] 、600
    NSInteger firstErrorCode = errorCode/100;
    if (firstErrorCode>0) {
        if (firstErrorCode==4) {
            // 请求出错了，请稍后重试
            if (errorCode == 408) {
                errorMsg = @"请求超时，请稍后再试~";
            }else{
                errorMsg = @"请求出错了，请稍后重试~";
            }
        }else if (firstErrorCode == 5 || firstErrorCode == 6){
            // 服务器出错了，请稍后重试
            errorMsg = @"服务器出错了，请稍后重试~";
            
        }else if (!self.manager.reachabilityManager.isReachable){
            // 网络不给力，请检查网络
            errorMsg = @"网络开小差了，请稍后重试~";
        }
    }else{
        if (!self.manager.reachabilityManager.isReachable){
            // 网络不给力，请检查网络
            errorMsg = @"网络开小差了，请稍后重试~";
        }
    }
    
    switch (errorCode) {
        case 400:{
            // 请求失败
            break;
        }
        case 403:{
            // 服务器拒绝请求
            break;
        }
        case 422:{
            // 请求出错
            break;
        }
        default:
            // 从error中解析
            if ([error.domain isEqual:NSURLErrorDomain]) {
                errorMsg = @"请求出错了，请稍后重试~";
                switch (error.code) {
                    case NSURLErrorCancelled:{
                        errorMsg = @"取消错误！";
                        break;
                    }
                    case NSURLErrorBadURL:{
                        errorMsg = @"无效的URL！";
                        break;
                    }
                    case NSURLErrorTimedOut:{
                        errorMsg = @"访问服务器超时！";
                        break;
                    }
                    case NSURLErrorUnsupportedURL:{
                        errorMsg = @"不支持的URL地址！";
                        break;
                    }
                    case NSURLErrorCannotFindHost:{
                        errorMsg = @"找不到服务器！";
                        break;
                    }
                    case NSURLErrorCannotConnectToHost:{
                        errorMsg = @"无法连接服务器！";
                        break;
                    }
                    case NSURLErrorNetworkConnectionLost:{
                        errorMsg = @"网络连接异常！";
                        break;
                    }
                    case NSURLErrorDNSLookupFailed:{
                        errorMsg = @"DNS解析失败！";
                        break;
                    }
                    case NSURLErrorHTTPTooManyRedirects:{
                        errorMsg = @"HTTP重定向太多！";
                        break;
                    }
                    case NSURLErrorResourceUnavailable:{
                        errorMsg = @"资源不可用！";
                        break;
                    }
                    case NSURLErrorNotConnectedToInternet:{
                        errorMsg = @"无网络连接！";
                        break;
                    }
                    case NSURLErrorRedirectToNonExistentLocation:{
                        errorMsg = @"重定向位置不存在！";
                        break;
                    }
                    case NSURLErrorBadServerResponse:{
                        errorMsg = @"服务器响应异常！";
                        break;
                    }
                    case NSURLErrorUserCancelledAuthentication:{
                        errorMsg = @"用户取消授权！";
                        break;
                    }
                    case NSURLErrorUserAuthenticationRequired:{
                        errorMsg = @"需要用户授权！";
                        break;
                    }
                    case NSURLErrorZeroByteResource:{
                        errorMsg = @"零字节资源！";
                        break;
                    }
                    case NSURLErrorCannotDecodeRawData:{
                        errorMsg = @"无法解码原始数据！";
                        break;
                    }
                    case NSURLErrorCannotDecodeContentData:{
                        errorMsg = @"无法解码内容数据！";
                        break;
                    }
                    case NSURLErrorCannotParseResponse:{
                        errorMsg = @"无法解析响应！";
                        break;
                    }
                }
            }
    }
    
    return [NSError errorWithDomain:errorMsg code:errorCode userInfo:nil];
}

@end
