//
//  MyMessageTableViewCell.h
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/10/18.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJMessageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyMessageTableViewCell : UITableViewCell

/** 模型 */
@property (nonatomic,strong) HJMessageModel *model;



@end

NS_ASSUME_NONNULL_END
