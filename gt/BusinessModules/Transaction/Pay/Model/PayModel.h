//
//  HomeModel.h
//  LiNiuYang
//
//  Created by Aalto on 2017/3/30.
//  Copyright © 2017年 LiNiu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PayData : NSObject

@property (nonatomic, copy) NSString *paymentWayId;       // 订单ID
@property (nonatomic, copy) NSString *paymentWay;
@property (nonatomic, copy) NSString *name;       // 订单ID
@property (nonatomic, copy) NSString *account;       // 订单ID
@property (nonatomic, copy) NSString *QRCode;       // 订单ID
@property (nonatomic, copy) NSString *accountOpenBank;       // 订单ID
@property (nonatomic, copy) NSString *accountOpenBranch;       // 订单ID
@property (nonatomic, copy) NSString *accountBankCard;       // 订单ID
@property (nonatomic, copy) NSString *status;       // 订单ID
//-(NSArray*)getPayways;
@end

@interface PayModel : NSObject

@property (nonatomic, copy) NSString *orderId;       // 订单ID

@property (nonatomic, copy) NSString *orderNo;       // 订单号
@property (nonatomic, copy) NSString *orderAmount;       // 订单金额
@property (nonatomic, copy) NSString *orderPrice;       // 订单单价
@property (nonatomic, copy) NSString *orderNumber;       // 订单数量
@property (nonatomic, copy) NSString *createdTime;       // 订单创建时间
@property (nonatomic, copy) NSString *prompt;       // 付款期限
@property (nonatomic, copy) NSString *paymentNumber;       // 付款参考号

@property (nonatomic, copy) NSArray *paymentWay;
@property (nonatomic, copy) NSString* sellUserId;
@property (nonatomic, copy) NSString* buyUserId;
@property (nonatomic, copy) NSString* rongyunToken;
@property (nonatomic, copy) NSString*  err_code;
@property (nonatomic, copy) NSString*  msg;

//confirm pay model
@property (nonatomic, strong) NSString *paymentTime;       //订单付款时间
@property (nonatomic, strong) NSString *exampleNum;       //

+(NSDictionary *)objectClassInArray;
-(NSArray*)getPayways;
-(NSArray*)getPaywayAppendingDicArr;
-(NSString*)getPaywayAppendingString;
@end
