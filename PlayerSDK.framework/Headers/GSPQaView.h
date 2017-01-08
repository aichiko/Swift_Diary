//
//  GSPQaView.h
//  PlayerSDK
//
//  Created by Gaojin Hsu on 6/9/15.
//  Copyright (c) 2015 Geensee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GSPPlayerManager.h"
#import "GSPChatInputToolView.h"

/**
 *  问答数据
 */
@interface GSPQaData : NSObject

/**
 *  问题ID
 */
@property (nonatomic, strong)NSString *questionID;

/**
 *  答案ID
 */
@property (nonatomic, strong)NSString *answerID;

/**
 * 问题或者答案的内容
 */
@property (nonatomic, strong)NSString *content;

/**
 *  问题发送者的名字
 */
@property (nonatomic, strong)NSString *ownerName;

/**
 *  收到问题的时间，微秒级时间戳。1毫秒 ＝ 1000微秒
 */
@property (nonatomic, assign)long long time;

/**
 *  表示这个数据是问题还是答案
 */
@property (nonatomic, assign) BOOL isQuestion;

/**
 *  问题发送者的ID
 */
@property (nonatomic, assign) long long ownnerID;

/**
 *  表示是否撤销发布这个问题
 */
@property (nonatomic, assign) BOOL isCanceled;


@property (nonatomic, assign) long long receiveFlag;

@end

@class GSPChatInputToolView;
@class GSPPlayerManager;


/**
 直播中管理问答的视图
 */
@interface GSPQaView : UIView

/**
 *  初始化GSPQaView
 *
 *  @param frame 设置GSPQaView的宽高，坐标等信息
 *
 *  @return GSPQaView实例
 */
- (id)initWithFrame:(CGRect)frame;












/**********************************************************************************************/
/**********************************************************************************************/
// 以下接口请勿调用
- (void)receiveQuestion:(NSArray*)qaArray;

- (BOOL)sendQuestion:(NSString *)question;

@property (nonatomic, assign) BOOL isQaEnabled;

@property (nonatomic, weak)GSPPlayerManager *playerManager;

@property (nonatomic, weak)GSPChatInputToolView *inputToolView;



-(void)clearAllQaData;



@end
