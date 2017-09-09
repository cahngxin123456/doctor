//
//  IWScrollHeaderView.m
//  Conedot
//
//  Created by 范超 on 15/6/8.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import "IWScrollHeaderView.h"
#import "IWBannerCell.h"

// 每一组最大的行数
#define MJNewsTotalRowsInSection (5000 * self.newses.count)
#define MJNewsDefaultRow (NSUInteger)(MJNewsTotalRowsInSection * 0.5)

@interface IWScrollHeaderView()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong, nonatomic) NSTimer *timer;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *collectionFlowView;

@end

@implementation IWScrollHeaderView

+ (instancetype)headerView {
    return [[NSBundle mainBundle] loadNibNamed:@"IWScrollHeaderView" owner:nil options:nil][0];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.collectionView.width = [UIScreen mainScreen].bounds.size.width;
    [self.collectionFlowView setItemSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 140)];
    [self.collectionView registerNib:[UINib nibWithNibName:@"IWBannerCell" bundle:nil] forCellWithReuseIdentifier:@"banner"];
    
    [self addTimer];
}

- (void)removeTimer {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)addTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(nextNews) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)nextNews {
    NSIndexPath *visiablePath = [[self.collectionView indexPathsForVisibleItems] firstObject];
    
    NSUInteger visiableItem = visiablePath.item;
    if ((visiablePath.item % self.newses.count)  == 0) { // 第0张图片
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:MJNewsDefaultRow inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        visiableItem = MJNewsDefaultRow;
    }
    
    NSUInteger nextItem = visiableItem + 1;
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:nextItem inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}

- (void)setNewses:(NSArray *)newses {
    _newses = newses;
    
    // 总页数
    self.pageControl.numberOfPages = self.newses.count;
    // 刷新数据
    [self.collectionView reloadData];
    // 默认组
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:MJNewsDefaultRow inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
}

#pragma mark - 数据源
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return MJNewsTotalRowsInSection;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"banner";
    IWBannerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.banner = self.newses[indexPath.item % self.newses.count];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    NSIndexPath *visiablePath = [[collectionView indexPathsForVisibleItems] firstObject];
    self.pageControl.currentPage = visiablePath.item % self.newses.count;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self removeTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self addTimer];
}

@end
