//
//  DemoViewController.m
//  app
//
//  Created by apple on 2021/1/4.
//

#import "DemoViewController.h"

#import <UIAlertController+Blocks/UIAlertController+Blocks.h>
#import <CustomIOSAlertView/CustomIOSAlertView.h>
#import <LCActionSheet/LCActionSheet.h>
#import <ActionSheetPicker-3.0/ActionSheetPicker.h>
#import <YBPopupMenu/YBPopupMenu.h>
#import <JDStatusBarNotification/JDStatusBarNotification.h>
#import <MJRefresh/MJRefresh.h>
#import <TZImagePickerController.h>
#import "BaseWebViewController.h"
#import "RACNetworkHelper.h"

@interface DemoViewController () <UITableViewDelegate, UITableViewDataSource, CustomIOSAlertViewDelegate, YBPopupMenuDelegate, TZImagePickerControllerDelegate>

@property (nonatomic, strong) YZPermission *yzPermission;   // 权限访问控制类
@property (nonatomic, strong) NSArray *data;                // 数据

@end

@implementation DemoViewController

static NSString *const cellReuseIdentifier = @"cellReuseIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"Demo";
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellReuseIdentifier];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //self.tableView.mj_header.hidden = YES;
    //self.tableView.mj_footer.hidden = YES;
    [self.view addSubview:self.tableView];
}

- (NSArray *)data {
    if(!_data){
        _data = @[
                  @{@"code" : @"1", @"name" : @"DLog日志输出（请查看控制台）"},
                  @{@"code" : @"2", @"name" : @"加解密（请查看控制台）"},
                  @{@"code" : @"3", @"name" : @"AvoidCrash防止崩溃测试（请查看控制台）"},
                  @{@"code" : @"4", @"name" : @"UIAlertController -> Alert"},
                  @{@"code" : @"5", @"name" : @"UIAlertController -> ActionSheet"},
                  @{@"code" : @"6", @"name" : @"LCActionSheet（Sheet底部选择视图）"},
                  @{@"code" : @"7", @"name" : @"CustomIOSAlertView自定义弹框视图"},
                  @{@"code" : @"8", @"name" : @"ActionSheetPicker底部选择器"},
                  @{@"code" : @"9", @"name" : @"YBPopupMenu气泡菜单"},
                  @{@"code" : @"10", @"name" : @"JDStatusBarNotification状态栏提示"},
                  @{@"code" : @"11", @"name" : @"MBProgressHUD提示框"},
                  @{@"code" : @"12", @"name" : @"相关组件示例"},
                  @{@"code" : @"13", @"name" : @"YZAuthID指纹ID/面容ID"},
                  @{@"code" : @"14", @"name" : @"YZPermission权限访问"},
                  @{@"code" : @"15", @"name" : @"YZJsonUtil转换"},
                  @{@"code" : @"16", @"name" : @"YZSandBoxUtil存储读取"},
                  @{@"code" : @"17", @"name" : @"YZVerify校验方法"},
                  @{@"code" : @"18", @"name" : @"YZLocationConverterUtil经纬度转换"},
                  @{@"code" : @"19", @"name" : @"YZIPAddressUtil获取IP地址"},
                  @{@"code" : @"20", @"name" : @"YZRoundedBorder自定义多圆角视图标签"},
                  @{@"code" : @"21", @"name" : @"YZUserDefaule存储读取"},
                  @{@"code" : @"22", @"name" : @"YZDate日期类型格式转换"},
                  @{@"code" : @"23", @"name" : @"WebView"},
                  @{@"code" : @"24", @"name" : @"TZImagePickerController照片选择"},
                  @{@"code" : @"25", @"name" : @"RACNetworking请求数据"},
                  @{@"code" : @"26", @"name" : @"RACNetworking上传Base64图片"},
                  @{@"code" : @"27", @"name" : @"RACNetworking上传File图片"},
                  @{@"code" : @"28", @"name" : @"TableView表格视图"},
                  @{@"code" : @"29", @"name" : @"CollectionView集合视图"},
                  @{@"code" : @"30", @"name" : @"DragView点击放大拖拽"},
                  @{@"code" : @"31", @"name" : @"PageScrollView多视图滑动"}
                  ];
    }
    return _data;
}

