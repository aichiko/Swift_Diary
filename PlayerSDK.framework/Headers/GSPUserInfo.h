//
//  GSPUserInfo.h
//  PlayerSDK
//
//  Created by Gaojin Hsu on 6/10/15.
//  Copyright (c) 2015 Geensee. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  直播中的用户信息
 */
@interface GSPUserInfo : NSObject

/**
 *  用户的用户ID
 */
@property (assign, nonatomic)long long userID;

/**
 *  昵称
 */
@property (strong, nonatomic)NSString *userName;

/**
 *  聊天所使用的ID
 */
@property (assign, nonatomic)unsigned chatID;

/**
 *  用户的角色
 */
@property (assign, nonatomic)unsigned role;

@end