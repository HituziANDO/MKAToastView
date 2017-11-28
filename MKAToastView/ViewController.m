//
//  ViewController.m
//  MKAToastView
//
//  Created by Masaki Ando on 2017/03/25.
//  Copyright © 2017年 Hituzi Ando. All rights reserved.
//

#import "ViewController.h"

#import "MKAToastView.h"

@interface ViewController () <MKAToastViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    MKAToastViewConfiguration *config = [MKAToastViewConfiguration new];
    config.width = 200.f;
    config.height = 50.f;
    [MKAToastView setDefaultConfiguration:config];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showButtonClicked:(id)sender {
    [MKAToastView showInView:self.view withMessage:@"Hello World!" delegate:self timeInterval:MKAToastViewShortTime
                  identifier:1];
}

#pragma mark - MKAToastViewDelegate

- (void)toastViewWillDisappear:(MKAToastView *)toastView {
    NSLog(@"%s", __func__);
}

- (void)toastViewDidDisappear:(MKAToastView *)toastView {
    if (toastView.identifier == 1) {
        NSLog(@"%s", __func__);
    }
}

@end
