//
//  MZCollectionViewCell.h
//  Pods
//
//  Created by mazhong on 15/12/13.
//
//

#import <UIKit/UIKit.h>

@interface MZCollectionViewCell : UICollectionViewCell

@property (nonatomic) UIImageView *itemView;
@property (copy, nonatomic) NSString *title;

@property (nonatomic, strong) UIColor *titleLabelTextColor;
@property (nonatomic, strong) UIFont *titleLabelTextFont;
@property (nonatomic, strong) UIColor *titleLabelBackgroundColor;
@property (nonatomic, assign) CGFloat titleLabelHeight;

@property (nonatomic, assign) BOOL hasConfigured;

@end
