//
//  FanRingTableViewCell.h
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/9/2.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FanRingModel.h"
NS_ASSUME_NONNULL_BEGIN
@class FanRingTableViewCell;
@protocol FanRingTableViewCellDelegate <NSObject>


/// 点击了图片
- (void)cell:(FanRingTableViewCell *)cell didClickImageAtIndex:(NSUInteger)index;

/// 点击了转发
- (void)cellDidClickRepost:(FanRingTableViewCell *)cell;



@end
@interface FanRingTableViewCell : UITableViewCell

/** FanRingModel */
@property (nonatomic,strong) FanRingModel *model;

/** 代理 */
@property (nonatomic,weak) id<FanRingTableViewCellDelegate> delegate;

@property (nonatomic, strong) NSArray<UIView *> *picViews;      // 图片

@end
@interface fanBottomView : UIView

/** FanRingModel */
@property (nonatomic,strong) FanRingModel *model;

/** FanRingTableViewCell */
@property (nonatomic,strong) FanRingTableViewCell *cell;



@end

NS_ASSUME_NONNULL_END
