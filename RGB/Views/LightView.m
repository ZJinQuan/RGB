//
//  LightView.m
//  RGB
//
//  Created by QUAN on 16/5/12.
//  Copyright © 2016年 QUAN. All rights reserved.
//

#import "LightView.h"
#import "YHMath.h"
#import "YHArcSlider.h"
#import "ColorView.h"

@implementation LightView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"LightView" owner:self options:nil] lastObject];
        
        YHArcSlider *slder = [[YHArcSlider alloc] initWithFrame:CGRectMake(0, 0, 260, 260)];
        slder.startAngle = M_PI_4* 3;
        
        [slder addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
        
        UIColor *greenColor = [UIColor orangeColor];
        
        YHSector *sector = [YHSector sectorWithColor:greenColor maxValue:19];
        
        sector.minValue = 0;
        sector.maxValue = 350;
        
        sector.tag = 2;
        
        sector.startValue = 0;
        sector.endValue = 255;
        
        
        slder.sector = sector;
        slder.sectorsRadius = self.width / 2;
        slder.lineWidth = 2;
        slder.circleLineWidth = 10;
        [self addSubview:slder];
        
        
    }
    return self;
}

- (void)valueChange:(YHArcSlider *)slder {
    
    
    NSLog(@"%ld",self.index);
    
    CGFloat const dataliht = [_light floatValue];
    
    Byte bytes[17];
    for (int i = 0; i < 17; i++) {
        bytes[i] = 0x00;
    }
    bytes[0] = 0x55;
    bytes[1] = 0xaa;
    bytes[2] = 0x01;
    bytes[3] = 0x01;
    bytes[4] = self.index + 1;
    bytes[5] = 0x32;
    bytes[6] = 0x33;
    bytes[7] = 0xff;
    bytes[8] = dataliht;
    
    _light =  [NSString stringWithFormat:@"%d", (int)slder.sector.startValue];
    
    NSData *data = [NSData dataWithBytes:bytes length:17];
    
    NSLog(@"================%@",data);
    
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    
    [app.socket senddata:data];
    
    //    [[NSNotificationCenter defaultCenter] postNotificationName:@"LightView" object:_light];
    
}

@end
