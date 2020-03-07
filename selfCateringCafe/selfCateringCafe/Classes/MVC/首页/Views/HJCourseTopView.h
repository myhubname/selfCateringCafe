//
//  HJCourseTopView.h
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/9/4.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HJCourseTopView : UIView

/** 分类点击 */
@property (nonatomic,weak) HJLayoutBtn *classBtn;

/**销量 */
@property (nonatomic,weak) HJLayoutBtn *sellBtn;

/** 价格 */
@property (nonatomic,weak) HJLayoutBtn *priceBtn;

/** 时间 */
@property (nonatomic,weak) HJLayoutBtn *timeBtn;


@end

NS_ASSUME_NONNULL_END
