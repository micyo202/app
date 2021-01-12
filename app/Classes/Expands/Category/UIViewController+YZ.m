//
//  UIViewController+YZ.m
//  app
//
//  Created by apple on 2021/1/6.
//

#import "UIViewController+YZ.h"
#import <objc/runtime.h>

@implementation UIViewController (YZ)

+ (void)load {
    Method originalAddObserverMethod = class_getInstanceMethod(self, @selector(presentViewController:animated:completion:));
    Method extensionAddObserverMethod = class_getInstanceMethod(self, @selector(yz_presentViewController:animated:completion:));
    method_exchangeImplementations(originalAddObserverMethod, extensionAddObserverMethod);
}

- (void)yz_presentViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)(void))completion {
    if (@available(iOS 13.0, *)) {
        viewController.modalPresentationStyle = UIModalPresentationFullScreen;
        [self yz_presentViewController:viewController animated:animated completion:completion];
    } else {
        [self yz_presentViewController:viewController animated:animated completion:completion];
    }
}

@end
