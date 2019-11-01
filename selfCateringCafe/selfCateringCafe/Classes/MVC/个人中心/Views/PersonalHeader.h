//
//  PersonalHeader.h
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/8/30.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PersonalHeader : UIView

/** 字典 */
@property (nonatomic,copy) NSDictionary *dic;

/** block */
@property (nonatomic,copy) void(^block)(void);


/** block */
@property (nonatomic,copy) void(^goToYuanClick)(void);


@end

NS_ASSUME_NONNULL_END
