//
//  HJCatche.m
//  MyFrameWork
//
//  Created by HJ_StyleMac on 2018/12/28.
//  Copyright © 2018 HJ_StyleMac. All rights reserved.
//

#import "HJCatche.h"

@implementation HJCatche

#pragma mark-NSUserDefaults的操作
//存值
void userDefaultSave(id value,NSString *key){
    
    [HJUserDefaults setObject:value forKey:key];
    
    [HJUserDefaults synchronize];//同步磁盘的数据
}
//获取存储值
id userDefaultGet(NSString *key){

    return [HJUserDefaults objectForKey:key];
}
//移除存储值
void userDefaultRemove(NSString *key)
{
    [HJUserDefaults removeObjectForKey:key];
}

#pragma mark-计算缓存的方法
//计算缓存
id calculateCatche(void){
   
    NSInteger totalSize = 0.0;
    
//    totalSize += [[SDImageCache sharedImageCache] getSize];
    totalSize += [SDImageCache sharedImageCache].totalDiskSize;
    totalSize += [SDImageCache sharedImageCache].totalDiskCount;
    YYImageCache *YYCache = [YYWebImageManager sharedManager].cache;
    totalSize += YYCache.diskCache.totalCount;
    totalSize += YYCache.memoryCache.totalCost;
    totalSize += YYCache.memoryCache.totalCount;
    totalSize += YYCache.diskCache.totalCost;
    totalSize += YYCache.diskCache.totalCount;
    
    NSString *cacheStr = [NSString stringWithFormat:@" %0.2fMB", (unsigned long) totalSize / 1024. / 1024.];

    return cacheStr;
    
}
//移除缓存
void removeCatche(void){
    
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
    }];
    YYImageCache *cache = [YYWebImageManager sharedManager].cache;
    [cache.memoryCache removeAllObjects];
    [cache.diskCache removeAllObjects];

}



@end
