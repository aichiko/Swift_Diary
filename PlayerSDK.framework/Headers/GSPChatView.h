//
//  GSPChatView.h
//  PlayerSDK
//
//  Created by Gaojin Hsu on 6/9/15.
//  Copyright (c) 2015 Geensee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GSPUserInfo.h"
#import "GSPChatMessage.h"
#import "GSPChatInputToolView.h"


@class GSPPlayerManager;
@class GSPChatInputToolView;

/**
 * 直播中管理聊天的视图
 */
@interface GSPChatView : UIView

/**
 *  初始化GSPChatView
 *
 *  @param frame 设置GSPChatView的宽高，坐标等信息
 *
 *  @return GSPChatView 实例
 */
- (id)initWithFrame:(CGRect)frame;

/**
 *  设置聊天发送对象的用户信息，如果为nil，将发送公共聊天
 */
@property (nonatomic, strong)GSPUserInfo *chatTargetUser;





















/**********************************************************************************************/
/**********************************************************************************************/
// 以下接口请勿调用

- (void)receiveMessage:(GSPChatMessage*)chatMessage;

- (BOOL)sendMessage:(NSString*)content;

@property (nonatomic, assign) BOOL isChatEnabled;

@property (nonatomic, weak)GSPChatInputToolView *inputToolView;

@property (nonatomic, weak)GSPPlayerManager *playerManager;

@end
