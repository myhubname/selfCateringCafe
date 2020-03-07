//
//  CoursePayBottom.h
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/10/10.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CoursePayBottom : UIView

/** 价格 */
@property (nonatomic,weak) UILabel *priceLabel;

/** 购买 */
@property (nonatomic,weak) UIButton *buyButton;

/** 按钮 */
@property (nonatomic,copy) void(^buyBlock)(void);


@end

NS_ASSUME_NONNULL_END
