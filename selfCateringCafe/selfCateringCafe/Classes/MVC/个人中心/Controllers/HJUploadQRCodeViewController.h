//
//  HJUploadQRCodeViewController.h
//  InterestingCrowdSourcing
//
//  Created by 胡俊杰 on 2020/1/9.
//  Copyright © 2020 胡俊杰. All rights reserved.
//

#import "HJBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HJUploadQRCodeViewController : HJBaseViewController

/** paycode */
@property (nonatomic,copy) NSString *paycode;

/** block */
@property (nonatomic,copy) void(^uploadSucessBlock)(NSString *imageStr);


@end

NS_ASSUME_NONNULL_END
