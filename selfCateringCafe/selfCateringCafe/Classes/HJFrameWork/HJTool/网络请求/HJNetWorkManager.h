//
//  HJNetWorkManager.h
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/9/2.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HJNetWorkModel.h"
NS_ASSUME_NONNULL_BEGIN

//请求失败
typedef void(^NetWorkFailed)(NSError *error);
//请求成功
typedef void(^NetWorkSucess)(HJNetWorkModel *result);

@interface HJNetWorkManager : NSObject

+(instancetype)shareManager;


/**
 POST请求
 
 @param url 请求链接
 @param params 请求参数
 @param sucessBlock 成功回调
 @param faildBlock 失败回调
 */
-(void)AFPostDataUrl:(NSString *)url params:(NSMutableDictionary *)params sucessBlock:(NetWorkSucess)sucessBlock Faild:(__nullable NetWorkFailed)faildBlock;


/**
 GET请求
 
 @param url 请求链接
 @param params 请求参数
 @param sucessBlock 成功回调
 @param faildBlock 失败回调
 */
-(void)AFGetDataUrl:(NSString *)url params:(NSMutableDictionary *)params sucessBlock:(NetWorkSucess)sucessBlock Faild:(NetWorkFailed)faildBlock;


@end

NS_ASSUME_NONNULL_END
