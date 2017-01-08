//
//  GSVodDocView.h
//  VodSDK
//
//  Created by jiangcj on 16/7/6.
//  Copyright © 2016年 gensee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GSVodDocSwfView.h"


@protocol GSVodDocViewDelegate <NSObject>

@optional

- (void)docVodViewOpenFinishSuccess:(GSVodDocPage*)page ;

@end


@interface GSVodDocView : UIScrollView


/**
 *  设置文档是否支持pinch手势，YES表示支持
 */
@property (assign, nonatomic) BOOL zoomEnabled;



//文档打开代理
@property (nonatomic, weak)id<GSVodDocViewDelegate> vodDocDelegate;



/**
 *  初始化GSVodPDocView
 *
 *  @param frame 设置GSPDocView的宽高，坐标等信息
 *
 *  @return GSVodPDocView实例
 */
- (id)initWithFrame:(CGRect)frame;



@property (strong, nonatomic)GSVodDocSwfView *vodDocSwfView;




- (void)drawPage:(unsigned int)dwTimeStamp
            data:(const unsigned char*)data
           dwLen:(unsigned int )dwLen
         dwPageW:(unsigned int )dwPageW
         dwPageH:(unsigned int )dwPageH
   strAnimations:(NSString*)strAnimations;

-(void)vodGoToAnimationStep:(int)step;

- (void)vodDrawAnnos:(NSArray*)annos;

-(void)setGlkBackgroundColor:(int)red green:(int)green blue:(int)blue;




/**
 *  设置文档文档的显示类型
 */
@property(assign,nonatomic)GSVodDocShowType  gSDocModeType; //文档的显示类型



@end
