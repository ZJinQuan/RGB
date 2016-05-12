//
//  ColorView.m
//  RGB
//
//  Created by QUAN on 16/5/12.
//  Copyright © 2016年 QUAN. All rights reserved.
//

#import "ColorView.h"

#define MYWIDTH self.bounds.size.width
#define MYHEIGHT self.bounds.size.height
#define MYCENTER CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5)


@interface ColorView ()

@property (nonatomic,strong)UIImageView *backImage; //背景图片
@property (nonatomic,strong)UIImageView *centerImage;//中间的图片
@property (weak, nonatomic) IBOutlet UIView *colorView;

@end

@implementation ColorView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"ColorView" owner:self options:nil] lastObject];
        
        self.centerImage = [[UIImageView alloc]initWithFrame:CGRectMake(60, 60, 15, 15)];
        self.centerImage.image = [UIImage imageNamed:@"icon_absorb"];
        [self addSubview:self.centerImage];
    }
    return self;
}


//-(void)drawRect:(CGRect)rect{
//    
//    [super drawRect:rect];
//
//    UIImage *imageCenter = [UIImage imageNamed:@"state4"];
//    [imageCenter drawInRect:self.bounds];
//    
//    self.backgroundColor = [UIColor blackColor];
//    
//    self.centerImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 15, 15)];
//    self.centerImage.image = [UIImage imageNamed:@"icon_absorb"];
//    [self addSubview:self.centerImage];
//}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
    
    CGFloat chassRadius = (MYHEIGHT - 40)*0.5 - MYWIDTH/20;
    NSLog(@"chassRadius:%f",chassRadius);
    CGFloat absDistanceX = fabs(currentPoint.x - MYCENTER.x);
    CGFloat absDistanceY = fabs(currentPoint.y - MYCENTER.y);
    CGFloat currentTopointRadius = sqrtf(absDistanceX  * absDistanceX + absDistanceY *absDistanceY);
    
    NSLog(@"currentRadius:%f",currentTopointRadius);
    
    if(currentTopointRadius < chassRadius){//实在色盘上面
        
        self.centerImage.center =  currentPoint;
        UIColor *color = [self getPixelColorAtLocation:currentPoint];
        
        self.colorView.backgroundColor = color;
        if(self.delegate && [self.delegate respondsToSelector:@selector(getCurrentColor:)]){
            
            [self.delegate getCurrentColor:color];
            
            
        }
    }
    
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
    
    CGFloat chassisRadius = (MYHEIGHT - 40)*0.5 - MYWIDTH/20;
    CGFloat absDistanceX = (currentPoint.x - MYCENTER.x);
    CGFloat absDistanceY = (currentPoint.y - MYCENTER.y);
    CGFloat currentTopointRadius = sqrtf(absDistanceX * absDistanceX + absDistanceY *absDistanceY);
    
    
    if (currentTopointRadius <chassisRadius) {
        //取色
        self.centerImage.center = currentPoint;
        UIColor *color = [self getPixelColorAtLocation:currentPoint];
        
        self.colorView.backgroundColor = color;
        if(self.delegate && [self.delegate respondsToSelector:@selector(getCurrentColor:)]){
            
            [self.delegate getCurrentColor:color];
        }
        
        
    }
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
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