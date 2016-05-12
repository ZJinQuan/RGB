//
//  ColorView.h
//  RGB
//
//  Created by QUAN on 16/5/12.
//  Copyright © 2016年 QUAN. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SelectViewDelegate <NSObject>

-(void)getCurrentColor:(UIColor *)color;

@end


@interface ColorView : UIView

@property (nonatomic,weak)id<SelectViewDelegate>delegate;

@end
