//
//  HomeViewController.m
//  app
//
//  Created by apple on 2020/12/28.
//

#import "HomeViewController.h"
#import <SDCycleScrollView.h>

#import "RACNetworkHelper.h"


@interface HomeViewController () <SDCycleScrollViewDelegate>

@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;   // 轮播图

@property(nonatomic, strong) UIButton *btn;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"首页";
    
    [self.view addSubview:self.cycleScrollView];
    
    [self.view addSubview:self.btn];
}

- (SDCycleScrollView *)cycleScrollView {
    if(!_cycleScrollView){
        NSArray *images = @[@"https://car3.autoimg.cn/cardfs/product/g25/M08/EE/EF/1024x0_1_q95_autohomecar__ChwFj19hau-AZ_jzAA2FpifA1QQ457.jpg", @"https://car2.autoimg.cn/cardfs/product/g25/M04/F6/B5/1024x0_1_q95_autohomecar__ChsEel9hau6AAvenAAsau867IlY966.jpg", @"https://car3.autoimg.cn/cardfs/product/g25/M0B/EE/EF/1024x0_1_q95_autohomecar__ChwFj19hau2AQ2n7AAo22l4pgDs052.jpg"];
        //NSArray *titles = @[@"宾利", @"奔驰", @"红旗"];
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, HEIGHT_TOP, WIDTH_SCREEN, HEIGHT_SCREEN/3.5f) imageNamesGroup:images];
        //_cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.width, 160) imageURLStringsGroup:imageURL];
        //_cycleScrollView.titlesGroup = titles;   // 标题数组
        //_cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;   // 设置pageControl居右，默认居中
        _cycleScrollView.autoScrollTimeInterval = 4.f;   // 自定义轮播时间间隔，默认1.f
        _cycleScrollView.delegate = self;
    }
    return _cycleScrollView;
}

- (UIButton *)btn{
    if(nil == _btn){
        _btn = [UIButton buttonWithType:UIButtonTypeSystem];
        _btn.frame = CGRectMake(10, 600, 200, 36);
        _btn.backgroundColor = DEFAULT_YELLOW_COLOR;
        [_btn setTitle:@"Demo" forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

- (void)btnClick:(UIButton *)sender{
    [self.navigationController pushViewController:[[NSClassFromString(@"DemoViewController") alloc] init] animated:YES];
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
