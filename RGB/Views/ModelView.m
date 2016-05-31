//
//  ModelView.m
//  RGB
//
//  Created by QUAN on 16/5/12.
//  Copyright © 2016年 QUAN. All rights reserved.
//

#import "ModelView.h"

#define MYWIDTH self.bounds.size.width
#define MYHEIGHT self.bounds.size.height
#define MYCENTER CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5)
@implementation ModelView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self = [[[NSBundle mainBundle] loadNibNamed:@"ModelView" owner:self options:nil] lastObject];
        
        
        UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
        
        btn.backgroundColor = [UIColor yellowColor];
        
    }
    return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
    
    CGFloat chassisRadius = (MYHEIGHT - 30)*0.5 - MYWIDTH/20;
    CGFloat absDistanceX = (currentPoint.x - MYCENTER.x);
    CGFloat absDistanceY = (currentPoint.y - MYCENTER.y);
    CGFloat currentTopointRadius = sqrtf(absDistanceX * absDistanceX + absDistanceY *absDistanceY);
    
    if (currentTopointRadius < chassisRadius) {
        
        NSLog(@"%f",currentTopointRadius);
        
//        double *dian = atan[(currentPoint.y-self.centerX)/(currentPoint.x-self.centerY)];
        
        
        CGPoint curre = [self CirclePoint:chassisRadius / 2 withCenterCircle:self.center withCurrentPoint:currentPoint];
        
        
        NSLog(@"x---%f, y---%f",curre.x, curre.y);
        
    }

}

-(CGPoint)CirclePoint:(CGFloat)radius withCenterCircle:(CGPoint)centerCircle withCurrentPoint:(CGPoint)currentPoint
{
    CGPoint cPoint;
    CGFloat x = currentPoint.x;
    CGFloat y = currentPoint.y;
    CGFloat cX ; //圆的X坐标轨迹
    CGFloat cY ; //圆的Y坐标轨迹
    CGFloat daX; // 圆心到转动按钮的距离的平方
    //CGFloat daY;
    CGFloat aX;  // 圆心到转动按钮的距离
    //CGFloat aY;
    CGFloat cosX;  // 圆心水平方向与转动按钮形成的夹角的cos值
    
    //圆心与触控点的距离的平方（勾股定理）
    daX =  (x - centerCircle.x)*(x - centerCircle.x) + (y - centerCircle.y)*(y - centerCircle.y);
    aX = sqrt(daX); //开根号  //圆心与触控点的距离
    cosX =  fabs(x - centerCircle.x)/aX;  //绝对值
    cX = cosX*radius ; //  x =R * cosX;  圆心到触控点在水平坐标的X的值
    cY = sqrt(radius*radius - cX*cX);
    
    if(x<centerCircle.x) //如果X所在的点小于圆心 在圆心的左边
    {
        cX = centerCircle.x - cX;
    }
    else
    {
        cX = centerCircle.x + cX;
    }
    
    if(y<centerCircle.y)
    {
        cY = centerCircle.y - cY;
    }
    else
    {
        cY = centerCircle.y + cY;
    }
    cPoint.x = cX;
    cPoint.y = cY;
    return cPoint;
}


//-(IBAction)modeChanged:(id)sender
//{
//    NSInteger t;
//    UIButton *button;
//    button=(UIButton*)sender;
//    t=button.tag;
//    
//    AppDelegate *app = [UIApplication sharedApplication].delegate;
//    
//    
//    Byte bytes[17];
//    for (int i = 0; i < 17; i++) {
//        bytes[i] = 0x00;
//    }
//    bytes[0] = 0x55;
//    bytes[1] = 0xaa;
//    bytes[2] = 0x01;
//    bytes[3] = 0x02;
//    bytes[4] = self.index + 1;
//    bytes[5] = t;
//    
//    
//    
//    NSData *data = [NSData dataWithBytes:bytes length:17];
//    NSLog(@"---------------%@",data);
//    
//    [app.socket senddata:data];
//    
//    
//}


@end
