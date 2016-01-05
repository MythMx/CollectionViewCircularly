//
//  ViewController2.m
//  CollectionViewDemo1
//
//  Created by liu on 16/1/4.
//  Copyright © 2016年 vizz. All rights reserved.
//

#import "ViewController2.h"
#import "CollectionViewCell2.h"

@interface ViewController2 ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;


@property (nonatomic, strong) NSMutableArray *imageNames;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ViewController2


- (NSMutableArray *)imageNames
{
    if (!_imageNames) {
        _imageNames = [NSMutableArray array];
        [_imageNames addObject:@"6"];
        for (NSInteger i = 1; i <= 6; i++) {
            NSString *imageName = [NSString stringWithFormat:@"%ld", (long)i];
            [_imageNames addObject:imageName];
        }
        [_imageNames addObject:@"1"];
    }
    
    return _imageNames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.sectionInset = UIEdgeInsetsZero;
    
    self.pageControl.numberOfPages = self.imageNames.count - 2;
}

- (void)nextPage
{
    NSInteger index = _collectionView.contentOffset.x / _collectionView.bounds.size.width;
    
    [_collectionView setContentOffset:CGPointMake(++index * _collectionView.bounds.size.width, 0) animated:YES];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    [_collectionView setContentOffset:CGPointMake([UIScreen mainScreen].bounds.size.width, 0) animated:NO];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [_collectionView setContentOffset:CGPointMake([UIScreen mainScreen].bounds.size.width, 0) animated:NO];
    
    [self setupTimer];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageNames.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell2 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell2" forIndexPath:indexPath];
    
    cell.imageName = self.imageNames[indexPath.row];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return CGSizeMake(collectionView.bounds.size.width, collectionView.bounds.size.height);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self setupTimer];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self adjustPageWithScrollView:scrollView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self adjustPageWithScrollView:scrollView];
}


- (void)adjustPageWithScrollView:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / _collectionView.bounds.size.width;
    
//    NSLog(@"%d", (int)index);
    
    if (index == 0) {
        [scrollView setContentOffset:CGPointMake((_imageNames.count - 2) * _collectionView.bounds.size.width, 0) animated:NO];
        _pageControl.currentPage = _imageNames.count - 2;
    } else if (index == _imageNames.count - 1) {
        [scrollView setContentOffset:CGPointMake(_collectionView.bounds.size.width, 0) animated:NO];
        _pageControl.currentPage = 0;
    } else {
        _pageControl.currentPage = index - 1;
    }
}


- (void)setupTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.5f target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
