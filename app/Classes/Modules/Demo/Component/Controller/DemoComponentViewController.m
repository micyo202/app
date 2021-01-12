//
//  DemoComponentViewController.m
//  app
//
//  Created by apple on 2021/1/4.
//

#import "DemoComponentViewController.h"
#import <SDCycleScrollView/SDCycleScrollView.h>

@interface DemoComponentViewController () <SDCycleScrollViewDelegate>

@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;   // 轮播图
@property (nonatomic, strong) YYLabel *yyLabel;                     // 富文本标签
@property (nonatomic, strong) UIView *dashLine;                     // 虚线
@property (nonatomic, strong) UIButton *submitBtn;                  // 按钮防重点击

@end

@implementation DemoComponentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"Component示例组件";
    
    [self.view addSubview:self.cycleScrollView];
    [self.view addSubview:self.yyLabel];
    [self.view addSubview:self.dashLine];
    [self.view addSubview:self.submitBtn];
}

- (SDCycleScrollView *)cycleScrollView {
    if(!_cycleScrollView){
        NSArray *images = @[@"cycle_image_0", @"cycle_image_1", @"cycle_image_2"];
        NSArray *titles = @[@"标题-0", @"标题-1", @"标题-2"];
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, HEIGHT_TOP, WIDTH_SCREEN, 160) imageNamesGroup:images];
        //_cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.width, 160) imageURLStringsGroup:imageURL];
        _cycleScrollView.titlesGroup = titles;   // 标题数组
        //_cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;   // 设置pageControl居右，默认居中
        _cycleScrollView.autoScrollTimeInterval = 4.f;   // 自定义轮播时间间隔，默认1.f
        _cycleScrollView.delegate = self;
    }
    return _cycleScrollView;
}

- (YYLabel *)yyLabel {
    if(!_yyLabel){
        NSString *content = @"YYLabel：\n        在这里随便写点东西，这是可点击的文字接下来是改变颜色的文字然后还有改变字体的文字，怎么样？很简单吧！";
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:content];
        text.font = FontSize(15.f);
        text.color = UIColor.whiteColor;
        text.alignment = NSTextAlignmentLeft;
        
        // 设置行间距、字间距
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:10.f];
        [text addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, content.length)];
        paragraphStyle.alignment = NSTextAlignmentLeft;
        
        // 改变颜色
        NSRange rangeColor = [content rangeOfString:@"改变颜色的文字"];
        [text setColor:UIColor.redColor range:rangeColor];
        
        // 改变字体
        NSRange rangeBold = [content rangeOfString:@"改变字体的文字"];
        [text setFont:FontBoldSize(18.f) range:rangeBold];
        
        // 添加点击事件
        NSRange rangeClicked = [content rangeOfString:@"可点击的文字"];
        [text setTextHighlightRange:rangeClicked color:UIColor.blueColor backgroundColor:UIColor.clearColor tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            NSLog(@"点击方法...");
        }];
        
        _yyLabel = [[YYLabel alloc] init];
        _yyLabel.frame = CGRectMake(0, self.cycleScrollView.bottom, WIDTH_SCREEN, 200);
        _yyLabel.backgroundColor = UIColor.lightGrayColor;
        _yyLabel.numberOfLines = 0;
        _yyLabel.attributedText = text;
        
    }
    return _yyLabel;
}

- (UIView *)dashLine {
    if(!_dashLine){
        _dashLine = [[UIView alloc] init];
        _dashLine.frame = CGRectMake(0, self.yyLabel.bottom + 20, WIDTH_SCREEN, 0.5f);
        _dashLine.backgroundColor = UIColor.blueColor;
        // 虚线
        [YZHandle drawDashLine:_dashLine lineLength:8 lineSpacing:6 lineColor:UIColor.whiteColor];
    }
    return _dashLine;
}

- (UIButton *)submitBtn {
    if(!_submitBtn){
        _submitBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _submitBtn.frame = CGRectMake(20, self.dashLine.bottom + 20, WIDTH_SCREEN - 40, 36);
        [_submitBtn setTitle:@"按钮防重点击，间隔0.5s" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _submitBtn.backgroundColor = UIColor.redColor;
        _submitBtn.tag = 1;
        _submitBtn.yz_acceptEventInterval = 0.5f;
        _submitBtn.layer.cornerRadius = 18.f;
        _submitBtn.layer.masksToBounds = YES;
        [_submitBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}

#pragma mark - 顶部返回按钮点击事件
- (void)btnClicked:(UIButton *)sender {
    NSInteger tag = sender.tag;
    if(0 == tag){
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    if(1 == tag){
        NSLog(@"按钮防重点击...");
    }
}

#pragma mark - <SDCycleScrollViewDelegate>轮播图点击事件
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"%ld", index);
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
