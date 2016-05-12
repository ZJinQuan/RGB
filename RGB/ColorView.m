//
//  ColorView.m
//  RGB
//
//  Created by QUAN on 16/5/12.
//  Copyright © 2016年 QUAN. All rights reserved.
//

#import "ColorView.h"

@implementation ColorView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"ColorView" owner:self options:nil] lastObject];
    }
    return self;
}

@end
