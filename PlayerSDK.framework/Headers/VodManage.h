//
//  VodManage.h
//  genseeFrameWork
//
//  Created by gs_mac_fjb on 15-1-29.
//  Copyright (c) 2015年 gensee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "vodHead.h"
@class downItem;

/**
 *  VodManage是管理本地点播件（录制件）的类
 */
@interface VodManage : NSObject

/**
 *  在本地搜索某个点播件（录制件）
 *
 *  @param downLoadId 要找的点播件（录制件）的ID
 *
 *  @return 点播件（录制件）
 */
- (downItem*)findDownItem:(NSString*)downLoadId;

/**
 *  获取点播件（录制件）下载列表
 *
 *  @return 成员是: downItem实例
 */
- (NSArray *)getListDownItem;

/**
 *  获取没有下载完的点播件（录制件）下载列表
 *
 *  @return 成员是: downItem
 */
- (NSArray *)getListOfUnDownloadedItem;

/**
 *  获取所有需要下载的点播件（录制件）列表
 *
 *  @return 成员是: downItem
 */
- (NSArray*)searchAllNeedDownloadItems;


/**
 *  获取需要下载的点播件（录制件）列表 并且没完成下载的列表
 *
 *  @return 成员是: downItem
 */
- (NSArray*)searchNeedDownloadAndUnFinishedItems;

/**
 *  获取不需要下载的点播件（录制件） 用于在线观看
 *
 *  @return 成员是: downItem
 */
- (NSArray*)searchUnNeedDownloadItems;


/**
 *  获取已经下载完成的点播件（录制件）
 *
 *  @return 成员是: downItem
 */
- (NSArray*)searchFinishedItems;

/**
 *  更新所有点播件（录制件）状态
 *
 *  @param oldState 当前的状态
 *  @param newState 需要设置成的状态
 *
 *  @return 操作是否成功
 */
- (BOOL)updateAllItemState:(DOWNSTATE)oldState  toState:(DOWNSTATE) newState;

/**
 *  实例化VodManage对象
 *
 *  @return VodManage对象
 */
+ (id)shareManage;

/**
 *  删除所有点播件（录制件）
 *
 *  @return 操作结果
 */
- (BOOL)deleteAllItem;

/**
 *  更新点播件（录制件）
 *
 *  @param item 点播件（录制件）
 *
 *  @return 操作结果
 */
- (BOOL)updateItem:(downItem*)item;

/**
 *  删除某个点播件（录制件）
 *
 *  @param DownloadId 要删除的点播件（录制件）的ID
 *
 *  @return 操作是否成功
 */
- (BOOL)deleteItem:(NSString*)DownloadId;

@end
