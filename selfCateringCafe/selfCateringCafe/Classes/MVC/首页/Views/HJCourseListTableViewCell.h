//
//  HJCourseListTableViewCell.h
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/10/30.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HJCourseListTableViewCell : UITableViewCell

/** 数量 */
@property (nonatomic,weak) UILabel *numLabel;

/** 标题 */
@property (nonatomic,weak) UILabel *nameLabel;

/** 时长 */
@property (nonatomic,weak) UILabel *timeLabel;

@end

NS_ASSUME_NONNULL_END
