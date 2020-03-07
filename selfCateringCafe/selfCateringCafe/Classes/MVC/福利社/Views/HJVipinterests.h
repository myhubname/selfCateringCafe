//
//  HJVipinterests.h
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/9/29.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HJVipinterests : UIImageView

/** 数组 */
@property (nonatomic,copy) NSArray *vipArray;

@end

@interface vipCollectionCell : UICollectionViewCell

/** 图片 */
@property (nonatomic,weak) UIImageView *iconImageView;

/** 昵称 */
@property (nonatomic,weak) UILabel *nameLabel;

/** 描述 */
@property (nonatomic,weak) UILabel *desLabel;

@end


NS_ASSUME_NONNULL_END
