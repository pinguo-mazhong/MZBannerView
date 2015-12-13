//
//  MZBannerView.m
//  Pods
//
//  Created by mazhong on 15/12/11.
//
//

#import "MZBannerView.h"
#import "MZCollectionViewCell.h"


@interface MZBannerView () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic) NSUInteger totalItemsCount;
@property (nonatomic) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic) UICollectionView *mainView;
@property (nonatomic) UIPageControl *pageControl;
@property (nonatomic) NSTimer *timer;
@end
@implementation MZBannerView

+ (instancetype)bannerViewWithFrame:(CGRect)frame items:(NSArray *)items
{
    MZBannerView *bannerView = [[self alloc] initWithFrame:frame];
    bannerView.itemsArray = items;
    return bannerView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self initDefaultSettings];
        [self initUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self initDefaultSettings];
        [self initUI];
    }
    return self;
}

- (void)dealloc
{
    [self stopTimer];
}

- (void)initDefaultSettings
{
    _autoScrollTimeInterval = 2.0;
    _infiniteLoop = YES;
    _autoScroll = YES;

    _showPageControl = YES;
    _hidesForSinglePage = YES;
    _pageControlAlignment = MZBannerViewPageControlAlignmentCenter;
    _pageControlDotSize = CGSizeMake(10, 10);
    _pageControlDotColor = [UIColor whiteColor];

    _titleLabelTextColor = [UIColor whiteColor];
    _titleLabelTextFont = [UIFont systemFontOfSize:14];
    _titleLabelBackgroundColor = [UIColor clearColor];
    _titleLabelHeight = 30;
}

- (void)initUI
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = self.frame.size;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _flowLayout = flowLayout;

    UICollectionView *mainView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    mainView.pagingEnabled = YES;
    mainView.showsHorizontalScrollIndicator = NO;
    mainView.showsVerticalScrollIndicator = NO;
    [mainView registerClass:[MZCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([MZCollectionViewCell class])];
    mainView.dataSource = self;
    mainView.delegate = self;
    [self addSubview:mainView];
    _mainView = mainView;
}

#pragma mark set方法

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    _flowLayout.itemSize = self.frame.size;
}

- (void)setItemsArray:(NSArray *)itemsArray
{
    _itemsArray = itemsArray;
    _totalItemsCount = _infiniteLoop ? _itemsArray.count * 100 : _itemsArray.count;

    if (itemsArray.count > 1)
    {
        self.mainView.scrollEnabled = YES;
        [self setAutoScroll:_autoScroll];
    }
    else
    {
        self.mainView.scrollEnabled = NO;
    }

    [self setupPageControl];
    [self.mainView reloadData];
}

- (void)setAutoScrollTimeInterval:(CGFloat)autoScrollTimeInterval
{
    _autoScrollTimeInterval = autoScrollTimeInterval;
    [self setAutoScroll:_autoScroll];
}

- (void)setAutoScroll:(BOOL)autoScroll
{
    _autoScroll = autoScroll;
    [self stopTimer];
    if (_autoScroll)
    {
        [self startTimer];
    }
}

- (void)setShowPageControl:(BOOL)showPageControl
{
    _showPageControl = showPageControl;
    _pageControl.hidden = !_showPageControl;
}

- (void)setPageControlDotColor:(UIColor *)pageControlDotColor
{
    _pageControlDotColor = pageControlDotColor;
    _pageControl.currentPageIndicatorTintColor = _pageControlDotColor;
}

#pragma mark private method

- (void)setupPageControl
{
    if (_pageControl)
    {
        [_pageControl removeFromSuperview];
    }

    if ((self.itemsArray.count <= 1) && self.hidesForSinglePage)
    {
        return;
    }

    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = self.itemsArray.count;
    pageControl.currentPageIndicatorTintColor = self.pageControlDotColor;
    [self addSubview:pageControl];
    _pageControl = pageControl;
}

- (void)stopTimer
{
    [_timer invalidate];
    _timer = nil;
}

- (void)startTimer
{
    if (!_timer)
    {
        _timer = [NSTimer scheduledTimerWithTimeInterval:_autoScrollTimeInterval target:self selector:@selector(scrollToNextItem) userInfo:nil repeats:YES];
    }
}

- (void)scrollToNextItem
{
    if (_totalItemsCount <= 1)
    {
        return;
    }
    int currentIndex = _mainView.contentOffset.x / _flowLayout.itemSize.width;
    int targetIndex = currentIndex + 1;
    BOOL animated = YES;
    if (targetIndex == _totalItemsCount)
    {
        if (self.infiniteLoop)
        {
            targetIndex = _totalItemsCount * 0.5;
        }
        else
        {
            targetIndex = 0;
        }
        animated = NO;
    }
    [_mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:animated];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    _mainView.frame = self.bounds;
    if (_mainView.contentOffset.x == 0 &&  _totalItemsCount)
    {
        int targetIndex = 0;
        if (self.infiniteLoop)
        {
            targetIndex = _totalItemsCount * 0.5;
        }
        else
        {
            targetIndex = 0;
        }
        [_mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }

    CGSize size = CGSizeMake(self.itemsArray.count * self.pageControlDotSize.width * 1.2, self.pageControlDotSize.height);

    CGFloat x = (self.bounds.size.width - size.width) * 0.5;
    if (self.pageControlAlignment == MZBannerViewPageControlAlignmentRight)
    {
        x = self.mainView.bounds.size.width - size.width - 10;
    }
    CGFloat y = self.mainView.bounds.size.height - size.height - 10;

    _pageControl.frame = CGRectMake(x, y, size.width, size.height);
    _pageControl.hidden = !_showPageControl;
}

#pragma mark collectionView dataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _totalItemsCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MZCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MZCollectionViewCell class]) forIndexPath:indexPath];
    NSUInteger itemIndex = indexPath.item % self.itemsArray.count;
    id item = self.itemsArray[itemIndex];
    if ([item isKindOfClass:[UIImage class]])
    {
        cell.itemView.image = item;
    }
    else if([item isKindOfClass:[UIView class]])
    {
        UIView *view = (UIView *)item;
        view.frame = cell.bounds;
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [cell.itemView addSubview:view];
    }
    if (_titlesArray.count)
    {
        cell.title = _titlesArray[itemIndex];
    }

    if (!cell.hasConfigured)
    {
        cell.titleLabelBackgroundColor = self.titleLabelBackgroundColor;
        cell.titleLabelHeight = self.titleLabelHeight;
        cell.titleLabelTextColor = self.titleLabelTextColor;
        cell.titleLabelTextFont = self.titleLabelTextFont;
        cell.hasConfigured = YES;
    }

    return cell;
}

#pragma mark collectionView delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(bannerView:didSelectItemAtIndex:)])
    {
        [self.delegate bannerView:self didSelectItemAtIndex:indexPath.item % self.itemsArray.count];
    }
}

#pragma mark UIScrollView delegate method

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int itemIndex = (scrollView.contentOffset.x + self.mainView.bounds.size.width * 0.5) / self.mainView.bounds.size.width;
    int indexOnPageControl = itemIndex % self.itemsArray.count;
    _pageControl.currentPage = indexOnPageControl;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.autoScroll)
    {
        [self stopTimer];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.autoScroll)
    {
        [self startTimer];
    }
}
@end
