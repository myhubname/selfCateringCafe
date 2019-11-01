//
//  HJPersonalChnageBtnTableViewCell.h
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/8/30.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HJPersonalChnageBtnTableViewCell : UITableViewCell


/** 数组  */
@property (nonatomic,copy) NSArray *dataArray;


/** block */
@property (nonatomic,copy) void(^didBlock)(NSString *name);



@end

@interface MoreBtnCollectionCell : UICollectionViewCell


/** 图片 */
@property (nonatomic,weak) UIImageView *iconImageView;

/** 昵称 */
@property (nonatomic,weak) UILabel *nameLabel;

@end


NS_ASSUME_NONNULL_END
