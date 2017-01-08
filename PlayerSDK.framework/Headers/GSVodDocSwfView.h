//
//  GSDocSwfView.h
//  PlayerSDK
//
//  Created by jiangcj on 15/9/28.
//  Copyright © 2015年 Geensee. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GSVodDocPageLabelView.h"


@protocol GSVodDocSwfViewDelegate <NSObject>

@optional

- (void)docVodOpenFinishSuccess:(GSVodDocPage*)page  ;



@end


@interface GSVodDocSwfView : UIView


- (void)drawPage:(unsigned int)dwTimeStamp
            data:(const unsigned char*)data
           dwLen:(unsigned int )dwLen
         dwPageW:(unsigned int )dwPageW
         dwPageH:(unsigned int )dwPageH
   strAnimations:(NSString*)strAnimations;




-(void)vodGoToAnimationStep:(int)step;



- (void)vodDrawAnnos:(NSArray*)annos;





-(void)setGlkBackColor:(int)red green:(int)green blue:(int)blue;





@property (strong, nonatomic)GSVodDocPageLabelView* annoLabelView;  //标注层


/**
 *  设置文档文档的显示类型
 */
@property(assign,nonatomic)GSVodDocShowType  docModeType; //文档的显示类型


-(void)clearVodLastPageAndAnno;


//文档打开代理
@property (nonatomic, weak)id<GSVodDocSwfViewDelegate> vodDelegate;


@end
