//
//  UIViewController+PresentTwoControllers.m
//  TestPresentTwoControllers
//
//  Created by Tan Lu on 9/1/14.
//  Copyright (c) 2014 Tan Lu. All rights reserved.
//

#import "UIViewController+PresentTwoControllers.h"

@implementation UIViewController (PresentTwoControllers)

- (void)presentTwoViewControllers:(UIViewController *)firstVC secondViewController:(UIViewController *)secondeVC completion:(void (^)(void))completion
{
    UIImage *image = [self takeScreenShotOfView:self.view];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    CGSize size = image.size;
    imageView.frame = CGRectMake(0, 0, size.width, size.height);
    [firstVC.view addSubview:imageView];
    [self presentViewController:firstVC animated:NO completion:^{
        [firstVC presentViewController:secondeVC animated:YES completion:^{
            [imageView removeFromSuperview];
        }];
    }];
}

- (void)dismissTwoViewController:(void (^)(void))completion
{
    if (self.presentedViewController) {
        [self dismissViewControllerAnimated:YES completion:completion];
    }
    else{
        if (self.presentingViewController.presentingViewController) {
            [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:completion];
        }
        else{
            [self dismissViewControllerAnimated:YES completion:completion];
        }
    }
}

- (UIImage *)takeScreenShotOfView:(UIView*)view
{
    NSString * version = [UIDevice currentDevice].systemVersion;
    CGFloat ver = version.floatValue;
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    if (UIGraphicsBeginImageContextWithOptions != nil) {
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, height), true, 0.0);
    }
    else{
        UIGraphicsBeginImageContext(CGSizeMake(width, height));
    }
    
    UIImage *image = nil;
    if (ver < 7.0) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        [view.layer renderInContext:context];
        // Retrieve the screenshot image
        image = UIGraphicsGetImageFromCurrentImageContext();
    }
    else{
        // if it is ios 7 or later, we use the snapshot function provided by the system
        BOOL isReady = [view drawViewHierarchyInRect:CGRectMake(0, 0, width, height) afterScreenUpdates: true];
        if (isReady) {
            image = UIGraphicsGetImageFromCurrentImageContext();
        }
    }
    UIGraphicsEndImageContext();
    return image;
}

@end
