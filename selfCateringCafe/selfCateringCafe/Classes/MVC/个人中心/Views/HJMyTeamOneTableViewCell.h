//
//  HJMyTeamOneTableViewCell.h
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/10/17.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HJMyTeamOneTableViewCell : UITableViewCell

/** 第一个Label */
@property (nonatomic,weak) UILabel *oneLabel;

/** 第二个 */
@property (nonatomic,weak) UILabel *twoLabel;

/** 第三个 */
@property (nonatomic,weak) UILabel *threeLabel;

/** 第四个 */
@property (nonatomic,weak) UILabel *fourLabel;


/** line */
@property (nonatomic,weak) UIView *line;

@end

NS_ASSUME_NONNULL_END
