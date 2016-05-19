//
//  ColorView.m
//  RGB
//
//  Created by QUAN on 16/5/12.
//  Copyright © 2016年 QUAN. All rights reserved.
//

#import "ColorView.h"
#import "LightView.h"
#import <QuartzCore/QuartzCore.h>

#define MYWIDTH self.bounds.size.width
#define MYHEIGHT self.bounds.size.height
#define MYCENTER CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5)


@interface ColorView ()

@property (nonatomic,strong)UIImageView *backImage; //背景图片
@property (nonatomic,strong)UIImageView *centerImage;//中间的图片
@property (weak, nonatomic) IBOutlet UIView *colorView;

@property (nonatomic, strong) LightView *lightView;
@end

@implementation ColorView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"ColorView" owner:self options:nil] lastObject];
        
        self.centerImage = [[UIImageView alloc]initWithFrame:CGRectMake(60, 60, 30, 30)];
        self.centerImage.image = [UIImage imageNamed:@"xishe.png"];
        [self addSubview:self.centerImage];
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LightView:) name:@"LightView" object:nil];
        
    }
    return self;
}

-(void) LightView:(NSNotification *)not{
    
    self.dataStr = [(NSString *)not.object floatValue];
    
    NSLog(@"------========-%f",self.dataStr);
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"closingSlide" object:nil];
    
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
    
    CGFloat chassRadius = (MYHEIGHT - 40)*0.5 - MYWIDTH/20;
//    NSLog(@"chassRadius:%f",chassRadius);
    CGFloat absDistanceX = fabs(currentPoint.x - MYCENTER.x);
    CGFloat absDistanceY = fabs(currentPoint.y - MYCENTER.y);
    CGFloat currentTopointRadius = sqrtf(absDistanceX  * absDistanceX + absDistanceY *absDistanceY);
    
//    NSLog(@"currentRadius:%f",currentTopointRadius);
    
    if(currentTopointRadius < chassRadius){//实在色盘上面
        
        self.centerImage.center =  currentPoint;
        UIColor *color = [self colorOfPoint:currentPoint];

        self.colorView.backgroundColor = color;

        CGFloat const *colorData = CGColorGetComponents(color.CGColor);
        
        
        CGFloat const dataliht = self.dataStr;
        
        AppDelegate *app = [UIApplication sharedApplication].delegate;
        
        
        Byte bytes[17];
        for (int i = 0; i < 17; i++) {
            bytes[i] = 0x00;
        }
        bytes[0] = 0x55;
        bytes[1] = 0xaa;
        bytes[2] = 0x01;
        bytes[3] = 0x01;
        bytes[4] = self.index + 1;
        bytes[5] = colorData[0] * 255.0f;
        bytes[6] = colorData[1] * 255.0f;
        bytes[7] = colorData[2] * 255.0f;
        bytes[8] = dataliht;
        
        
        NSLog(@"-============------++++%hhu",bytes[8]);
        
        NSData *data = [NSData dataWithBytes:bytes length:17];
        NSLog(@"---------------%@",data);

        [app.socket senddata:data];
        
        
        if(self.delegate && [self.delegate respondsToSelector:@selector(getCurrentColor:)]){
            
            [self.delegate getCurrentColor:color];
        }
    }
    
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"closingSlide" object:nil];
    
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
    
    CGFloat chassisRadius = (MYHEIGHT - 40)*0.5 - MYWIDTH/20;
    CGFloat absDistanceX = (currentPoint.x - MYCENTER.x);
    CGFloat absDistanceY = (currentPoint.y - MYCENTER.y);
    CGFloat currentTopointRadius = sqrtf(absDistanceX * absDistanceX + absDistanceY *absDistanceY);
    
    
    CGFloat const dataliht = self.dataStr;
    
    if (currentTopointRadius <chassisRadius) {
        //取色
        self.centerImage.center = currentPoint;
        
        UIColor *color = [self colorOfPoint:currentPoint];
        
        CGFloat const *colorData = CGColorGetComponents(color.CGColor);
        
        AppDelegate *app = [UIApplication sharedApplication].delegate;

        
        Byte bytes[17];
        for (int i = 0; i < 17; i++) {
            bytes[i] = 0x00;
        }
        bytes[0] = 0x55;
        bytes[1] = 0xaa;
        bytes[2] = 0x01;
        bytes[3] = 0x01;
        bytes[4] = self.index + 1;
        bytes[5] = colorData[0] * 255.0f;
        bytes[6] = colorData[1] * 255.0f;
        bytes[7] = colorData[2] * 255.0f;
        bytes[8] = dataliht;
        NSData *data = [NSData dataWithBytes:bytes length:17];
        
        [app.socket senddata:data];
        
        NSLog(@"++++++++++++++++%hhu",bytes[4]);
        
        NSLog(@"---------------%@",data);
        
        self.colorView.backgroundColor = color;
        if(self.delegate && [self.delegate respondsToSelector:@selector(getCurrentColor:)]){
            
            [self.delegate getCurrentColor:color];
        }
        
        
    }
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"closingSlide" object:@"closingSlide"];
}

//获取一个点拿到颜色
- (UIColor *)colorOfPoint:(CGPoint)point {
    
    unsigned char pixel[4] = {0};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(pixel, 1, 1, 8, 4, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedLast);
    
    CGContextTranslateCTM(context, -point.x, -point.y);
    
    [self.layer renderInContext:context];
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    UIColor *color = [UIColor colorWithRed:pixel[0]/255.0 green:pixel[1]/255.0 blue:pixel[2]/255.0 alpha:pixel[3]/255.0];
    
    return color;
}

@end
