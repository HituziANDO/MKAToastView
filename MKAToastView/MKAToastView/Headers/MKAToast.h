//
//  MKAToast.h
//  MKAToastView
//
//  Created by Masaki Ando
//  Copyright (c) 2018 Hituzi Ando. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MKAToastConfiguration;
@protocol MKAToastDelegate;

/**
 * The default short display time for the toast view.
 */
UIKIT_EXTERN const NSTimeInterval MKAToastShortTime;
/**
 * The default long display time for the toast view.
 */
UIKIT_EXTERN const NSTimeInterval MKAToastLongTime;

/**
 * MKAToast is the view that disappears automatically after displaying a short message for a few seconds like Android's Toast.
 */
@interface MKAToast : UIView
/**
 *
 */
@property (nonatomic, weak, nullable) id <MKAToastDelegate> delegate;
/**
 * The label.
 */
@property (nonatomic, readonly) UILabel *label;
/**
 * The duration of fade-in and fade-out in seconds.
 */
@property (nonatomic) NSTimeInterval animationDuration;
/**
 * The identification code of the ToastView instance.
 */
@property (nonatomic) NSInteger identifier;

/**
 * Initializes the instance with the message, the size and the position.
 */
- (instancetype)initWithMessage:(NSString *)message frame:(CGRect)frame;
/**
 * Initializes the instance with the message and the size. It is placed in the default position.
 */
- (instancetype)initWithMessage:(NSString *)message width:(CGFloat)width height:(CGFloat)height;
/**
 * Initializes the instance with the message and the size. It is placed in the default position.
 */
- (instancetype)initWithMessage:(NSString *)message size:(CGSize)size;

/**
 * Adds the toast view instance to the specified view and shows it fading in / fading out in the specified seconds.
 * After fade out, it is separated from the parent view.
 */
- (void)showInView:(UIView *)view withTimeInterval:(NSTimeInterval)t;

/**
 * Creates the toast view instance in the specified view and shows it fading in / fading out in the specified seconds.
 * After fade out, it is separated from the parent view.
 */
+ (void)showInView:(UIView *)view
       withMessage:(NSString *)message
          delegate:(nullable id <MKAToastDelegate>)delegate
      timeInterval:(NSTimeInterval)t;
/**
 * Creates the toast view instance in the specified view and shows it fading in / fading out in the specified seconds.
 * After fade out, it is separated from the parent view.
 */
+ (void)showInView:(UIView *)view
       withMessage:(NSString *)message
          delegate:(nullable id <MKAToastDelegate>)delegate
      timeInterval:(NSTimeInterval)t
        identifier:(NSInteger)identifier;
/**
 * Sets the default configuration.
 */
+ (void)setDefaultConfiguration:(MKAToastConfiguration *)config;
@end

@protocol MKAToastDelegate <NSObject>
@optional
/**
 * Called just before the toast view disappears.
 */
- (void)toastWillDisappear:(MKAToast *)toast;
/**
 * Called immediately after the toast view disappears.
 */
- (void)toastDidDisappear:(MKAToast *)toast;
@end

NS_ASSUME_NONNULL_END
