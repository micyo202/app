//
//  SettingViewController.m
//  app
//
//  Created by apple on 2021/1/6.
//

#import "SettingViewController.h"
#import "MineHelper.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设置";
    
    self.data = [[MineHelper sharedMineHelper] settingData];
}

#pragma mark - cell点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    DLog(@"indexPath.row = %ld", indexPath.row);
}

#pragma mark - 代理方法
- (void)mineTableViewCellSwitchAction:(UISwitch *)sender {
    DLog(@"sender.tag = %ld，是否开启：%@", (long)sender.tag, sender.on?@"YES":@"NO");
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
