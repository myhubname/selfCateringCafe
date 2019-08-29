//
//  HJMoreClassTableViewCell.h
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/8/29.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HJMoreClassTableViewCell : UITableViewCell

/** 数组 */
@property (nonatomic,copy) NSArray *dataArray;


@end

@interface HJMoreClassCollectionCell : UICollectionViewCell

/** 图片 */
@property (nonatomic,weak) UIImageView *logoImageView;

/** 昵称 */
@property (nonatomic,weak) UILabel *nameLabel;

@end

NS_ASSUME_NONNULL_END
