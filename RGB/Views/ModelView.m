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

-(IBAction)modeChanged:(id)sender
{
    NSInteger t;
    UIButton *button;
    button=(UIButton*)sender;
    t=button.tag;
    
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    
    
    Byte bytes[17];
    for (int i = 0; i < 17; i++) {
        bytes[i] = 0x00;
    }
    bytes[0] = 0x55;
    bytes[1] = 0xaa;
    bytes[2] = 0x01;
    bytes[3] = 0x02;
    bytes[4] = self.index + 1;
    bytes[5] = t;
    
    
    
    NSData *data = [NSData dataWithBytes:bytes length:17];
    NSLog(@"---------------%@",data);
    
    [app.socket senddata:data];
    
    
}


@end
