//
//  GSInvestigation.h
//  RtSDK
//
//  Created by Gaojin Hsu on 4/5/15.
//  Copyright (c) 2015 Geensee. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *   问卷调查中问题的题型
 */
typedef NS_ENUM(NSUInteger, GSPInvestigationQuestionType) {
    
    /**
     *   单选题
     */
    GSPInvestigationQuestionTypeSingleChoice,
    
    /**
     *   多选题
     */
    GSPInvestigationQuestionTypeMultiChoice,
    
    /**
     *  问答题
     */
    GSPInvestigationQuestionTypeEssay,
};

/**
 *   问卷调查选择题选项数据
 */
@interface GSPInvestigationOption : NSObject


/**
 *   答案ID
 */
@property (nonatomic, strong)NSString *ID;


/**
 *   答案内容
 */
@property (nonatomic, strong)NSString *content;


/**
 *   此答案是否为正确选项
 */
@property (nonatomic, assign)BOOL isCorrectItem;


/**
 *   此选项是否被选中
 */
@property (nonatomic, assign)BOOL isSelected;


/**
 *   选择这个选项的总人数
 */
@property (nonatomic, assign)NSUInteger totalSumOfUsers;


/**
 *   所有选了这个选项的用户
 */
@property (nonatomic, assign)NSArray *users;

@end


/**
 *  问卷调查中的问题数据
 */
@interface GSPInvestigationQuestion : NSObject


/**
 *   问题ID
 */
@property (nonatomic, strong)NSString *ID;


/**
 *   问题内容
 */
@property (nonatomic, strong)NSString *content;


/**
 *   问题答案，在题型为问答题时，该项为答案；如果是选择题，则忽略该项
 */
@property (nonatomic, strong)NSString *essayAnswer;


/**
 *   问题类型
 */
@property (nonatomic, assign)GSPInvestigationQuestionType questionType;


/**
 *   选项，问题类型为选择题时才有意义
 */
@property (nonatomic, strong)NSArray *options;


/**
 *   参与这个问题的总人数
 */
@property (nonatomic, assign)NSUInteger totalSumOfUsers;


/**
 *   参与作答的所有用户
 */
@property (nonatomic, strong)NSArray *users;


/**
 *   此题的分值
 */
@property (nonatomic, assign)NSUInteger score;

@end


/**
 *  一份问卷调查数据，通常一份问卷调查包含若干问题
 */
@interface GSPInvestigation : NSObject

@property (nonatomic, strong)NSString *siteID;

@property (nonatomic, strong)NSString *configID;

@property (nonatomic, strong)NSString *userID;

@property (nonatomic, strong)NSString *live;

@property (nonatomic, strong)NSString *ver;

/**
 *  问卷调查ID
 */
@property (nonatomic, strong)NSString *ID;


/**
 *  发起问卷调查者的用户ID
 */
@property (nonatomic, assign)long long ownerID;


/**
 *  问卷调查主题
 */
@property (nonatomic, strong)NSString *theme;


/**
 *  该调查是否要求强制参与
 */
@property (nonatomic, assign)BOOL isForce;


/**
 *  调查是否发布
 */
@property (nonatomic, assign)BOOL isPublished;


/**
 *  此调查结果是否已经公布
 */
@property (nonatomic, assign)BOOL isResultPublished;


/**
 *  调查是否截止
 */
@property (nonatomic, assign)BOOL hasTerminated;


/**
 *  参与过的用户
 */
@property (nonatomic, strong)NSArray *users;


/**
 *   问卷中的问题
 */
@property (nonatomic, strong)NSArray *questions;

@end


/**
 *  封装自己的问卷调查答案数据
 */
@interface GSPInvestigationMyAnswer : NSObject

/**
 *  问题ID
 */
@property (nonatomic, strong)NSString *questionID;

/**
 *  选择的选项ID
 */
@property (nonatomic, strong)NSString *optionID;


/**
 *  问答题答案
 */
@property (nonatomic, strong)NSString *essayAnswer;

@end
