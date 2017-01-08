//
//  vodHead.h
//  genseeFrameWork
//
//  Created by gs_mac_fjb on 15-2-2.
//  Copyright (c) 2015年 gensee. All rights reserved.
//

#ifndef genseeFrameWork_vodHead_h
#define genseeFrameWork_vodHead_h
typedef long long			LONGLONG;
typedef enum
{
    RESULT_ROOM_NUMBER_UNEXIST = 0,            //点播间不存在
    RESULT_SUCCESS = 1,
    RESULT_NOT_EXSITE = 2,                     //该点播的编号的点播不存在
    RESULT_FAIL_WEBCAST = 3,  	               //点播id不正确
    RESULT_FAIL_TOKEN = 4,    				   //口令错误
    RESULT_FAIL_LOGIN = 5,    			 	   //用户名或密码错误
    RESULT_ISONLY_WEB = 7, 				       //只支持web
    RESULT_ROOM_UNEABLE = 8,			       //点播间不可用
    RESULT_OWNER_ERROR = 9,				       //内部问题
    RESULT_INVALID_ADDRESS = 10, 		 	   //无效地址
    RESULT_ROOM_OVERDUE = 11,                  //点播过期
    RESULT_AUTHORIZATION_NOT_ENOUGH = 12,      //授权不够
    RESULT_INIT_DOWNLOAD_FAILED = 13,          //下载初始化失败
    RESULT_FAILED_NET_REQUIRED,                //网络请求失败
    RESULT_UNSURPORT_MOBILE = 18,              // 不支持移动设备
    
    
}RESULT_TYPE;

typedef enum
{
    REDAY,
    BEGIN,
    PAUSE,
    FINISH,
    FAILED
}DOWNSTATE;

typedef enum
{
    ERROR_NET,
}VodDownLoadStatus;

#endif
