//
//  GSPJoinParam.h
//  PlayerSDK
//
//  Created by Gaojin Hsu on 6/9/15.
//  Copyright (c) 2015 Geensee. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  直播服务类型
 */
typedef NS_ENUM(NSUInteger, GSPServiceType){
    /**
     *  webcast
     */
    GSPServiceTypeWebcast,
    /**
     *  training
     */
    GSPServiceTypeTraining,
};

/**
 *  直播参数
 */
@interface GSPJoinParam : NSObject

/**
 *  直播所在站点的域名
 */
@property (nonatomic, copy) NSString *domain;

/**
 *  直播的服务类型
 */
@property (nonatomic, assign) GSPServiceType serviceType;

/**
 *  直播的ID
 */
@property (nonatomic, copy) NSString *webcastID;

/**
 *  直播房间号
 */
@property (nonatomic, copy) NSString *roomNumber;

/**
 *  在直播中显示的昵称
 */
@property (nonatomic, copy) NSString *nickName;

/**
 *  观看直播的密码
 */
@property (nonatomic, copy) NSString *watchPassword;

/**
 *  站点登录名
 */
@property (nonatomic, copy) NSString *loginName;

/**
 *  站点登录密码
 */
@property (nonatomic, copy) NSString *loginPassword;

/**
 *  自定义userID; userID系统会分配，若无特殊需求，一般不需要设置此参数
 */
@property(assign, nonatomic)long long customUserID;


/**
 *  是否要验证自定义userID, 若开启，则自定义userID 大于1000000000（十亿）才生效，若小于十亿，将仍然使用系统分配ID, 默认值为YES
 */
@property(assign, nonatomic)BOOL needsValidateCustomUserID;


/**
 *  第三者验证K值
 */
@property (copy, nonatomic) NSString *thirdToken;

/**
 *  临时变量，请设置成YES，服务器更新后将去掉
 */
@property (assign, nonatomic) BOOL  oldVersion;


@end
