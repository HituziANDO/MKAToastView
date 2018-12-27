//
//  MKAToastConfiguration.m
//  MKAToastView
//
//  Created by Masaki Ando
//  Copyright (c) 2018 Hituzi Ando. All rights reserved.
//

#import "MKAToastConfiguration.h"

const CGFloat MKAToastDefaultWidth = 300.f;
const CGFloat MKAToastDefaultHeight = 80.f;

@implementation MKAToastConfiguration

- (instancetype)init {
    self = [super init];

    if (self) {
        _width = MKAToastDefaultWidth;
        _height = MKAToastDefaultHeight;
    }

    return self;
}

- (id)copyWithZone:(nullable NSZone *)zone {
    MKAToastConfiguration *config = [MKAToastConfiguration new];
    config.width = self.width;
    config.height = self.height;

    return config;
}

@end
