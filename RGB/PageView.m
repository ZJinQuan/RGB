//
//  PageView.m
//  RGB
//
//  Created by QUAN on 16/5/16.
//  Copyright © 2016年 QUAN. All rights reserved.
//

#import "PageView.h"

@interface PageView ()
{
    UIImage *activeImage;
    UIImage *inactiveImage;
    
}
@end


@implementation PageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        activeImage = [UIImage imageNamed:@"state1_pre"];
        inactiveImage = [UIImage imageNamed:@"state1"] ;
        
    }
    return self;
}

- (void)setCurrentPage:(NSInteger)currentPage
{
    [super setCurrentPage:currentPage];
    [self setNeedsDisplay];
}

- (void)setNumberOfPages:(NSInteger)numberOfPages
{
    [super setNumberOfPages:numberOfPages];
    
    [self setNeedsDisplay];
    
}


- (void)drawRect:(CGRect)iRect
{
    int i;
    CGRect rect;
    UIImage *image;
    
    iRect = self.bounds;
    
    if (self.opaque) {
        [self.backgroundColor set];
        UIRectFill(iRect);
    }
    
    UIImage *_activeImage = [UIImage imageNamed:@"state1_pre"];
    UIImage *_inactiveImage = [UIImage imageNamed:@"state1"];
    CGFloat _kSpacing = 5.0f;
    
    if (self.hidesForSinglePage && self.numberOfPages == 1) {
        return;
    }
    
    rect.size.height = _activeImage.size.height;
    rect.size.width = self.numberOfPages * _activeImage.size.width + (self.numberOfPages - 1) * _kSpacing;
    rect.origin.x = floorf((iRect.size.width - rect.size.width) / 2.0);
    rect.origin.y = floorf((iRect.size.height - rect.size.height) / 2.0);
    rect.size.width = _activeImage.size.width;
    
    for (i = 0; i < self.numberOfPages; ++i) {
        image = (i == self.currentPage) ? _activeImage : _inactiveImage;
        [image drawInRect:rect];
        rect.origin.x += _activeImage.size.width + _kSpacing;
    }
}


-(void) updateDots
{
    NSLog(@"-----%lu",(unsigned long)self.subviews.count);
    
    for (int i = 0; i < [self.subviews count]; i++){
        
        UIImageView* dot = [self.subviews objectAtIndex:i];
        if (i == self.currentPage){
            dot.image = activeImage;
        }
        else{
            dot.image = inactiveImage;
        }
    }
}

//-(void) setCurrentPage:(NSInteger)page
//{
//    [super setCurrentPage:page];
//    //修改图标大小
//    for (NSUInteger subviewIndex = 0; subviewIndex < [self.subviews count]; subviewIndex++) {
//        
//        UIImageView* subview = [self.subviews objectAtIndex:subviewIndex];
//        
//        CGSize size;
//        
//        size.height = 10;
//        
//        size.width = 30;
//        
//        [subview setFrame:CGRectMake(subview.frame.origin.x, subview.frame.origin.y, size.width,size.height)];
//        
//    }
//    
//    
//    [self updateDots];
//}
@end
