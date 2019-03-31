//
//  HomeModel.h
//  LiNiuYang
//
//  Created by Aalto on 2017/3/30.
//  Copyright © 2017年 LiNiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TransactionSubPageData : NSObject
@property (nonatomic, copy) NSString * pageno;
@property (nonatomic, copy) NSString * pagesize;
@property (nonatomic, copy) NSString * sum;
@end

@interface TransactionData : NSObject
@property (nonatomic, copy) NSString*  autoReplyContent;
@property (nonatomic, copy) NSString*  amountType;
@property (nonatomic, copy) NSString*  paymentway;
@property (nonatomic, copy) NSString*  createdtime;

@property (nonatomic, copy) NSString*  orderAllNumber;
@property (nonatomic, copy) NSString*  orderTotle;
@property (nonatomic, copy) NSString*  fixedAmount;
@property (nonatomic, copy) NSString*  ugOtcAdvertId;

@property (nonatomic, copy) NSString*  userId;

@property (nonatomic, copy) NSString*  price;
@property (nonatomic, copy) NSString*  nickName;
@property (nonatomic, copy) NSString*  successRate;
@property (nonatomic, copy) NSString* limitMinAmount;
@property (nonatomic, copy) NSString* limitMaxAmount;
@property (nonatomic, copy) NSString*  number;
@property (nonatomic, copy) NSString* prompt;
@property (nonatomic, copy) NSString*  username;
@property (nonatomic, copy) NSString*  isVip;

@property (nonatomic, copy) NSString*  balance;
@property (nonatomic, copy) NSString*  isSellerIdNumber;
@property (nonatomic, copy) NSString*  isSellerSeniorAuth;
- (NSString*) getPriorityImageName;
- (NSString*) getRateName;
- (NSString*) getPaymentwayName;
- (NSString *) getTransactionAmountTypeName;
- (BOOL) isBuyAvailable;
- (TransactionAmountType)getTransactionAmountType;
@end


@interface TransactionModel : NSObject
@property (nonatomic, strong) TransactionSubPageData* page;
@property (nonatomic, copy) NSString*  msg;
@property (nonatomic, copy) NSString*  errcode;
@property (nonatomic, copy) NSArray * advert;
@property (nonatomic, copy) NSString * price;
@property (nonatomic, copy) NSString * optionPrice;
+(NSDictionary *)objectClassInArray;
@end
