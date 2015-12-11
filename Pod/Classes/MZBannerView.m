//
//  MZBannerView.m
//  Pods
//
//  Created by mazhong on 15/12/11.
//
//

#import "MZBannerView.h"


@interface MZBannerView ()
@property (nonatomic) NSUInteger totolItemsCount;
@property (nonatomic) UICollectionViewFlowLayout *flowLayout;
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

- (void)initDefaultSettings
{
    _autoScrollTimeInterval = 2.0;
    _infiniteLoop = YES;
    _autoScroll = YES;

    _showPageControl = YES;
    _hidesForSinglePage = YES;
    _pageControlStyle = MZBannerViewPageControlStyleAnimated;
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
}

#pragma mark set方法

- (void)setItemsArray:(NSArray *)itemsArray
{
    _itemsArray = itemsArray;
    _totolItemsCount = _infiniteLoop ? _itemsArray.count * 100 : _itemsArray.count;
}

@end
