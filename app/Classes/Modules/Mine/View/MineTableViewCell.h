//
//  MineTableViewCell.h
//  app
//
//  Created by apple on 2020/12/28.
//

#import <UIKit/UIKit.h>
#import "MineModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, CellLineStyle) {
    CellLineStyleDefault,
    CellLineStyleFill,
    CellLineStyleNone,
};

@protocol MineTableViewCellDelegate <NSObject>

@optional
- (void)mineTableViewCellButtonAction:(UIButton *)sender;   // button点击代理方法
- (void)mineTableViewCellSwitchAction:(UISwitch *)sender;   // switch开关变更方法

@end

@interface MineTableViewCell : UITableViewCell

@property (nonatomic, assign) CellLineStyle bottomLineStyle;    // 底部线条样式
@property (nonatomic, assign) CellLineStyle topLineStyle;       // 顶部线条样式


@property (nonatomic, strong) MineModelItem *item;

+ (CGFloat)getHeightForText:(MineModelItem *)item;

@property (nonatomic, weak) id<MineTableViewCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
