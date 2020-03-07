//
//  HJTeamTypeHeader.h
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/10/17.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HJTeamTypeHeader : UITableViewHeaderFooterView

/** type */
@property (nonatomic,assign) NSInteger type;


/** block */
@property (nonatomic,copy) void(^teamBlock)(NSInteger type);


@end

NS_ASSUME_NONNULL_END
