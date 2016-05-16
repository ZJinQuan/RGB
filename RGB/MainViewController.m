//
//  MainViewController.m
//  RGB
//
//  Created by QUAN on 16/5/13.
//  Copyright © 2016年 QUAN. All rights reserved.
//

#import "MainViewController.h"
#import "MainView.h"
#import "PageView.h"

@interface MainViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

//@property (weak, nonatomic) IBOutlet UIPageControl *pageView;

@property (nonatomic, strong) UIPageControl *pageView;

@property (weak, nonatomic) IBOutlet UICollectionView *collView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc] init];
    
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    flowLayout.itemSize = CGSizeMake(kScreenWidth, 500);
    
    flowLayout.minimumLineSpacing = 0;
    
    self.collView.collectionViewLayout = flowLayout;
    
    self.collView.backgroundView.backgroundColor = [UIColor yellowColor];
    
    [self.collView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    
    self.collView.pagingEnabled = YES;
    
    PageView *pageView = [[PageView alloc] initWithFrame:CGRectMake(0, 80, self.view.bounds.size.width, 37)];
    
    pageView.backgroundColor = [UIColor clearColor];
    
    pageView.numberOfPages = 8;
    
    pageView.currentPage = 0;
    
    pageView.pageIndicatorTintColor = [UIColor clearColor];
    
    pageView.currentPageIndicatorTintColor = [UIColor clearColor];
    
    [self.view addSubview:pageView];
    
    self.pageView = pageView;
    
    [self.pageView addTarget:self action:@selector(pageTurn:) forControlEvents:UIControlEventValueChanged];
}

-(void)pageTurn:(UIPageControl *) sender {
    
    //令UIScrollView做出相应的滑动显示
    CGSize viewSize = self.collView.frame.size;
    CGRect rect = CGRectMake(sender.currentPage * viewSize.width, 0, viewSize.width, viewSize.height);
    [self.collView scrollRectToVisible:rect animated:YES];
    
    [sender setNeedsDisplay];
    
}

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 8;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"Cell";
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    CGRect rect = [cell convertRect:cell.frame toView:self.view];
    
    NSLog(@"%f, %f",cell.bounds.size.height, cell.bounds.size.width);
    
    if (!cell) {
        cell = [[UICollectionViewCell alloc]init];
    }else{
        while ([cell.contentView.subviews lastObject] != nil) {
            [[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    
    MainView *mainView = [[MainView alloc] initWithFrame:cell.bounds];
    mainView.centerX = self.view.centerX;
    
    [cell.contentView addSubview:mainView];
    

    
    return cell;
}

//定义每个UICollectionView 的大小
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
////    return CGSizeMake(300, 500);
//    return self.view.bounds.size;
//}

//定义每个UICollectionView 的 margin
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(0, 0, 0, 0);
//}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    //更新UIPageControl的当前页
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.frame;
    [self.pageView setCurrentPage:offset.x / bounds.size.width];
    NSLog(@"%f",offset.x / bounds.size.width);
    
}


@end
