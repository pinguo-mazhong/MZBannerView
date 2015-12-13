//
//  MZCollectionViewCell.m
//  Pods
//
//  Created by mazhong on 15/12/13.
//
//

#import "MZCollectionViewCell.h"

@interface MZCollectionViewCell ()
@property (nonatomic) UILabel *titleLabel;
@end

@implementation MZCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupContentView];
        [self setupTitleLabel];
    }

    return self;
}

- (void)prepareForReuse
{
    for (UIView *subview in self.itemView.subviews)
    {
        [subview removeFromSuperview];
    }
}

- (void)setTitleLabelBackgroundColor:(UIColor *)titleLabelBackgroundColor
{
    _titleLabelBackgroundColor = titleLabelBackgroundColor;
    _titleLabel.backgroundColor = titleLabelBackgroundColor;
}

- (void)setTitleLabelTextColor:(UIColor *)titleLabelTextColor
{
    _titleLabelTextColor = titleLabelTextColor;
    _titleLabel.textColor = titleLabelTextColor;
}

- (void)setTitleLabelTextFont:(UIFont *)titleLabelTextFont
{
    _titleLabelTextFont = titleLabelTextFont;
    _titleLabel.font = titleLabelTextFont;
}

- (void)setupContentView
{
    UIImageView *itemView = [[UIImageView alloc] init];
    itemView.contentMode = UIViewContentModeScaleAspectFill;
    _itemView = itemView;
    [self addSubview:itemView];
}

- (void)setupTitleLabel
{
    UILabel *titleLabel = [[UILabel alloc] init];
    _titleLabel = titleLabel;
    _titleLabel.hidden = YES;
    [self addSubview:titleLabel];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    _titleLabel.text = [NSString stringWithFormat:@"   %@", title];
}


- (void)layoutSubviews
{
    [super layoutSubviews];

    _itemView.frame = self.bounds;
    for (UIView *subView in _itemView.subviews)
    {
        subView.frame = _itemView.bounds;
    }

    CGFloat titleLabelW = self.bounds.size.width;
    CGFloat titleLabelH = _titleLabelHeight;
    CGFloat titleLabelX = 0;
    CGFloat titleLabelY = self.bounds.size.height - titleLabelH;
    _titleLabel.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    _titleLabel.hidden = !_titleLabel.text;
}

@end
