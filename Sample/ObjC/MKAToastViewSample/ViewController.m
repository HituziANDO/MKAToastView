//
//  ViewController.m
//  MKAToastViewSample
//
//  Created by Masaki Ando on 2018/12/27.
//  Copyright © 2018年 Hituzi Ando. All rights reserved.
//

#import <MKAToastView/MKAToastView.h>

#import "ViewController.h"

@interface ViewController () <MKAToastDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Sets default configuration.
    MKAToastConfiguration *config = [MKAToastConfiguration new];
    config.width = 200.f;
    config.height = 50.f;
    [MKAToast setDefaultConfiguration:config];
}

#pragma mark - IBAction

- (IBAction)helloButtonPressed:(id)sender {
    [MKAToast showInView:self.view
             withMessage:@"Hello"
                delegate:self
            timeInterval:MKAToastShortTime
              identifier:1];
}

- (IBAction)goodbyeButtonPressed:(id)sender {
    MKAToast *toast = [[MKAToast alloc] initWithMessage:@"Goodbye" width:300.f height:60.f];
    toast.delegate = self;
    toast.identifier = 2;
    [toast showInView:self.view withTimeInterval:MKAToastLongTime];
}

#pragma mark - MKAToastDelegate

- (void)toastWillDisappear:(MKAToast *)toast {
    NSLog(@"Toast ID: %ld will disappear", (long) toast.identifier);
}

- (void)toastDidDisappear:(MKAToast *)toast {
    NSLog(@"Toast ID: %ld did disappear", (long) toast.identifier);
}

@end