#pragma mark - <UITableView>代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier];
    cell.backgroundColor = RandomColor;
    NSString *name = [self.data[indexPath.row] objectForKey:@"name"];
    cell.textLabel.textColor = UIColor.whiteColor;
    cell.textLabel.text = name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    //UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath]; // 获取当前点击cell
    NSInteger code = [[self.data[indexPath.row] objectForKey:@"code"] integerValue];
    if(1 == code){
        DLog(@"测试输出日志...");
    }
    if(2 == code){
        NSString *str = @"Yanzheng";
        NSString *key = @"com.micyo";
        NSLog(@"原始字符串：%@", str);
        NSLog(@"Salt撒盐：%@", [YZSalt encryptString:str length:2]);
        NSLog(@"Base64编码：%@", [YZBase64 encodeString:str]);
        NSLog(@"Base64解码：%@", [YZBase64 decodeString:@"WWFuemhlbmc="]);
        NSLog(@"AES加密：%@", [YZAES encryptString:str key:key]);
        NSLog(@"AES解密：%@", [YZAES decryptString:@"YgdQb8aHUwy+6mzuHEMdkA==" key:key]);
        NSLog(@"MD5加密：%@", [YZMD5 encryptString:str]);
    }
    if(3 == code){
        
        NSString *nilStr = nil;
        
        NSMutableArray *array = [NSMutableArray array];
        [array addObject:nilStr];
        
        /*
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setObject:nilStr forKey:nilStr];
        */
        
    }
    if(4 == code){
            [UIAlertController showAlertInViewController:self withTitle:@"标题" message:@"这是消息内容" cancelButtonTitle:@"取消-0" destructiveButtonTitle:@"确定-1" otherButtonTitles:@[@"选项-2", @"选项-3", @"选项-4"] tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                NSLog(@"点击按钮序号：%ld", buttonIndex);
            }];
        }
        if(5 == code){
            [UIAlertController showActionSheetInViewController:self withTitle:@"标题" message:@"这是消息内容" cancelButtonTitle:@"取消-0" destructiveButtonTitle:@"确定-1" otherButtonTitles:@[@"选项-2", @"选项-3", @"选项-4"] popoverPresentationControllerBlock:nil tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                NSLog(@"点击按钮序号：%ld", buttonIndex);
            }];
        }
        if(6 == code){
            LCActionSheet *actionSheet = [LCActionSheet sheetWithTitle:@"提示信息内容" cancelButtonTitle:@"取消-0" clicked:^(LCActionSheet *actionSheet, NSInteger buttonIndex) {
                NSLog(@"%ld", buttonIndex);
            } otherButtonTitles:@"确定-1", @"选项-2", @"选项-3", nil];
            // 红色按钮
            NSMutableIndexSet *indexSet = [[NSMutableIndexSet alloc] init];
            [indexSet addIndex:1];
            actionSheet.destructiveButtonIndexSet = indexSet;
            actionSheet.destructiveButtonColor = UIColor.redColor;
            [actionSheet show];
        }
    if(7 == code){
        CustomIOSAlertView *customAlertView = [[CustomIOSAlertView alloc] init];
        UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 200)];
        customView.backgroundColor = UIColor.orangeColor;
        customAlertView.containerView= customView;
        customAlertView.buttonTitles = @[@"选项-0", @"选项-1", @"选项-2"];
        customAlertView.onButtonTouchUpInside = ^(CustomIOSAlertView *alertView, int buttonIndex) {
            NSLog(@"%d", buttonIndex);
        };
        //customAlertView.useMotionEffects = YES;
        [customAlertView show];
    }
    if(8 == code){
        NSArray *array = @[@"选项-0", @"选项-1", @"选项-2", @"选项-3", @"选项-4", @"选项-5", @"选项-6"];
        ActionSheetStringPicker *picker = [[ActionSheetStringPicker alloc] initWithTitle:@"选择器" rows:array initialSelection:0 doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
            NSLog(@"%ld，%@", selectedIndex, selectedValue);
        } cancelBlock:nil origin:self.view];
        picker.tapDismissAction = TapActionCancel;
        [picker showActionSheetPicker];
    }
    if(9 == code){
        [YBPopupMenu showAtPoint:CGPointMake(WIDTH_SCREEN - 20, HEIGHT_TOP - 10) titles:@[@"选项-0", @"选项-1", @"选项-2"] icons:@[@"image_0", @"image_1", @"image_2"] menuWidth:140 otherSettings:^(YBPopupMenu *popupMenu) {
            popupMenu.dismissOnSelected = YES;
            popupMenu.isShowShadow = YES;
            popupMenu.delegate = self;
            popupMenu.offset = 10;
            //popupMenu.type = YBPopupMenuTypeDark;
            popupMenu.rectCorner = UIRectCornerAllCorners;
        }];
    }
    if(10 == code){
        [JDStatusBarNotification addStyleNamed:@"customStyle" prepare:^JDStatusBarStyle *(JDStatusBarStyle *style) {
            style.barColor = UIColor.blackColor;
            //style.font = FontSize(15.f);
            style.textColor = UIColor.whiteColor;
            style.progressBarHeight = 1.0+1.0/[[UIScreen mainScreen] scale];
            return style;
        }];
        
        [JDStatusBarNotification showWithStatus:@"信息提示内容" dismissAfter:1.5f styleName:@"customStyle"];
    }
    if(11 == code){
        LCActionSheet *actionSheet = [LCActionSheet sheetWithTitle:@"MBProgressHUD" cancelButtonTitle:@"取消" clicked:^(LCActionSheet *actionSheet, NSInteger buttonIndex) {
            if(1 == buttonIndex){
                [MBProgressHUD showTipMessageInView:@"提示信息"];
            }
            if(2 == buttonIndex){
                [MBProgressHUD showSuccessMessage:@"提示信息"];
            }
            if(3 == buttonIndex){
                [MBProgressHUD showInfoMessage:@"提示信息"];
            }
            if(4 == buttonIndex){
                [MBProgressHUD showWarnMessage:@"提示信息"];
            }
            if(5 == buttonIndex){
                [MBProgressHUD showErrorMessage:@"提示信息"];
            }
            if(6 == buttonIndex){
                [MBProgressHUD showTopTipMessage:@"提示信息" isWindow:YES];
            }
            if(7 == buttonIndex){
                [MBProgressHUD showTipMessageInView:@"提示信息" delay:2.f];
            }
        } otherButtonTitles:@"showTipMessageInView", @"showSuccessMessage", @"showInfoMessage", @"showWarnMessage", @"showErrorMessage", @"showTopTipMessage", @"showActivityMessageInView", nil];
        [actionSheet show];
    }
    if(12 == code){
        [self presentViewController:[[NSClassFromString(@"DemoComponentViewController") alloc] init] animated:YES completion:nil];
    }
    if(13 == code){
        [[YZAuthID alloc] yz_showAuthIDWithDescribe:nil block:^(YZAuthIDState state, NSError *error) {
            if (state == YZAuthIDStateSuccess) {    // TouchID/FaceID验证成功
                NSLog(@"验证成功");
            }else{
                NSLog(@"验证失败");
            }
        }];
    }
    if(14 == code){
        // 所有权限需在info.plist文件中添加
        self.yzPermission = [[YZPermission alloc] init];
        [self.yzPermission checkLocationWithStatus:^(PermissionStatus status) {
            NSLog(@"%ld", status);
        }];
        /*
        [YZPermission checkCalendarsWithStatus:^(PermissionStatus status) {
            NSLog(@"%ld", status);
        }];
        */
    }
    if(15 == code){
        NSArray *obj = @[@{@"id" : @"1", @"name" : @"Java"}, @{@"id" : @"2", @"name" : @"Scala"}, @{@"id" : @"3", @"name" : @"Objective-C"}];
        NSString *jsonStr = [YZJsonUtil JSONStringWithDictionaryOrArray:obj];
        NSLog(@"%@", jsonStr);
    }
    if(16 == code){
        YZSandBoxUtil *yzSandBoxUtil = [[YZSandBoxUtil alloc] init];
        [yzSandBoxUtil writeData:@{@"uuid" : @"xxx"} fileName:@"testFile"]; // 写入
        NSLog(@"%@", [yzSandBoxUtil readDataWithFileName:@"testFile"]);                   // 读取
        [yzSandBoxUtil removeFileName:@"testFile"];                         // 删除
    }
    if(17 == code){
        NSLog(@"%@", [YZVerify checkEmoji:@"嘻嘻☺️哈哈"] ? @"包含表情返回YES" : @"没有表情返回NO");
    }
    if(18 == code){
        CLLocationCoordinate2D locationCoordinate2D = CLLocationCoordinate2DMake(34.229047, 108.953198);
        NSLog(@"bd09: latitude=%f, longitude=%f", locationCoordinate2D.latitude, locationCoordinate2D.longitude);
        CLLocationCoordinate2D coverterLocationCoordinate2D = [YZLocationConverterUtil bd09ToGcj02:locationCoordinate2D];
        NSLog(@"gcj02: latitude=%f, longitude=%f", coverterLocationCoordinate2D.latitude, coverterLocationCoordinate2D.longitude);
    }
    if(19 == code){
        YZIPAddressUtil *ipUtil = [[YZIPAddressUtil alloc] init];
        NSLog(@"IP地址为%@", [ipUtil getIPAddress:YES]);
    }
    if(20 == code){
        [self presentViewController:[[NSClassFromString(@"DemoRoundedBorderViewController") alloc] init] animated:YES completion:nil];
    }
    if(21 == code){
        [YZUserDefault saveUserDefaultObject:@{@"username" : @"Micyo", @"password" : @"123456"} key:@"UserInfo"];
        NSDictionary *userInfo = [YZUserDefault getUserDefaultObjectByKey:@"UserInfo"];
        DLog(@"%@", userInfo);
        [YZUserDefault removeObjectWithKey:@"UserInfo"];
        NSDictionary *userInfoAfter = [YZUserDefault getUserDefaultObjectByKey:@"UserInfo"];
        DLog(@"%@", userInfoAfter);
    }
    if(22 == code){
        NSDate *now = [NSDate date];
        NSString *timestamp = [NSString stringWithFormat:@"%ld", (long)[now timeIntervalSince1970]];
        DLog(@"%@", timestamp);
        DLog(@"%ld", [now year]);
        DLog(@"%ld", [now month]);
        DLog(@"%ld", [now day]);
        DLog(@"%ld", [now hour]);
        DLog(@"%ld", [now minute]);
        DLog(@"%ld", [now seconds]);
        DLog(@"%ld", [now weekday]);
        
        DLog(@"%@", [NSDate yz_dateWithFormat_yyyy_MM_string:@"2019-07-14 20:19:00"]);
    }
    if(23 == code){
        BaseWebViewController *webVC = [[BaseWebViewController alloc] initWithUrl:@"http://www.hao123.com"];
        webVC.title = @"WebView";
        webVC.isShowCloseItem = YES;
        webVC.progressViewColor = DEFAULT_GREEN_COLOR;
        [self.navigationController pushViewController:webVC animated:YES];
    }
    if(24 == code){
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:3 delegate:self];
        //在内部显示拍照按钮、在内部显示拍视频按
        imagePickerVc.allowTakePicture = YES;
        imagePickerVc.allowTakeVideo = NO;
        //只选择图片
        imagePickerVc.allowPickingGif = NO;
        imagePickerVc.allowPickingImage = YES;
        imagePickerVc.allowPickingVideo = NO;
        imagePickerVc.allowPickingOriginalPhoto = NO;
        imagePickerVc.allowPreview = YES;
        //设置是否显示图片序号
        imagePickerVc.showSelectedIndex = NO;
        //自定义“返回”
        imagePickerVc.navLeftBarButtonSettingBlock = ^(UIButton *leftButton) {
            [leftButton setImage:[UIImage imageNamed:@"navigation_back_white"] forState:UIControlStateNormal];
            leftButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
        };
        //完成样式
        //imagePickerVc.oKButtonTitleColorDisabled = color;
        //imagePickerVc.oKButtonTitleColorNormal = color

        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            DLog(@"%@", photos);
            DLog(@"%@", assets);
            DLog(@"%@", isSelectOriginalPhoto?@"YES":@"NO");
        }];
        imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:imagePickerVc animated:YES completion:nil];
    }
    if(25 == code){
        RequestModel *model = [[RequestModel alloc] init];
        model.data = @{
            @"id" : @"1001",
            @"name" : @"张三",
            @"sex" : @"male"
        };
        RACSignal *signal = [RACNetworkHelper.sharedRACNetworkHelper requestModel:model url:@"/test/init" loading:YES];
        [signal subscribeNext:^(id  _Nullable x) {
            ResponseModel *response = x;
            DLog(@"%ld",response.code);
            DLog(@"%@",response.msg);
            DLog(@"%ld",response.timestamp);
            DLog(@"%@",response.data);
        }];
    }
    if(26 == code){
        UIImage *originImage = [UIImage imageNamed:@"tabbar_add"];
        NSData *data = UIImageJPEGRepresentation(originImage, 1.f);
        NSString *encodedImageStr = [data base64EncodedString];
        NSLog(@"===Encoded image:\n%@", encodedImageStr);
        
        RequestModel *model = [[RequestModel alloc] init];
        model.data = @{
            @"id" : @"1002",
            @"name" : @"李四",
            @"sex" : @"female",
            @"images": @[encodedImageStr]
        };
        RACSignal *signal = [RACNetworkHelper.sharedRACNetworkHelper requestModel:model url:@"/test/upload/base64" loading:YES];
        [signal subscribeNext:^(id  _Nullable x) {
            ResponseModel *response = x;
            DLog(@"%ld",response.code);
            DLog(@"%@",response.msg);
            DLog(@"%ld",response.timestamp);
            DLog(@"%@",response.data);
        }];
    }
    if(27 == code){
        RequestModel *model = [[RequestModel alloc] init];
        model.data = @{
            @"id" : @"1003",
            @"name" : @"王五",
            @"sex" : @"female"
        };
        RACSignal *signal = [RACNetworkHelper.sharedRACNetworkHelper requestModel:model imageNames:@[@"tabbar_add", @"tabbar_home", @"tabbar_mine"] url:@"/test/upload/file" loading:YES];
        [signal subscribeNext:^(id  _Nullable x) {
            ResponseModel *response = x;
            DLog(@"%ld",response.code);
            DLog(@"%@",response.msg);
            DLog(@"%ld",response.timestamp);
            DLog(@"%@",response.data);
        }];
    }
    if(28 == code){
        [self.navigationController pushViewController:[[NSClassFromString(@"DemoTableViewController") alloc] init] animated:YES];
    }
    if(29 == code){
        [self.navigationController pushViewController:[[NSClassFromString(@"DemoCollectionViewController") alloc] init] animated:YES];
    }
    if(30 == code){
        [self.navigationController pushViewController:[[NSClassFromString(@"DemoDragViewController") alloc] init] animated:YES];
    }
    if(31 == code){
        [self.navigationController pushViewController:[[NSClassFromString(@"DemoPageScrollViewController") alloc] init] animated:YES];
    }
}

#pragma mark - 方法重写
#pragma mark 顶部刷新方法
- (void)headerRefreshing{
    DLog(@"开始执行顶部Header刷新方法");
    // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
    });
}

#pragma mark 底部刷新方法
- (void)footerRefreshing{
    DLog(@"开始执行底部Footer刷新方法");
    // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 结束刷新
        [self.tableView.mj_footer endRefreshing];
    });
}

#pragma mark - <CustomIOSAlertView>代理方法
- (void)customIOS7dialogButtonTouchUpInside:(id)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    DLog(@"点击了 %ld", buttonIndex);
}

#pragma mark - <YBPopupMenu>代理方法
- (void)ybPopupMenu:(YBPopupMenu *)ybPopupMenu didSelectedAtIndex:(NSInteger)index {
    DLog(@"%ld", index);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
