//
//  HJNetWorkModel.h
//  Hardware
//
//  Created by 胡俊杰 on 2019/8/20.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HJNetWorkModel : NSObject

/** success */
@property (nonatomic,copy) NSString *success;

/** msg */
@property (nonatomic,copy) NSString *msg;

/** retCode */
@property (nonatomic,copy) NSString *retCode;

/** 数据源 */
@property (nonatomic,strong) id data;


/** BOOL */
@property (nonatomic,assign) BOOL isSucess;


@end

NS_ASSUME_NONNULL_END
