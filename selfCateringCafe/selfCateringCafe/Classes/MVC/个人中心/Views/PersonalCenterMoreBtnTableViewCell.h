//
//  PersonalCenterMoreBtnTableViewCell.h
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/8/30.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PersonalCenterMoreBtnTableViewCell : UITableViewCell

/** 按钮点击事件 */
@property (nonatomic,copy) void(^moreBtnBlock)(NSInteger tag);


@end

NS_ASSUME_NONNULL_END
