//
//  BorderView.h
//  app
//
//  Created by apple on 2021/1/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum BorderViewType {
    BorderViewTypeDashed,
    BorderViewTypeSolid
} BorderViewType;

@interface BorderView : UIView

@property (nonatomic, assign) BorderViewType borderType;
@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, assign) CGFloat borderWidth;
@property (nonatomic, assign) NSUInteger dashPattern;
@property (nonatomic, assign) NSUInteger spacePattern;
@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@end

NS_ASSUME_NONNULL_END
