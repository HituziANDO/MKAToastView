//
//  MKAToast.m
//  MKAToastView
//
//  Created by Masaki Ando
//  Copyright (c) 2018-2019 Hituzi Ando. All rights reserved.
//

#import "MKAToast.h"

#import "MKAToastConfiguration.h"

const NSTimeInterval MKAToastShortTime = 3.0;
const NSTimeInterval MKAToastLongTime = 5.0;

@interface MKAToast ()

@property (nonatomic) UILabel *label;

@end

@implementation MKAToast

static const NSTimeInterval kDefaultAnimationDuration = .3;

static MKAToastConfiguration *_config = nil;

- (instancetype)initWithText:(NSString *)text frame:(CGRect)frame {
    self = [super initWithFrame:frame];

    if (self) {
        _animationDuration = kDefaultAnimationDuration;

        // Adds left and right margin.
        _label = [[UILabel alloc] initWithFrame:CGRectMake(20.f, 0, frame.size.width - 40.f, 0)];

        _label.text = text;
        _label.textColor = [UIColor whiteColor];

        // Available to line break.
        _label.numberOfLines = 0;   // Infinite lines.
        _label.lineBreakMode = NSLineBreakByWordWrapping;

        [_label sizeToFit];

        [self addSubview:_label];

        _label.center = CGPointMake(frame.size.width * .5f, frame.size.height * .5f);

        self.layer.cornerRadius = frame.size.height * .5f;
        self.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:.95f];

        // Hide characters that protrude.
        self.clipsToBounds = YES;
    }

    return self;
}

- (instancetype)initWithText:(NSString *)text width:(CGFloat)width height:(CGFloat)height {
    // Places horizontal center adding margin bottom.
    CGSize screen = [UIScreen mainScreen].bounds.size;
    CGRect frame = CGRectMake((screen.width - width) * .5f,
                              screen.height - (height + 56.f),
                              width,
                              height);

    return [self initWithText:text frame:frame];
}

- (instancetype)initWithText:(NSString *)text size:(CGSize)size {
    return [self initWithText:text width:size.width height:size.height];
}

#pragma mark - public method

- (void)showWithTimeInterval:(NSTimeInterval)t {
    UIView *view = [UIApplication sharedApplication].keyWindow.subviews.lastObject;
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
                                                        selector:@selector(hide:)
                                                        userInfo:nil
                                                         repeats:NO];
                     }];
}

+ (void)showText:(NSString *)text withTimeInterval:(NSTimeInterval)t {
    [self showText:text withDelegate:nil timeInterval:t identifier:0];
}

+ (void)showText:(NSString *)text withDelegate:(nullable id <MKAToastDelegate>)delegate timeInterval:(NSTimeInterval)t {
    [self showText:text withDelegate:delegate timeInterval:t identifier:0];
}

+ (void)showText:(NSString *)text
    withDelegate:(nullable id <MKAToastDelegate>)delegate
    timeInterval:(NSTimeInterval)t
      identifier:(NSInteger)identifier {

    if (!_config) {
        [self setDefaultConfiguration:[MKAToastConfiguration new]];
    }

    MKAToast *toast = [[MKAToast alloc] initWithText:text width:_config.width height:_config.height];
    toast.delegate = delegate;
    toast.identifier = identifier;
    [toast showWithTimeInterval:t];
}

+ (void)setDefaultConfiguration:(MKAToastConfiguration *)config {
    if (!config) {
        return;
    }

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _config = [config copy];
    });
}

#pragma mark - private method

- (void)hide:(NSTimer *)timer {
    if ([self.delegate respondsToSelector:@selector(toastWillDisappear:)]) {
        [self.delegate toastWillDisappear:self];
    }

    [UIView animateWithDuration:self.animationDuration
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         self.alpha = 0;
                     }
                     completion:^(BOOL b) {
                         [self removeFromSuperview];

                         if ([self.delegate respondsToSelector:@selector(toastDidDisappear:)]) {
                             [self.delegate toastDidDisappear:self];
                         }
                     }];
}

@end
