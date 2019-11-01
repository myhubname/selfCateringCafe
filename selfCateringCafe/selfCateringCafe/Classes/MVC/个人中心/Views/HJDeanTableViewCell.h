//
//  HJDeanTableViewCell.h
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/10/21.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HJDeanTableViewCell : UITableViewCell

/** alertLabel */
@property (nonatomic,weak) UILabel *alertLabel;

/** 内容 */
@property (nonatomic,weak) UILabel *connentLabel;

@end

NS_ASSUME_NONNULL_END
