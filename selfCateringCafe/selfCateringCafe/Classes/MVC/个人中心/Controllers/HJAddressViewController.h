//
//  HJAddressViewController.h
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/11/14.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "HJBaseViewController.h"
#import "HJAddressModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HJAddressViewController : HJBaseViewController

/** 选中字典 */
@property (nonatomic,copy) void(^choseAddres)(HJAddressModel *model);

@end

NS_ASSUME_NONNULL_END
