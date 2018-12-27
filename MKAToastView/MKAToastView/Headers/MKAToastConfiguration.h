//
//  MKAToastConfiguration.h
//  MKAToastView
//
//  Created by Masaki Ando
//  Copyright (c) 2018 Hituzi Ando. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * The default value of the width.
 */
UIKIT_EXTERN const CGFloat MKAToastDefaultWidth;
/**
 * The default value of the height.
 */
UIKIT_EXTERN const CGFloat MKAToastDefaultHeight;

@interface MKAToastConfiguration : NSObject <NSCopying>
/**
 * The width of the default ToastView.
 */
@property (nonatomic) CGFloat width;
/**
 * The height of the default ToastView.
 */
@property (nonatomic) CGFloat height;

@end

NS_ASSUME_NONNULL_END
