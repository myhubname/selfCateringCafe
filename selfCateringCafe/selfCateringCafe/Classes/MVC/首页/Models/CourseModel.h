//
//  CourseModel.h
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/11/6.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CourseModel : NSObject


/** Id */
@property (nonatomic,copy) NSString *Id;

/** topic */
@property (nonatomic,copy) NSString *topic;

/** pic */
@property (nonatomic,copy) NSString *pic;

/** price */
@property (nonatomic,copy) NSString *price;

/** sellcount */
@property (nonatomic,copy) NSString *sellcount;



@end

NS_ASSUME_NONNULL_END
