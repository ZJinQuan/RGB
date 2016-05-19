//
//  ModelView.m
//  RGB
//
//  Created by QUAN on 16/5/12.
//  Copyright © 2016年 QUAN. All rights reserved.
//

#import "ModelView.h"

@implementation ModelView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self = [[[NSBundle mainBundle] loadNibNamed:@"ModelView" owner:self options:nil] lastObject];
        
        
        UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
        
        btn.backgroundColor = [UIColor yellowColor];
        
//        [self addSubview:btn];
        
    }
    return self;
}


@end
