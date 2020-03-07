//
//  HJAddAddressController.h
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/11/16.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "HJBaseViewController.h"
#import "HJAddressModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HJAddAddressController : HJBaseViewController

/** block */
@property (nonatomic,copy) void(^addAddressBlock)(void);


/** HJAddressModel */
@property (nonatomic,strong) HJAddressModel *model;



@end

NS_ASSUME_NONNULL_END
