//
//  MainView.m
//  RGB
//
//  Created by QUAN on 16/5/13.
//  Copyright © 2016年 QUAN. All rights reserved.
//

#import "MainView.h"
#import "LightView.h"
#import "ModelView.h"
#import "ColorView.h"

@interface MainView ()

@property (weak, nonatomic) IBOutlet UIView *mainView;

@property (nonatomic, strong) LightView *lightView;
@property (nonatomic, strong) ModelView *modelView;
@property (nonatomic, strong) ColorView *colorView;

@property (weak, nonatomic) IBOutlet UIButton *lightBtn;
@property (weak, nonatomic) IBOutlet UIButton *colorBtn;
@property (weak, nonatomic) IBOutlet UIButton *modelBtn;

@end

@implementation MainView

-(LightView *)lightView{
    
    if (_lightView == nil) {
        _lightView = [[LightView alloc] init];
        _lightView.frame = self.mainView.bounds;
        _lightView.hidden = YES;
    }
    return _lightView;
}

-(ModelView *)modelView{
    
    if (_modelView == nil) {
        _modelView = [[ModelView alloc] init];
        _modelView.frame = self.mainView.bounds;
        _modelView.hidden = YES;
    }
    return _modelView;
}

-(ColorView *)colorView{
    
    if (_colorView == nil) {
        _colorView = [[ColorView alloc] init];
        _colorView.frame = self.mainView.bounds;
        _colorView.hidden = YES;
        
    }
    return _colorView;
}


- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"MainView" owner:self options:nil] lastObject];
        
        [self.mainView addSubview:self.lightView];
        [self.mainView addSubview:self.modelView];
        [self.mainView addSubview:self.colorView];
        
        [self clickSeg:self.lightBtn];
        
        NSLog(@"---8--%ld",self.index);
        
        NSLog(@"--- _______%ld", self.tag);
        
    }
    return self;
}
- (IBAction)clickSeg:(UIButton *)sender {
    
    NSLog(@"-----%ld",self.tag + 1);
    
    switch (sender.tag) {
        case 1000:{
            
            sender.selected = YES;
            self.lightBtn.selected = NO;
            self.modelBtn.selected = NO;
            
            _colorView.index = self.tag;
            
            _colorView.hidden = NO;
            _lightView.hidden = YES;
            _modelView.hidden = YES;
            
        }
            break;
        case 1001:{
            sender.selected = YES;
            self.colorBtn.selected = NO;
            self.modelBtn.selected = NO;
            
            _lightView.index = self.tag;
            
            _colorView.hidden = YES;
            _lightView.hidden = NO;
            _modelView.hidden = YES;
        }
            break;
        case 1002:{
            sender.selected = YES;
            self.colorBtn.selected = NO;
            self.lightBtn.selected = NO;
            
            _modelView.index = self.tag;
            _colorView.hidden = YES;
            _lightView.hidden = YES;
            _modelView.hidden = NO;
        }
            break;
            
        default:
            break;
    }
    
    
}

- (IBAction)clickClosedDown:(UIButton *)sender {
    
    NSLog(@"关闭");
}

/** 设置是第几个灯的 */
- (void)setTag:(NSInteger)tag
{
    [super setTag:tag];
    
    self.lightView.index = tag;
    self.colorView.index = tag;
    self.modelView.index = tag;
}

@end
