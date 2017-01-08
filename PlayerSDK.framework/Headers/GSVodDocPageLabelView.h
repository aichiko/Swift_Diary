//
//  GSVodDocPageLabelView.h
//  RtSDK
//
//  Created by jiangcj on 15/9/2.
//  Copyright (c) 2015年 Geensee. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GSVodDocPage.h"



@interface GSVodDocPageLabelView : UIView


@property (strong, nonatomic)UIImage *cacheImage;

@property (assign, nonatomic)CGFloat scale;

@property (strong, nonatomic)GSVodAnnoBase *anno;

@property (assign, nonatomic)CGFloat offX;

@property (assign, nonatomic)CGFloat offY;

@property (strong, nonatomic)GSVodDocPage *docPage;



@property (assign, nonatomic)BOOL needDrawFreePenEx;
@property (assign, nonatomic)BOOL isDrawingSingleAnno;


@property (nonatomic, assign)CGFloat scaleX;

@property (nonatomic, assign)CGFloat scaleY;



- (void)drawPage:(GSVodDocPage *)page;

- (void)drawSomeSpecialAnnos:(GSVodAnnoBase*)anno;



@end
