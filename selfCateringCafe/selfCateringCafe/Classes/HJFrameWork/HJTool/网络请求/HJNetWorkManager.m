//
//  HJNetWorkManager.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/9/2.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "HJNetWorkManager.h"

@implementation HJNetWorkManager

+(instancetype)shareManager
{
    static HJNetWorkManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[HJNetWorkManager alloc] init];
    });
    return manager;
}


-(void)AFPostDataUrl:(NSString *)url params:(NSMutableDictionary *)params sucessBlock:(NetWorkSucess)sucessBlock Faild:(NetWorkFailed)faildBlock
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"image/jpeg",@"text/plain", nil];
    params[@"token"] = @"87d7d47db37e4d482433b32b37e2196a";
    [manager POST:[NSString stringWithFormat:@"%@%@",kApiPrefix,url] parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        HJNetWorkModel *model = [HJNetWorkModel modelWithJSON:responseObject];
        if (sucessBlock) {
            
            if (model.isSucess) {
                
                
            }else
            {
                
                [HUDManager showStateHud:model.msg state:HUDStateTypeFail];
            }
            
            sucessBlock(model);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (faildBlock) {
            
            faildBlock(error);
        }
        [HUDManager showStateHud:@"网络错误" state:HUDStateTypeFail];
        
    }];
}


- (void)AFGetDataUrl:(NSString *)url params:(NSMutableDictionary *)params sucessBlock:(NetWorkSucess)sucessBlock Faild:(NetWorkFailed)faildBlock
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    params[@"token"] = @"87d7d47db37e4d482433b32b37e2196a";
    [manager GET:[NSString stringWithFormat:@"%@%@",kApiPrefix,url] parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (sucessBlock) {
            
            HJNetWorkModel *model = [HJNetWorkModel modelWithJSON:responseObject];
            
            if (model.isSucess) {
                
            }
            else
            {
                [HUDManager showStateHud:model.msg state:HUDStateTypeFail];
            }
            
            sucessBlock(model);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (faildBlock) {
            faildBlock(error);
        }
        [HUDManager showStateHud:@"网络错误" state:HUDStateTypeFail];
    }];
    
}





@end
