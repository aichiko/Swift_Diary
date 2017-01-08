//
//  GSDiagnosisInfo.h
//  RtSDK
//
//  Created by jiangcj on 15/7/8.
//  Copyright (c) 2015年 Geensee. All rights reserved.
//

#import <Foundation/Foundation.h>


#define IsException @"isException"


typedef NS_ENUM(NSInteger, GSPDiagnosisType) {
    
    
    GSPDiagnosisUploadSuccess = 0,
    
    
    GSPDiagnosisUploadFailure = 1,
    
    
    GSPDiagnosisNetError = 2,
    
};



@protocol GSPDiagnosisInfoDelegate <NSObject>

@optional
- (void)upLoadResult:(GSPDiagnosisType)type;

@end





typedef void (^upLoadResultBlock)(BOOL isSuccess);

typedef void (^upLoadResultWithErrorDescriptionBlock)(BOOL isSuccess,NSString* errorDescription);








@interface GSPDiagnosisInfo : NSObject<NSURLSessionDelegate>


@property (nonatomic, weak)id<GSPDiagnosisInfoDelegate> DiagnosisInfoDelegate;



@property(nonatomic,copy) NSString* userName;
@property(nonatomic,copy) NSString* userId;
@property(nonatomic,copy) NSString* userRole;


@property(nonatomic,copy) NSString* confId;
@property(nonatomic,copy) NSString* confName;
@property(nonatomic,copy) NSString* confSiteId;
@property(nonatomic,copy) NSString* confSiteName;
@property(nonatomic,copy) NSString* currentDate;


@property(nonatomic, strong)  NSString *uploadfile;
@property(nonatomic,strong) NSString* uploadUrl;



@property(nonatomic,strong) NSString* appLogFilePath;





//@property (nonatomic, copy)upLoadResultBlock upLoadResult;

@property (nonatomic, copy)upLoadResultWithErrorDescriptionBlock upLoadResult;



+ (GSPDiagnosisInfo*)shareInstance;

- (void)uploadDiagnosisInfo;

/**
 *  报告诊断信息
 */
-(void)ReportDiagonse;





/**
 加入直播前可以用这个上传日志
 */
- (void)ReportDiagonseEx;






/*
 需要先调用这个方法，将日记重定向到日记文件
 **/
-(void)redirectNSlogToDocumentFolder;


//服务器主动获取日记
-(void)activeGetLog;




@end
