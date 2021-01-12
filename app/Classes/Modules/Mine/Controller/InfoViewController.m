//
//  InfoViewController.m
//  app
//
//  Created by apple on 2020/12/29.
//

#import "InfoViewController.h"
#import "MineTableViewCell.h"
#import "MineHelper.h"

@interface InfoViewController ()

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.data = [[MineHelper sharedMineHelper] infoData];
}

#pragma mark - cell点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];// 点击变色还原
    MineTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if([cell.item.title isEqualToString:@"设置"]){
        [self.navigationController pushViewController:[[NSClassFromString(@"SettingViewController") alloc] init] animated:YES];
    }
    if([cell.item.title isEqualToString:@"所有样式"]){
        [self.navigationController pushViewController:[[NSClassFromString(@"GeneralViewController") alloc] init] animated:YES];
    }
    
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
