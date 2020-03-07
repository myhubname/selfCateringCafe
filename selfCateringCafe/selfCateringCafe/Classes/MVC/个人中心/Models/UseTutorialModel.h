//
//  UseTutorialModel.h
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/10/21.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UseTutorialModel : NSObject

/*
 "Id": "2",
 "topic": "圈粉",
 "date": "2018-10-13",
 "intro": "人们习惯性的同情弱者，总会把疼爱留给最脆弱的人，坚强的人，只是露着笑脸，而自己，其实也想有个肩膀依赖。",
 "cover": ["20181013\/5bc1970821f28.jpg", "20181013\/5bc197083e63d.jpg", "20181013\/5bc197085f67a.jpg"],
 "author": "乐享传媒营销号",
 "pic": "default\/logo.jpg",
 "url": "http:\/\/192.168.0.221\/lexiang\/Mobile\/News\/detail\/2.html"
 */

/** id */
@property (nonatomic,copy) NSString *Id;

/** topic */
@property (nonatomic,copy) NSString *topic;

/** date */
@property (nonatomic,copy) NSString *date;

/** intro */
@property (nonatomic,copy) NSString *intro;

/** cover */
@property (nonatomic,copy) NSString *cover;

/** author */
@property (nonatomic,copy) NSString *author;

/** pic */
@property (nonatomic,copy) NSString *pic;


/** url */
@property (nonatomic,copy) NSString *url;


@end

NS_ASSUME_NONNULL_END
