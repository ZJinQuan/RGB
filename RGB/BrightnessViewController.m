//
//  BrightnessViewController.m
//  RGB
//
//  Created by QUAN on 16/5/12.
//  Copyright © 2016年 QUAN. All rights reserved.
//

#import "BrightnessViewController.h"
#import "LightView.h"
#import "ModelView.h"
#import "ColorView.h"

@interface BrightnessViewController ()
@property (weak, nonatomic) IBOutlet UIButton *lightBtn;
@property (weak, nonatomic) IBOutlet UIButton *colorBtn;
@property (weak, nonatomic) IBOutlet UIButton *modelBtn;
@property (weak, nonatomic) IBOutlet UIView *mainView;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segView;

@property (nonatomic, strong) LightView *lightView;
@property (nonatomic, strong) ModelView *modelView;
@property (nonatomic, strong) ColorView *colorView;

@end

@implementation BrightnessViewController

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

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.mainView addSubview:self.lightView];
    [self.mainView addSubview:self.modelView];
    [self.mainView addSubview:self.colorView];
    
}
- (IBAction)clickSeg:(UIButton *)sender {
    
    switch (sender.tag) {
        case 1000:{

            sender.selected = YES;
            self.lightBtn.selected = NO;
            self.modelBtn.selected = NO;
            
            _colorView.hidden = NO;
            _lightView.hidden = YES;
            _modelView.hidden = YES;
            
        }
            break;
        case 1001:{
            sender.selected = YES;
            self.colorBtn.selected = NO;
            self.modelBtn.selected = NO;
            
            _colorView.hidden = YES;
            _lightView.hidden = NO;
            _modelView.hidden = YES;
        }
            break;
        case 1002:{
            sender.selected = YES;
            self.colorBtn.selected = NO;
            self.lightBtn.selected = NO;
            
            _colorView.hidden = YES;
            _lightView.hidden = YES;
            _modelView.hidden = NO;
        }
            break;
            
        default:
            break;
    }
    
}

@end
