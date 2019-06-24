//
// MIT License
//
// Copyright (c) 2018-present Hituzi Ando
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MKAToastConfiguration;
@protocol MKAToastDelegate;

/**
 * A default short display time for a toast view.
 */
UIKIT_EXTERN const NSTimeInterval MKAToastShortTime;
/**
 * A default long display time for a toast view.
 */
UIKIT_EXTERN const NSTimeInterval MKAToastLongTime;

/**
 * MKAToast is the view that disappears automatically after displaying a short message for a few seconds like Android's Toast.
 */
@interface MKAToast : UIView
/**
 * A delegate.
 */
@property (nonatomic, weak, nullable) id <MKAToastDelegate> delegate;
/**
 * A label.
 */
@property (nonatomic, readonly) UILabel *label;
/**
 * A duration of fade-in and fade-out in seconds.
 */
@property (nonatomic) NSTimeInterval animationDuration;
/**
 * An identification code of a toast view instance.
 */
@property (nonatomic) NSInteger identifier;

/**
 * Initializes an instance with given text, size and position.
 */
- (instancetype)initWithText:(NSString *)text frame:(CGRect)frame;
/**
 * Initializes an instance with given text, width and height. It is placed in the default position.
 */
- (instancetype)initWithText:(NSString *)text width:(CGFloat)width height:(CGFloat)height;
/**
 * Initializes an instance with given text and size. It is placed in the default position.
 */
- (instancetype)initWithText:(NSString *)text size:(CGSize)size;

/**
 * Shows a toast view fading in / fading out in a specified seconds.
 * After fade out, it is separated from the parent view.
 */
- (void)showWithTimeInterval:(NSTimeInterval)t;

/**
 * Creates a toast view instance and shows it fading in / fading out in a specified seconds.
 * After fade out, it is separated from the parent view.
 */
+ (void)showText:(NSString *)text withTimeInterval:(NSTimeInterval)t;
/**
 * Creates a toast view instance and shows it fading in / fading out in a specified seconds.
 * After fade out, it is separated from the parent view.
 * The toast view calls the delegate methods of given `delegate` when the toast view is hidden.
 */
+ (void)showText:(NSString *)text withDelegate:(nullable id <MKAToastDelegate>)delegate timeInterval:(NSTimeInterval)t;
/**
 * Creates a toast view instance and shows it fading in / fading out in a specified seconds.
 * After fade out, it is separated from the parent view.
 * The toast view calls the delegate methods of given `delegate` with given ID when the toast view is hidden.
 */
+ (void)showText:(NSString *)text
    withDelegate:(nullable id <MKAToastDelegate>)delegate
    timeInterval:(NSTimeInterval)t
      identifier:(NSInteger)identifier;
/**
 * Sets a default configuration.
 */
+ (void)setDefaultConfiguration:(MKAToastConfiguration *)config;
@end

@protocol MKAToastDelegate <NSObject>
@optional
/**
 * Called just before a toast view disappears.
 */
- (void)toastWillDisappear:(MKAToast *)toast;
/**
 * Called immediately after a toast view disappears.
 */
- (void)toastDidDisappear:(MKAToast *)toast;
@end

NS_ASSUME_NONNULL_END
