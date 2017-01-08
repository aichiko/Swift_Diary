//
//  GSPInvestigationView.h
//  PlayerSDK
//
//  Created by Gaojin Hsu on 6/10/15.
//  Copyright (c) 2015 Geensee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GSPPlayerManager.h"


@class GSPPlayerManager;

/**
 直播中封装了问卷调查的视图
 */
@interface GSPInvestigationView : UIView

/**
 *  初始化GSPInvestigationView
 *
 *  @param frame 设置GSPInvestigationView的宽高，坐标等信息
 *
 *  @return GSPInvestigationView实例
 */
- (id)initWithFrame:(CGRect)frame;

/**
 *  是否有需要强制回答的投票未完成
 */
@property (nonatomic, assign, readonly) BOOL hasForceInvestigation;










/**********************************************************************************************/
/**********************************************************************************************/
// 以下接口请勿调用

- (void)receiveVote:(NSArray*)array;

@property (nonatomic, weak) GSPPlayerManager *playerManager;



@end
