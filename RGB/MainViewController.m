//
//  MainViewController.m
//  RGB
//
//  Created by QUAN on 16/5/13.
//  Copyright © 2016年 QUAN. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UIScrollView *mainView;
@property (weak, nonatomic) IBOutlet UICollectionView *collView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
    
    UIView *v1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth -20, kScreenHeight)];
    
    v1.backgroundColor = [UIColor yellowColor];
    
    UIView *v2 = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth + 10, 0, kScreenWidth -20, kScreenHeight)];
    
    v2.backgroundColor = [UIColor purpleColor];
    
    UIView *v3 = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth * 2 + 10, 0, kScreenWidth -20, kScreenHeight)];
    
    v3.backgroundColor = [UIColor lightGrayColor];
    
    UIView *v4 = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth *3 + 10, 0, kScreenWidth-20, kScreenHeight)];
    
    v4.backgroundColor = [UIColor grayColor];
    
    UIView *v5 = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth *4 + 10, 0, kScreenWidth-20, kScreenHeight)];
    
    v5.backgroundColor = [UIColor darkGrayColor];
    
    [_mainView addSubview:v1];
    [_mainView addSubview:v2];
    [_mainView addSubview:v3];
    [_mainView addSubview:v4];
    [_mainView addSubview:v5];
    
    _mainView.contentSize = CGSizeMake(kScreenWidth *5, v1.height);
    //    _mainView.pagingEnabled = YES;
    
    //    _mainView.contentInset = UIEdgeInsetsMake(0, -20, 0, -20);
    
    */
    
    UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc] init];
    
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collView.collectionViewLayout = flowLayout;
    
    self.collView.backgroundView.backgroundColor = [UIColor yellowColor];
    
    [self.collView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    
    

    
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
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

    
    cell.backgroundColor = [UIColor colorWithRed:((10 * indexPath.row) / 255.0) green:200.0 blue:255.0 alpha:1.0f];
    CGRect rect = [cell convertRect:cell.frame toView:self.view];
    
//    UIView *view = [[UIView alloc] initWithFrame:]
    
//    [cell addSubview:<#(nonnull UIView *)#>]
    
    return cell;
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(300, 500);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}



@end
