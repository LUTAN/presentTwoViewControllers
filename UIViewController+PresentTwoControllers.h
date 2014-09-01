//
//  UIViewController+PresentTwoControllers.h
//  TestPresentTwoControllers
//
//  Created by Tan Lu on 9/1/14.
//  Copyright (c) 2014 Tan Lu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (PresentTwoControllers)

-(void)presentTwoViewControllers:(UIViewController *)firstVC secondViewController:(UIViewController *)secondeVC completion:(void (^)(void))completion;
- (void)dismissTwoViewController:(void (^)(void))completion;
@end
