//
//  BaseWebViewController.h
//  app
//
//  Created by apple on 2021/1/5.
//

#import "BaseViewController.h"
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseWebViewController : BaseViewController

@property (nonatomic, strong) WKWebView * webView;
@property (nonatomic, strong) UIProgressView * progressView;
@property (nonatomic, strong) UIColor *progressViewColor;
@property (nonatomic, weak) WKWebViewConfiguration * webConfiguration;
@property (nonatomic, copy) NSString * url;

//在多级跳转后，是否在返回按钮右侧展示关闭按钮
@property(nonatomic,assign) BOOL isShowCloseItem;

- (instancetype)initWithUrl:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
