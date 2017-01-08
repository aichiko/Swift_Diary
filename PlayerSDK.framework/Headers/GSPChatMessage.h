//
//  GSPChatMessage.h
//  PlayerSDK
//
//  Created by Gaojin Hsu on 6/17/15.
//  Copyright (c) 2015 Geensee. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  消息类型
 */
typedef NS_ENUM(NSInteger, GSPChatType){
    /**
     *  公聊
     */
    GSPChatTypePublic,
    /**
     *  私聊
     */
    GSPChatTypePrivate,
    /**
     *  系统消息
     */
    GSPChatTypeSystem,
};

/**
 *  聊天消息
 */
@interface GSPChatMessage : NSObject

/**
 *  消息文本
 */
@property (nonatomic, copy) NSString *text;

/**
 *  消息文本2，和text相互辅助支持SDK自带emoji
 */
@property (nonatomic, copy) NSString *richText;

/**
 *  发送者名字
 */
@property (nonatomic, copy) NSString *senderName;

/**
 *  发送者用户ID
 */
@property (nonatomic, assign) long long senderUserID;

/**
 *  发送者聊天ID
 */
@property (nonatomic, assign) unsigned int senderChatID;

/**
 *  收到消息的时间
 */
@property (nonatomic, assign) long long receiveTime;

/**
 *  聊天类型
 */
@property (nonatomic, assign) GSPChatType chatType;

/**
 *  接收消息的用户的UserID
 */
@property (nonatomic, assign) long long targetUserID;


/**
 *  接收消息的用户的昵称
 */
@property (nonatomic, copy) NSString *targetUserName;

/**
 *  角色
 */
@property (nonatomic, assign) NSUInteger role;

@end
