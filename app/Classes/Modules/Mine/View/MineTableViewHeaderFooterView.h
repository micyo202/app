//
//  MineTableViewHeaderFooterView.h
//  app
//
//  Created by apple on 2020/12/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineTableViewHeaderFooterView : UITableViewHeaderFooterView

@property (nonatomic, copy) NSString *text;

+ (CGFloat) getHeightForText:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
