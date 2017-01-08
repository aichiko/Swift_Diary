//
//  GSPDocView.h
//  PlayerSDK
//
//  Created by Gaojin Hsu on 6/9/15.
//  Copyright (c) 2015 Geensee. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GSPDocPage.h"



@protocol GSPDocViewDelegate <NSObject>

@optional

- (void)docViewPOpenFinishSuccess:(GSPDocPage*)page   docID:(unsigned)docID;

@end


/**
 *  直播中管理文档的视图
 */
@interface GSPDocView : UIScrollView

/**
 *  设置文档是否支持pinch手势，YES表示支持
 */
@property (assign, nonatomic) BOOL zoomEnabled;


/**
 *  初始化GSPDocView
 *
 *  @param frame 设置GSPDocView的宽高，坐标等信息
 *
 *  @return GSPDocView实例
 */
- (id)initWithFrame:(CGRect)frame;




//文档代理
@property (nonatomic, weak)id<GSPDocViewDelegate> pdocDelegate;


/**
 *  设置文档文档的显示类型
 */
@property(assign,nonatomic)GSPDocShowType  gSDocModeType; //文档的显示类型




-(void)setGlkBackgroundColor:(int)red green:(int)green blue:(int)blue;









/**********************************************************************************************/
/**********************************************************************************************/
// 以下接口请勿调用

- (void)drawPage:(NSData*)data with:(unsigned)width height:(unsigned)height;
- (void)drawPage:(NSData*)data with:(unsigned)width height:(unsigned)height strFullName:(NSString*)strFullName strSlideInfo:(NSString*)strSlideInfo;

- (void)drawAnno:(NSString*)xmlString;

- (void)switchDoc:(BOOL)isEnd;

-(void)goToAnimationStep:(int)step;






-(void)clearPageAndAnno;

@end
