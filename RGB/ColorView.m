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
        
//        UIColor *color1 = [self colorOfPoint:currentPoint];
        
        UIColor *color = [self colorOfPoint:currentPoint];
        
        CGFloat const *colorData = CGColorGetComponents(color.CGColor);
        
        AppDelegate *app = [UIApplication sharedApplication].delegate;

//        CGFloat const *ligt= [self.index ];
        
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

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
}

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


- (UIColor*) getPixelColorAtLocation:(CGPoint)point {
    UIColor* color = nil;
    //    CGImageRef inImage = self.image.CGImage;
    
    UIGraphicsBeginImageContext(self.bounds.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    CGImageRef inImage = viewImage.CGImage;
    
    // Create off screen bitmap context to draw the image into. Format ARGB is 4 bytes for each pixel: Alpa, Red, Green, Blue
    CGContextRef cgctx = [self createARGBBitmapContextFromImage:inImage];
    if (cgctx == NULL) { return nil; /* error */ }
    
    size_t w = self.bounds.size.width;
    size_t h = self.bounds.size.height;
    
    CGRect rect = {{0,0},{w,h}};
    
    // Draw the image to the bitmap context. Once we draw, the memory
    // allocated for the context for rendering will then contain the
    // raw image data in the specified color space.
    CGContextDrawImage(cgctx, rect, inImage);
    
    // Now we can get a pointer to the image data associated with the bitmap
    // context.
    unsigned char* data = CGBitmapContextGetData (cgctx);
    if (data != NULL) {
        //offset locates the pixel in the data from x,y.
        //4 for 4 bytes of data per pixel, w is width of one row of data.
        int offset = 4*((w*round(point.y))+round(point.x));
        int alpha =  data[offset];
        int red = data[offset+1];
        int green = data[offset+2];
        int blue = data[offset+3];
        //        NSLog(@"offset: %i colors: RGB A %i %i %i  %i",offset,red,green,blue,alpha);
        color = [UIColor colorWithRed:(red/255.0f) green:(green/255.0f) blue:(blue/255.0f) alpha:(alpha/255.0f)];
    }
    
    // When finished, release the context
    CGContextRelease(cgctx);
    // Free image data memory for the context
    if (data) { free(data); }
    
    
    
    return color;
}

- (CGContextRef) createARGBBitmapContextFromImage:(CGImageRef) inImage {
    
    CGContextRef    context = NULL;
    CGColorSpaceRef colorSpace;
    void *          bitmapData;
    int             bitmapByteCount;
    int             bitmapBytesPerRow;
    
    size_t pixelsWide = self.bounds.size.width;
    size_t pixelsHigh = self.bounds.size.height;
    
    // Declare the number of bytes per row. Each pixel in the bitmap in this
    // example is represented by 4 bytes; 8 bits each of red, green, blue, and
    // alpha.
    bitmapBytesPerRow   = (pixelsWide * 4);
    bitmapByteCount     = (bitmapBytesPerRow * pixelsHigh);
    
    // Use the generic RGB color space.
    colorSpace = CGColorSpaceCreateDeviceRGB();
    
    if (colorSpace == NULL)
    {
        fprintf(stderr, "Error allocating color space\n");
        return NULL;
    }
    
    // Allocate memory for image data. This is the destination in memory
    // where any drawing to the bitmap context will be rendered.
    bitmapData = malloc( bitmapByteCount );
    if (bitmapData == NULL)
    {
        fprintf (stderr, "Memory not allocated!");
        CGColorSpaceRelease( colorSpace );
        return NULL;
    }
    
    // Create the bitmap context. We want pre-multiplied ARGB, 8-bits
    // per component. Regardless of what the source image format is
    // (CMYK, Grayscale, and so on) it will be converted over to the format
    // specified here by CGBitmapContextCreate.
    context = CGBitmapContextCreate (bitmapData,
                                     pixelsWide,
                                     pixelsHigh,
                                     8,      // bits per component
                                     bitmapBytesPerRow,
                                     colorSpace,
                                     kCGImageAlphaPremultipliedFirst);
    if (context == NULL)
    {
        free (bitmapData);
        fprintf (stderr, "Context not created!");
    }
    
    // Make sure and release colorspace before returning
    CGColorSpaceRelease( colorSpace );
    
    return context;
}


@end
