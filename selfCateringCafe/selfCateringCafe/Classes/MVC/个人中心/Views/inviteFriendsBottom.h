//
//  inviteFriendsBottom.h
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/9/5.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface inviteFriendsBottom : UIView

/** 邀请码 */
@property (nonatomic,weak) UILabel *inviteNumLabel;


/** block */
@property (nonatomic,copy) void(^ShareBlock)(NSInteger tag);


@end

NS_ASSUME_NONNULL_END
