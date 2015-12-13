//
//  MZBannerView.h
//  Pods
//
//  Created by mazhong on 15/12/11.
//
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MZBannerViewPageControlAlignment)
{
    MZBannerViewPageControlAlignmentCenter,
    MZBannerViewPageControlAlignmentRight,
};

@class MZBannerView;

@protocol MZBannerViewDelegate <NSObject>

- (void)bannerView:(MZBannerView *)bannerView didScrollToItemAtIndex:(NSInteger)index;
- (void)bannerView:(MZBannerView *)bannerView didSelectItemAtIndex:(NSInteger)index;

@end

@interface MZBannerView : UIView

/**
 *  内容数组
 */
@property (nonatomic) NSArray *itemsArray;
/**
 *  标题数组
 */
@property (nonatomic) NSArray *titlesArray;


/**
 *  自动轮播时间间隔，默认2s
 */
@property (nonatomic) CGFloat autoScrollTimeInterval;
/**
 *  是否无限循环，默认YES
 */
@property (nonatomic) BOOL infiniteLoop;
/**
 *  是否自动轮播，默认YES
 */
@property (nonatomic) BOOL autoScroll;
@property (nonatomic, weak) id<MZBannerViewDelegate> delegate;


/**
 *  是否显示分页控件
 */
@property (nonatomic) BOOL showPageControl;
/**
 *  只有一个item时隐藏pageControl，默认YES
 */
@property (nonatomic) BOOL hidesForSinglePage;
/**
 *  pageControl的位置，默认居中
 */
@property (nonatomic) MZBannerViewPageControlAlignment pageControlAlignment;
/**
 *  pageControl控件小圆标的大小
 */
@property (nonatomic) CGSize pageControlDotSize;
/**
 *  pageControl控件小圆标的颜色，默认白色
 */
@property (nonatomic) UIColor *pageControlDotColor;


/**
 *  标题文字颜色
 */
@property (nonatomic) UIColor *titleLabelTextColor;
/**
 *  标题字体
 */
@property (nonatomic) UIFont *titleLabelTextFont;
/**
 *  标题背景色，默认透明
 */
@property (nonatomic) UIColor *titleLabelBackgroundColor;
/**
 *  标题高度
 */
@property (nonatomic) CGFloat titleLabelHeight;


+ (instancetype)bannerViewWithFrame:(CGRect)frame items:(NSArray *)items;
@end
