//
//  HJAddressFooter.h
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/11/16.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJAddressModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HJAddressFooter : UITableViewHeaderFooterView

/** 模型 */
@property (nonatomic,strong) HJAddressModel *model;

/** block */
@property (nonatomic,copy) void(^setDefaultBlock)(void);

/** 编辑 */
@property (nonatomic,copy) void(^editBlock)(HJAddressModel *model);


@end

NS_ASSUME_NONNULL_END
