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

- (instancetype)initWithMessage:(NSString *)message frame:(CGRect)frame {
    self = [super initWithFrame:frame];

    if (self) {
        _animationDuration = kDefaultAnimationDuration;

        // Adds left and right margin.
        _label = [[UILabel alloc] initWithFrame:CGRectMake(20.f, 0, frame.size.width - 40.f, 0)];

        _label.text = message;
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

- (instancetype)initWithMessage:(NSString *)message width:(CGFloat)width height:(CGFloat)height {
    // Places horizontal center adding margin bottom.
    CGSize screen = [UIScreen mainScreen].bounds.size;
    CGRect frame = CGRectMake((screen.width - width) * .5f,
                              screen.height - (height + 56.f),
                              width,
                              height);

    return [self initWithMessage:message frame:frame];
}

- (instancetype)initWithMessage:(NSString *)message size:(CGSize)size {
    return [self initWithMessage:message width:size.width height:size.height];
}

#pragma mark - public method

- (void)showWithTimeInterval:(NSTimeInterval)t {
    UIView *view = [UIApplication sharedApplication].keyWindow.rootViewController.view;
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

+ (void)showWithMessage:(NSString *)message
               delegate:(nullable id <MKAToastDelegate>)delegate
           timeInterval:(NSTimeInterval)t {

    [self showWithMessage:message delegate:delegate timeInterval:t identifier:0];
}

+ (void)showWithMessage:(NSString *)message
               delegate:(nullable id <MKAToastDelegate>)delegate
           timeInterval:(NSTimeInterval)t
             identifier:(NSInteger)identifier {

    if (!_config) {
        [self setDefaultConfiguration:[MKAToastConfiguration new]];
    }

    MKAToast *toast = [[MKAToast alloc] initWithMessage:message width:_config.width height:_config.height];
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
