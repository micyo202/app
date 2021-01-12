//
//  DemoRoundedBorderViewController.m
//  app
//
//  Created by apple on 2021/1/4.
//

#import "DemoRoundedBorderViewController.h"

@interface DemoRoundedBorderViewController ()

@property (nonatomic, strong) YZRoundedBorderView *v1;
@property (nonatomic, strong) YZRoundedBorderView *v2;
@property (nonatomic, strong) YZRoundedBorderView *v3;
@property (nonatomic, strong) YZRoundedBorderView *v4;
@property (nonatomic, strong) YZRoundedBorderView *v5;
@property (nonatomic, strong) YZRoundedBorderLabel *l1;
@property (nonatomic, strong) YZRoundedBorderLabel *l2;
@property (nonatomic, strong) YZRoundedBorderLabel *l3;
@property (nonatomic, strong) YZRoundedBorderLabel *l4;
@property (nonatomic, strong) YZRoundedBorderLabel *l5;

@end

@implementation DemoRoundedBorderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"圆角视图、标签";
    
#pragma mark - 自定义圆角视图、标签
    self.v1 = [[YZRoundedBorderView alloc] initWithFrame:CGRectMake(10, HEIGHT_TOP, 150, 60)];
    self.v1.borderColor = UIColor.redColor;
    self.v1.borderWidth = 5;
    [self.view addSubview:self.v1];
    
    self.v2 = [[YZRoundedBorderView alloc] initWithFrame:CGRectMake(10, self.v1.bottom + 20, 150, 60)];
    self.v2.BD = BorderDirectionTop | BorderDirectionLeft | BorderDirectionBottom;
    self.v2.corners =  UIRectCornerTopLeft | UIRectCornerBottomLeft;
    self.v2.borderWidth = 5;
    [self.view addSubview:self.v2];
    
    self.v3 = [[YZRoundedBorderView alloc] initWithFrame:CGRectMake(10, self.v2.bottom + 20, 150, 60)];
    self.v3.BD = BorderDirectionTop | BorderDirectionRight | BorderDirectionBottom;
    self.v3.corners =  UIRectCornerTopRight | UIRectCornerBottomRight;
    self.v3.borderWidth = 5;
    [self.view addSubview:self.v3];
    
    self.v4 = [[YZRoundedBorderView alloc] initWithFrame:CGRectMake(10, self.v3.bottom + 20, 150, 60)];
    self.v4.BD = BorderDirectionLeft | BorderDirectionRight | BorderDirectionBottom;
    self.v4.corners =  UIRectCornerBottomLeft | UIRectCornerBottomRight;
    self.v4.borderWidth = 5;
    [self.view addSubview:self.v4];
    
    self.v5 = [[YZRoundedBorderView alloc] initWithFrame:CGRectMake(10, self.v4.bottom + 20, 150, 60)];
    self.v5.BD = BorderDirectionAllCorners;
    self.v5.corners =  UIRectCornerAllCorners;
    self.v5.borderWidth = 5;
    [self.view addSubview:self.v5];
    
    self.l1 = [[YZRoundedBorderLabel alloc] initWithFrame:CGRectMake(WIDTH_SCREEN - 160, HEIGHT_TOP, 150, 60)];
    self.l1.BD = BorderDirectionLeft | BorderDirectionTop;
    self.l1.corners =  0;
    self.l1.borderWidth = 5;
    self.l1.text = @"标签";
    self.l1.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.l1];
    
    self.l2 = [[YZRoundedBorderLabel alloc] initWithFrame:CGRectMake(WIDTH_SCREEN - 160, self.l1.bottom + 20, 150, 60)];
    self.l2.BD = BorderDirectionTop | BorderDirectionBottom;
    self.l2.corners =  0;
    self.l2.borderWidth = 5;
    [self.view addSubview:self.l2];
    
    self.l3 = [[YZRoundedBorderLabel alloc] initWithFrame:CGRectMake(WIDTH_SCREEN - 160, self.l2.bottom + 20, 150, 60)];
    self.l3.BD = BorderDirectionBottom;
    self.l3.corners =  0;
    self.l3.borderWidth = 5;
    [self.view addSubview:self.l3];
    
    self.l4 = [[YZRoundedBorderLabel alloc] initWithFrame:CGRectMake(WIDTH_SCREEN - 160, self.l3.bottom + 20, 150, 60)];
    self.l4.BD = BorderDirectionLeft | BorderDirectionRight;
    self.l4.corners =  0;
    self.l4.borderWidth = 5;
    [self.view addSubview:self.l4];
    
    self.l5= [[YZRoundedBorderLabel alloc] initWithFrame:CGRectMake(WIDTH_SCREEN - 160, self.l4.bottom + 20, 150, 60)];
    self.l5.BD = BorderDirectionAllCorners;
    self.l5.corners =  UIRectCornerAllCorners;
    self.l5.borderWidth = 5;
    [self.view addSubview:self.l5];
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
