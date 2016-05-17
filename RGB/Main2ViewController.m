//
//  Main2ViewController.m
//  RGB
//
//  Created by QUAN on 16/5/17.
//  Copyright © 2016年 QUAN. All rights reserved.
//

#import "Main2ViewController.h"

@interface Main2ViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;

@end

@implementation Main2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.mainScrollView.delegate = self;
 
    self.mainScrollView.contentSize = CGSizeMake(kScreenWidth * 8, self.mainScrollView.height);
    
//    
//    for (int i = 0; i < 8; i ++) {
//        
//        UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(i * , <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>);
//        
//    }
    
    
    
    
}

@end
