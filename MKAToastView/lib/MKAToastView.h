//
//  MKAToastView.h
//
//  Created by Masaki Ando
//  Copyright © 2016年 Hituzi Ando. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 ToastViewの表示時間(短時間)
 */
UIKIT_EXTERN const NSTimeInterval MKAToastViewShortTime;
/**
 ToastViewの表示時間(長時間)
 */
UIKIT_EXTERN const NSTimeInterval MKAToastViewLongTime;

/**
 ToastViewのデフォルトの幅
 */
UIKIT_EXTERN const CGFloat MKAToastViewDefaultWidth;
/**
 ToastViewのデフォルトの高さ
 */
UIKIT_EXTERN const CGFloat MKAToastViewDefaultHeight;

@protocol MKAToastViewDelegate;

/**
 AndroidのToastのように数秒間ショートメッセージを表示した後、自動で消えるビューです
 */
@interface MKAToastView : UIView
/**
 */
@property (nonatomic, weak, nullable) id<MKAToastViewDelegate> delegate;
/**
 メッセージビュー
 */
@property (nonatomic, readonly) UILabel *label;
/**
 フェードイン・フェードアウトしている時間[秒]
 */
@property (nonatomic) NSTimeInterval animationDuration;
/**
 ToastViewの識別コード
 */
@property (nonatomic) NSInteger identifier;

/**
 メッセージとビューのサイズと配置を指定してインスタンスを初期化します
 */
- (instancetype)initWithMessage:(NSString *)message frame:(CGRect)frame;
/**
 メッセージとビューのサイズを指定してインスタンスを初期化します。ビューはデフォルトの位置に配置されます
 */
- (instancetype)initWithMessage:(NSString *)message width:(CGFloat)width height:(CGFloat)height;

/**
 指定したビューに追加し表示します。指定秒間でフェードイン・フェードアウトします。
 フェードアウト後は親ビューから切り離されます
 */
- (void)showInView:(UIView *)view withTimeInterval:(NSTimeInterval)t;

/**
 指定したビューに追加し表示します。指定秒間でフェードイン・フェードアウトします。
 フェードアウト後は親ビューから切り離されます
 */
+ (void)showInView:(UIView *)view withMessage:(NSString *)message
          delegate:(nullable id<MKAToastViewDelegate>)delegate timeInterval:(NSTimeInterval)t;
/**
 指定したビューに追加し表示します。指定秒間でフェードイン・フェードアウトします。
 フェードアウト後は親ビューから切り離されます
 */
+ (void)showInView:(UIView *)view withMessage:(NSString *)message
          delegate:(nullable id<MKAToastViewDelegate>)delegate timeInterval:(NSTimeInterval)t
        identifier:(NSInteger)identifier;
@end

@protocol MKAToastViewDelegate <NSObject>
@optional
/**
 ToastViewが消える直前に呼ばれます
 */
- (void)toastViewWillDisappear:(MKAToastView *)toastView;
/**
 ToastViewが消えた直後に呼ばれます
 */
- (void)toastViewDidDisappear:(MKAToastView *)toastView;
@end

NS_ASSUME_NONNULL_END
