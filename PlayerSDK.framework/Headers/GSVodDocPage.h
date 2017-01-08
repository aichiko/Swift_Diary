//
//  GSVodDocPage.h
//  RtSDK
//
//  Created by Gaojin Hsu on 3/19/15.
//  Copyright (c) 2015 Geensee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *   标注的类型
 */
typedef NS_ENUM(NSInteger, GSVodDocumentAnnoType){
    /**
     *  空标注
     */
    GSVodDocumentAnnoTypeNull = 0x00,
    
    /**
     *  点标注
     */
    GSVodDocumentAnnoTypePoint,
    
    /**
     *  自由笔标注
     */
    GSVodDocumentAnnoTypeFreePen,
    
    /**
     *  橡皮擦
     */
    GSVodDocumentAnnoTypeCleaner,
    
    /**
     *  文字标注
     */
    GSVodDocumentAnnoTypeText,
    
    /**
     *  圆标注
     */
    GSVodDocumentAnnoTypeCircle,
    
    /**
     *  矩形标注
     */
    GSVodDocumentAnnoTypeRect,
    
    /**
     *  直线标注
     */
    GSVodDocumentAnnoTypeLine,
    
    /**
     *  加强版直线标注
     */
    GSVodDocumentAnnoTypeLineEx,
    
    /**
     *  加强版点标注
     */
    GSVodDocumentAnnoTypePointEx,
    
    /**
     *  加强版自由笔标注
     */
    GSVodDocumentAnnoTypeFreePenEx,
};




/**
 *   文档的显示的类型
 */
typedef NS_ENUM(NSInteger, GSVodDocShowType){
    /**
     *  全屏
     */
    VodScaleToFill = 0x01,
    /**
     *  比列适配
     */
    VodScaleAspectFit,
    
    /**
     *  ScaleAspectFill
     */
    VodScaleAspectFill,
    
};





/**
 *  文档类，封装了文档的数据，一份文档可以包含若干文档页
 */
@interface GSVodDocument : NSObject

/**
 *  文档ID
 */
@property (assign, nonatomic)unsigned docID;

/**
 *  保存所有文档页对象的数组
 */
@property (strong, nonatomic)NSMutableDictionary *pages;


/**
 *  当前显示的文档页索引
 */
@property (assign, nonatomic)int currentPageIndex;

/**
 *  布尔值表示该文档是否存放在服务器上， YES表示是
 */
@property (assign, nonatomic)BOOL savedOnServer;

/**
 *  文档名称
 */
@property (assign, nonatomic)NSString *docName;


/**
 *  文档所属的用户ID
 */
@property (assign, nonatomic)long long ownerID;

@end


/**
 *  文档页类，封装了文档页数据
 */
@interface GSVodDocPage : NSObject


/**
 *  文档页ID
 */
@property (assign, nonatomic)unsigned pageID;


/**
 *  文档页数据
 */
@property (strong, nonatomic)NSData *pageData;


/**
 *  文档页的宽
 */
@property (assign, nonatomic)short pageWidth;


/**
 *  文档页的高
 */
@property (assign, nonatomic)short pageHeight;


/**
 *  该文档页上的所有标注数据
 */
@property (strong, nonatomic)NSMutableDictionary *annos;


@end


/**
 *  文档标注的基类
 */
@interface GSVodAnnoBase : NSObject

/**
 *  标注类型
 *  @see GSVodDocumentAnnoType
 */
@property (assign, nonatomic)GSVodDocumentAnnoType type;


/**
 *  标注ID
 */
@property (assign, nonatomic)long long annoID;


/**
 *  标注所在文档页的ID
 */
@property (assign, nonatomic)unsigned pageID;


/**
 *  标注所在文档页所在的文档的ID
 */
@property (assign, nonatomic)unsigned docID;

@end


/**
 *  圆形标注
 */
@interface GSVodAnnoCircle : GSVodAnnoBase

/**
 *  线的粗细尺寸
 */
@property (assign, nonatomic)Byte lineSize;

/**
 *  线的颜色
 */
@property (strong, nonatomic)UIColor *lineColor;


/**
 *  圆标注所在的矩形区域
 */
@property (assign, nonatomic)CGRect rect;

@end


/**
 *  自由笔标注
 */
@interface GSVodAnnoFreePen : GSVodAnnoBase


/**
 *  自由笔所有的点数据
 */
@property (strong, nonatomic)NSMutableArray *points;


/**
 *  线的粗细尺寸
 */
@property (assign, nonatomic)Byte lineSize;


/**
 *  线的颜色
 */
@property (strong, nonatomic)UIColor *lineColor;

@end


/**
 *  加强版自由笔标注
 */
@interface GSVodAnnoFreePenEx : GSVodAnnoFreePen


/**
 *   表示当前的自由笔对象是开始点，过程中的点还是结束的点
 */
@property (assign, nonatomic) Byte stepType;

@end


/**
 *  直线标注
 */
@interface GSVodAnnoLine : GSVodAnnoBase

/**
 *  线的粗细尺寸
 */
@property (assign, nonatomic)Byte lineSize;


/**
 *  线的颜色
 */
@property (strong, nonatomic)UIColor *lineColor;


/**
 *  起始点
 */
@property (assign, nonatomic)CGPoint startPoint;


/**
 *  结束点
 */
@property (assign, nonatomic)CGPoint endPoint;

@end


/**
 *  加强版直线标注
 */
@interface GSVodAnnoLineEx : GSVodAnnoLine

/**
 *  线的类型，箭头线，虚线和普通线
 */
@property (assign, nonatomic)Byte lineType;

@end

/**
 *  点标注
 */
@interface GSVodAnnoPoint : GSVodAnnoBase

/**
 *  点的坐标
 */
@property (assign, nonatomic)CGPoint point;

@end


/**
 *  加强版点标注
 */
@interface GSVodAnnoPointEx : GSVodAnnoPoint

/**
 *  点的类型，十字和箭头
 */
@property (assign, nonatomic)Byte pointType;

@end


/**
 *  矩形标注
 */
@interface GSVodAnnoRect : GSVodAnnoBase

/**
 *  线的粗心尺寸
 */
@property (assign, nonatomic)Byte lineSize;


/**
 *  线的颜色
 */
@property (strong, nonatomic)UIColor *lineColor;


/**
 *  矩形信息
 */
@property (assign, nonatomic)CGRect rect;

@end


/**
 *  文字标注
 */
@interface GSVodAnnoText : GSVodAnnoBase

/**
 *  文字颜色
 */
@property (strong, nonatomic)UIColor *textColor;


/**
 *  文字的字体大小
 */
@property (assign, nonatomic)Byte fontSize;


/**
 *  文本内容
 */
@property (strong, nonatomic)NSString *text;


/**
 *  文字位置起始点
 */
@property (assign, nonatomic)CGPoint point;

@end


/**
 *  橡皮擦标注
 */
@interface GSVodAnnoCleaner : GSVodAnnoBase

/**
 *  删除的标注ID
 */
@property (assign, nonatomic)long long removedAnnoID;

@end
