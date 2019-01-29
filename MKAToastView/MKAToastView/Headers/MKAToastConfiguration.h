//
//  MKAToastConfiguration.h
//  MKAToastView
//
//  Created by Masaki Ando
//  Copyright (c) 2018-2019 Hituzi Ando. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * A default value of a toast view's width.
 */
UIKIT_EXTERN const CGFloat MKAToastDefaultWidth;
/**
 * A default value of a toast view's height.
 */
UIKIT_EXTERN const CGFloat MKAToastDefaultHeight;

@interface MKAToastConfiguration : NSObject <NSCopying>
/**
 * A toast view's width.
 */
@property (nonatomic) CGFloat width;
/**
 * A toast view's height.
 */
@property (nonatomic) CGFloat height;

@end

NS_ASSUME_NONNULL_END
