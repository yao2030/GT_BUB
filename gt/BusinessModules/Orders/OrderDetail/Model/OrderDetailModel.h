//
//  HomeModel.h
//  LiNiuYang
//
//  Created by Aalto on 2017/3/30.
//  Copyright © 2017年 . All rights reserved.
//

#import <Foundation/Foundation.h>
@interface OrderDetailData : NSObject
@property (nonatomic, copy) NSString * restTime;
@property (nonatomic, copy) NSString *paymentWayId;       // 订单ID
@property (nonatomic, copy) NSString *paymentWay;       // 订单ID
@property (nonatomic, copy) NSString *name;       // 订单ID
@property (nonatomic, copy) NSString *account;       // 订单ID
@property (nonatomic, copy) NSString *QRCode;       // 订单ID
@property (nonatomic, copy) NSString *accountOpenBank;       // 订单ID
@property (nonatomic, copy) NSString *accountOpenBranch;       // 订单ID
@property (nonatomic, copy) NSString *accountBankCard;       // 订单ID
@property (nonatomic, copy) NSString *status; // 收款方式状态1-启用 2-停用

@end

@interface OrderDetailModel : NSObject

@property (nonatomic, copy) NSString*  errcode;
@property (nonatomic, copy) NSString*  msg;

@property (nonatomic, copy) NSString *brokerage;       //手续费
@property (nonatomic, copy) NSString *status;       //订单状态
@property (nonatomic, copy) NSString *orderType;
@property (nonatomic, copy) NSString *createdTime;       //订单创建时间
@property (nonatomic, copy) NSString *paymentNumber;       //订单创建时间
@property (nonatomic, copy) NSString *prompt;       //付款期限
@property (nonatomic, copy) NSString *buyUserId;       //买家ID
@property (nonatomic, copy) NSString *orderNo;       //订单号
@property (nonatomic, copy) NSString *price;       //单价
@property (nonatomic, copy) NSString *number;       //成交数量
@property (nonatomic, copy) NSString *isEvaluation;       //订单是否评价
@property (nonatomic, copy) NSString *orderAmount;
@property (nonatomic, copy) NSString *txHash;
@property (nonatomic, copy) NSString *orderSellIsVip;
@property (nonatomic, copy) NSString *sellerName;
@property (nonatomic, copy) NSString *buyerName;
@property (nonatomic, copy) NSString * restTime;
@property (nonatomic, copy) NSString *appealId;
@property (nonatomic, copy) NSString *sellUserId;       //卖家ID
@property (nonatomic, copy) NSString *advertId;       //广告ID
@property (nonatomic, copy) NSString *otcOrderId;       //订单ID



@property (nonatomic, copy) NSString *modifyTime;       //订单修改时间
@property (nonatomic, copy) NSString *paymentTime;       //订单付款时间(买)
@property (nonatomic, copy) NSString *finishTime;       //订单完成时间
@property (nonatomic, copy) NSString *confirmTime;       //订单确定时间(卖)
@property (nonatomic, copy) NSString *closeTime;       //订单关闭时间
@property (nonatomic, copy) NSString *paymentWayString; //orderlist distribute
@property (nonatomic, copy) NSArray *paymentWay;       //detail订单关闭时间
@property (nonatomic, copy) NSString*  isSellerIdNumber;
@property (nonatomic, copy) NSString*  isSellerSeniorAuth;
- (NSString*) getPriorityImageName;

+(NSDictionary *)objectClassInArray;
- (NSString *) getTransactionOrderTypeFooterSubTitle;

- (NSString *) getTransactionOrderTypeImageName;

- (NSString *) getTransactionOrderTypeSubTitle;

- (NSString *) getTransactionOrderTypeTitle;

- (OrderType) getTransactionOrderType;

- (NSString *) getOccurOrderTypeTitle;
- (OccurOrderType) getOccurOrderType;

- (UserType) getUserType;

-(NSArray*)getPaywayAppendingDicArr;
-(NSString*)getPaywayAppendingString;

-(NSArray*)getPayways;
@end
