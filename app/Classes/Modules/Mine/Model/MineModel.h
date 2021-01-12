//
//  MineModel.h
//  app
//
//  Created by apple on 2020/12/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - 自定义枚举类型
#pragma mark 对齐方式ENUM
typedef NS_ENUM(NSInteger, MineModelItemAlignment) {
    MineModelItemAlignmentLeft,
    MineModelItemAlignmentRight,
    MineModelItemAlignmentMiddle
};

#pragma mark 类型ENUM
typedef NS_ENUM(NSInteger, MineModelItemType) {
    MineModelItemTypeDefault,   // image, title, rightTitle, rightImage
    MineModelItemTypeButton,    // button
    MineModelItemTypeSwitch     // title， switch
};

@interface MineModelItem : NSObject

// 对齐方式
@property (nonatomic, assign) MineModelItemAlignment alignment;
// 类型
@property (nonatomic, assign) MineModelItemType type;

/************************ 属性 ************************/
// 1 左边图标（主图片）
@property (nonatomic, copy) NSString *imageName;
//@property (nonatomic, strong) NSURL *imageURL;
// 2 标题
@property (nonatomic, copy) NSString *title;
// 3.1 中间图片
@property (nonatomic, copy) NSString *middleImageName;
//@property (nonatomic, strong) NSURL *middlerImageURL;
// 3.2 图片集
@property (nonatomic, strong) NSArray *subImages;
// 4 副标题
@property (nonatomic, copy) NSString *subTitle;
// 5 右图片
@property (nonatomic, copy) NSString *rightImageName;
//@property (nonatomic, strong) NSURL *rightImageURL;
// 6 btton、switch的标签tag
@property (nonatomic, assign) NSInteger tag;
// 7 设置switch的值
@property (nonatomic, assign, getter=isOn) BOOL on;

/************************ 样式 ************************/
@property (nonatomic, assign) UITableViewCellAccessoryType accessoryType;
@property (nonatomic, assign) UITableViewCellSelectionStyle selectionStyle;

@property (nonatomic, strong) UIColor *bgColor;
@property (nonatomic, strong) UIColor *btnBGColor;
@property (nonatomic, strong) UIColor *btnTitleColor;

@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIFont *titleFont;

@property (nonatomic, strong) UIColor *subTitleColor;
@property (nonatomic, strong) UIFont *subTitleFont;

@property (nonatomic, assign) CGFloat rightImageHeightOfCell;
@property (nonatomic, assign) CGFloat middleImageHeightOfCell;

/************************ 类方法 ************************/
+ (MineModelItem *) createWithTitle:(NSString *)title;
+ (MineModelItem *) createWithImageName:(NSString * _Nullable)imageName title:(NSString *)title;
+ (MineModelItem *) createWithTitle:(NSString *)title subTitle:(NSString * _Nullable)subTitle;
+ (MineModelItem *) createWithImageName:(NSString * _Nullable)imageName title:(NSString *)title middleImageName:(NSString * _Nullable)middleImageName subTitle:(NSString * _Nullable)subTitle;
+ (MineModelItem *) createWithImageName:(NSString * _Nullable)imageName title:(NSString *)title subTitle:(NSString * _Nullable)subTitle rightImageName:(NSString * _Nullable)rightImageName;
+ (MineModelItem *) createWithImageName:(NSString * _Nullable)imageName title:(NSString *)title middleImageName:(NSString * _Nullable)middleImageName subTitle:(NSString * _Nullable)subTitle rightImageName:(NSString * _Nullable)rightImageName;

@end

@interface MineModelGroup : NSObject

/************************ 属性 ************************/
// 组头部标题
@property (nonatomic, copy) NSString *headerTitle;
// 组尾部说明
@property (nonatomic, copy) NSString *footerTitle;
// 组元素
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, assign, readonly) NSUInteger itemsCount;

/************************ 类方法 ************************/
- (MineModelGroup *) initWithHeaderTitle:(NSString * _Nullable)headerTitle footerTitle:(NSString * _Nullable)footerTitle settingItems:(MineModelItem *)firstObj, ...;
- (MineModelItem *) itemAtIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
