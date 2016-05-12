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

@implementation LightView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"LightView" owner:self options:nil] lastObject];
        
        
//        YHArcSlider *slider = [[YHArcSlider alloc] initWithFrame:self.bounds];
        
        YHArcSlider *slder = [[YHArcSlider alloc] initWithFrame:self.bounds];
        slder.startAngle = M_PI_4* 3;
        
//        [slder addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
        
        UIColor *greenColor = [UIColor orangeColor];
        
        YHSector *sector = [YHSector sectorWithColor:greenColor maxValue:19];
        
        sector.tag = 2;
        
        sector.startValue = 0;
        sector.endValue = 14;
        
        
        slder.sector = sector;
        slder.sectorsRadius = self.width / 2 - 10;
        slder.lineWidth = 2;
        slder.circleLineWidth = 10;
        [self addSubview:slder];
        
    }
    return self;
}

@end
