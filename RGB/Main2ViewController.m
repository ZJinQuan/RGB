//
//  Main2ViewController.m
//  RGB
//
//  Created by QUAN on 16/5/17.
//  Copyright © 2016年 QUAN. All rights reserved.
//

#import "Main2ViewController.h"
#import "MainView.h"
#import "PageView.h"

@interface Main2ViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIPageControl *pageView;

@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;

@end

@implementation Main2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    PageView *pageView = [[PageView alloc] initWithFrame:CGRectMake(0, 80, self.view.bounds.size.width, 37)];
    
    pageView.backgroundColor = [UIColor clearColor];
    
    pageView.numberOfPages = 8;
    
    pageView.currentPage = 0;
    
    pageView.pageIndicatorTintColor = [UIColor clearColor];
    
    pageView.currentPageIndicatorTintColor = [UIColor clearColor];
    
    [self.view addSubview:pageView];
    
    self.pageView = pageView;
    self.pageView.userInteractionEnabled = NO;
    [self.pageView addTarget:self action:@selector(pageTurn:) forControlEvents:UIControlEventValueChanged];
    
    
    for (int i = 0; i < 8; i++) {
        
        MainView *main = [[MainView alloc] init];
        
        CGFloat VX = i * self.mainScrollView.width;
        
        main.frame = CGRectMake(VX, 0, self.mainScrollView.width, self.mainScrollView.height);
        //隐藏指示条
        self.mainScrollView.showsHorizontalScrollIndicator = NO;
        
        main.tag = i;
        
        [self.mainScrollView addSubview:main];
        
    }
    
    
    self.mainScrollView.contentSize = CGSizeMake(self.mainScrollView.width * 8, 0);
    
    self.mainScrollView.pagingEnabled = YES;
    
    self.mainScrollView.delegate = self;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closingSlide:) name:@"closingSlide" object:nil];
}

-(void) closingSlide:(NSNotification *) not{
    
    if (not.object == nil) {
        
        self.mainScrollView.scrollEnabled = NO;
        
    }else{
        
        self.mainScrollView.scrollEnabled = YES;
        
    }
    
}

#pragma mark UIScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    //更新UIPageControl的当前页
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.frame;
    [self.pageView setCurrentPage:offset.x / bounds.size.width];
    NSLog(@"%f",offset.x / bounds.size.width);
    
}

-(void)pageTurn:(UIPageControl *) sender {
    
    //令UIScrollView做出相应的滑动显示
    CGSize viewSize = self.mainScrollView.frame.size;
    CGRect rect = CGRectMake(sender.currentPage * viewSize.width, 0, viewSize.width, viewSize.height);
    [self.mainScrollView scrollRectToVisible:rect animated:YES];
    
    [sender setNeedsDisplay];
    
}

@end
