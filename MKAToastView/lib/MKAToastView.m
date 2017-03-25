//
//  MKAToastView.m
//
//  Created by Masaki Ando
//  Copyright © 2016年 Hituzi Ando. All rights reserved.
//

#import "MKAToastView.h"

const NSTimeInterval MKAToastViewShortTime = 3.0;
const NSTimeInterval MKAToastViewLongTime = 5.0;

const CGFloat MKAToastViewDefaultWidth = 300.f;
const CGFloat MKAToastViewDefaultHeight = 80.f;

static const NSTimeInterval DefaultAnimationDuration = .3;

@interface MKAToastView ()
@property (nonatomic) UILabel *label;
@end

@implementation MKAToastView

- (instancetype)initWithMessage:(NSString *)message frame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _animationDuration = DefaultAnimationDuration;
        
        // 左右に20余白を付ける
        _label = [[UILabel alloc] initWithFrame:CGRectMake(20.f, 0, frame.size.width - 40.f, 0)];
        _label.text = message;
        _label.textColor = [UIColor whiteColor];
        // 改行を可能にする
        _label.numberOfLines = 0;   // 無限行
        _label.lineBreakMode = NSLineBreakByWordWrapping;
        // 文字列に合わせてサイズ調整
        [_label sizeToFit];
        
        [self addSubview:_label];
        
        // ラベルをToastViewの中心に配置
        _label.center = CGPointMake(frame.size.width * .5f, frame.size.height * .5);
        
        // 角丸にする
        self.layer.cornerRadius = frame.size.height * .5f;
        // 背景を少し透過にする
        self.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:.95f];
        // はみ出た文字は隠す
        self.clipsToBounds = YES;
    }
    return self;
}

- (instancetype)initWithMessage:(NSString *)message width:(CGFloat)width height:(CGFloat)height {
    // 水平方向中央かつ下方に56余白が付くところに配置する
    CGSize screen = [UIScreen mainScreen].bounds.size;
    CGRect frame = CGRectMake((screen.width - width) * .5f, screen.height - (height + 56.f), width, height);
    return [self initWithMessage:message frame:frame];
}

#pragma mark - public

- (void)showInView:(UIView *)view withTimeInterval:(NSTimeInterval)t {
    [view addSubview:self];
    
    self.alpha = 0;
    [UIView animateWithDuration:self.animationDuration
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         self.alpha = 1.f;
                     }
                     completion:^(BOOL b) {
                         [NSTimer scheduledTimerWithTimeInterval:t
                                                          target:self
                                                        selector:@selector(onTimer:)
                                                        userInfo:nil
                                                         repeats:NO];
                     }];
}

#pragma mark - private

- (void)onTimer:(NSTimer *)timer {
    if ([self.delegate respondsToSelector:@selector(toastViewWillDisappear:)]) {
        [self.delegate toastViewWillDisappear:self];
    }
    
    [UIView animateWithDuration:self.animationDuration
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         self.alpha = 0;
                     }
                     completion:^(BOOL b) {
                         [self removeFromSuperview];
                         
                         if ([self.delegate respondsToSelector:@selector(toastViewDidDisappear:)]) {
                             [self.delegate toastViewDidDisappear:self];
                         }
                     }];
}

#pragma mark - static public

+ (void)showInView:(UIView *)view withMessage:(NSString *)message
          delegate:(id<MKAToastViewDelegate>)delegate timeInterval:(NSTimeInterval)t {
    
    MKAToastView *toastView = [[MKAToastView alloc] initWithMessage:message
                                                              width:MKAToastViewDefaultWidth
                                                             height:MKAToastViewDefaultHeight];
    toastView.delegate = delegate;
    [toastView showInView:view withTimeInterval:t];
}

+ (void)showInView:(UIView *)view withMessage:(NSString *)message
          delegate:(id<MKAToastViewDelegate>)delegate timeInterval:(NSTimeInterval)t identifier:(NSInteger)identifier {
    
    MKAToastView *toastView = [[MKAToastView alloc] initWithMessage:message
                                                              width:MKAToastViewDefaultWidth
                                                             height:MKAToastViewDefaultHeight];
    toastView.delegate = delegate;
    toastView.identifier = identifier;
    [toastView showInView:view withTimeInterval:t];
}

@end
