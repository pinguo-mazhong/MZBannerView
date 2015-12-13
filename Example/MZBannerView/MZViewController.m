//
//  MZViewController.m
//  MZBannerView
//
//  Created by mz on 12/11/2015.
//  Copyright (c) 2015 mz. All rights reserved.
//

#import "MZViewController.h"
#import "MZBannerView.h"

@interface MZViewController ()
@property (nonatomic) MZBannerView *bannerView;
@property (nonatomic) CGRect originFrame;
@end
@end

@implementation MZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:0.99];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.alwaysBounceVertical = YES;
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"005.jpg"]];
    backgroundView.frame = self.view.bounds;
    [scrollView addSubview:backgroundView];

    CGFloat w = self.view.bounds.size.width;
    self.originFrame = CGRectMake(0, 0, w, 180);

    UIView *greenView = [[UIView alloc] initWithFrame:self.originFrame];
    greenView.backgroundColor = [UIColor greenColor];
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 40, 60)];
    btn1.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    btn1.backgroundColor = [UIColor blueColor];
    [greenView addSubview:btn1];
    UIView *yellowView = [[UIView alloc] initWithFrame:self.originFrame];
    UILabel *lable2 = [[UILabel alloc] initWithFrame:CGRectMake(40, 30, 100, 40)];
    lable2.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    lable2.text = @"hello world";
    [yellowView addSubview:lable2];
    yellowView.backgroundColor = [UIColor yellowColor];
    UIView *redView = [[UIView alloc] initWithFrame:self.originFrame];
    redView.backgroundColor = [UIColor redColor];



    // 情景一：采用本地图片实现
    NSArray *images = @[[UIImage imageNamed:@"h1.jpg"],
                        greenView,
                        [UIImage imageNamed:@"h2.jpg"],
                        yellowView,
                        [UIImage imageNamed:@"h3.jpg"],
                        redView,
                        [UIImage imageNamed:@"h4.jpg"]
                        ];


    self.bannerView = [ cycleScrollViewWithFrame:self.originFrame imagesGroup:images];

    self.bannerView.infiniteLoop = YES;
    //    self.bannerView.autoScrollTimeInterval = 5;
    self.bannerView.delegate = self;
    self.bannerView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    [scrollView addSubview:self.bannerView];

    [self.view addSubview:scrollView];

    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(40, 400, 200, 40)];
    [slider addTarget:self action:@selector(changeHeight:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];

    UIButton *resetButton = [[UIButton alloc] initWithFrame:CGRectMake(40, 480, 60, 40)];
    resetButton.backgroundColor = [UIColor greenColor];
    [resetButton addTarget:self action:@selector(resetFrame) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resetButton];
}

- (void)changeHeight:(UISlider *)slider
{
    CGRect frame = self.originFrame;
    CGFloat newHeight = frame.size.height * (1 + slider.value);
    self.bannerView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, newHeight);
}

- (void)resetFrame
{
    self.bannerView.frame = self.originFrame;
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", index);
}

@end
