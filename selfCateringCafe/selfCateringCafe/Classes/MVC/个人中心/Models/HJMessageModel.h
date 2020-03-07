//
//  HJMessageModel.h
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/11/11.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HJMessageModel : NSObject

/** Id */
@property (nonatomic,copy) NSString *Id;

/** topic */
@property (nonatomic,copy) NSString *topic;

/** msg */
@property (nonatomic,copy) NSString *msg;

/** pic */
@property (nonatomic,copy) NSString *pic;

/** date */
@property (nonatomic,copy) NSString *date;

/** isread */
@property (nonatomic,copy) NSString *isread;

@end

NS_ASSUME_NONNULL_END
