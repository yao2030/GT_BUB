//
//  HomeModel.m
//  LiNiuYang
//
//  Created by Aalto on 2017/3/30.
//  Copyright © 2017年 . All rights reserved.
//

#import "OrderDetailModel.h"
#import "LoginModel.h"
#define kUserTypeBuyer @"1"
#define kUserTypeSeller @"2"


#define kOccurOrderTypeBuy @"1"
#define kOccurOrderTypeSell @"2"

#define kOrderTypeNotYetPay @"1"
#define kOrderTypeHadPaid @"2"
#define kOrderTypeFinished @"3"
#define kOrderTypeCancel @"4"
#define kOrderTypeClosed @"5"
#define kOrderTypeAppealing @"6"
@implementation OrderDetailData
@end

@implementation OrderDetailModel
- (NSString*) getPriorityImageName{
    NSString * titleTxt = @"";
    if (![self.isSellerIdNumber isEqualToString:@"3"]){
        titleTxt = @"";
    }else{
        if ([self.isSellerSeniorAuth isEqualToString:@"1"]) {
            titleTxt = @"isSeniorAuth_icon";
        }else if (![self.isSellerSeniorAuth isEqualToString:@"1"]) {
            titleTxt = @"isRealNameAuth_icon";
        }
    }
    return titleTxt;
}
- (NSString *) getTransactionOrderTypeFooterSubTitle
{
    NSString* title = @"";
    OrderType type = [self getTransactionOrderType];
    
    switch (type) {
        case BuyerOrderTypeNotYetPay:
            title = [NSString stringWithFormat:@"%@ 分钟未确认付款，订单将关闭",self.prompt];
            break;
        case BuyerOrderTypeHadPaidWaitDistribute:
            title =[NSString stringWithFormat:@"%@ 分钟未确认放行，订单将关闭",self.prompt];
            break;
        case BuyerOrderTypeHadPaidNotDistribute:
            title = [NSString stringWithFormat:@"对方未在%@分钟内放行，请咨询卖家，如对方未及时回应，您可提起申诉",self.prompt];
            break;
        case BuyerOrderTypeFinished:
            title = self.txHash;
            break;
        case BuyerOrderTypeCancel:
            title = @"";
            break;
        case BuyerOrderTypeClosed:
            title = [NSString stringWithFormat:@"对方未在%@分钟内放行，订单已关闭",self.prompt];
            break;
        case BuyerOrderTypeAppealing:
            title = @"";
            break;
            
        case SellerOrderTypeNotYetPay:
            title =  [NSString stringWithFormat:@"%@ 分钟未确认付款，订单将关闭",self.prompt];
            break;
        case SellerOrderTypeWaitDistribute:
            title = @"对方已确认付款";
            break;
            
        case SellerOrderTypeFinished:
            title = self.txHash;
            break;
        case SellerOrderTypeCancel:
            title = @"用户手动取消订单";
            break;
        case SellerOrderTypeTimeOut:
            title = [NSString stringWithFormat:@"对方未在%@分钟内支付，订单已关闭",self.prompt];
            break;
        case SellerOrderTypeAppealing:
            title = @"";
            break;
        default:
            break;
    }
    return title;
}

- (NSString *) getTransactionOrderTypeImageName
{
    NSString* imageName = @"";
    OrderType type = [self getTransactionOrderType];
    
    switch (type) {
        case BuyerOrderTypeNotYetPay:
            imageName = @"iconUnfinish";
            break;
        case BuyerOrderTypeHadPaidWaitDistribute:
            imageName = @"iconSucc";
            break;
        case BuyerOrderTypeHadPaidNotDistribute:
            imageName = @"iconClosed";
            break;
        case BuyerOrderTypeFinished:
            imageName = @"iconSucc";
            break;
        case BuyerOrderTypeCancel:
            imageName = @"iconConceled";
            break;
        case BuyerOrderTypeClosed:
            imageName = @"iconClosed";
            break;
        case BuyerOrderTypeAppealing:
            imageName = @"iconAppeal";
            break;
            
        case SellerOrderTypeNotYetPay:
            imageName = @"iconAppeal";
            break;
        case SellerOrderTypeWaitDistribute:
            imageName = @"iconSucc";
            break;
            
        case SellerOrderTypeFinished:
            imageName = @"iconSucc";
            break;
        case SellerOrderTypeCancel:
            imageName = @"iconClosed";
            break;
            
        case SellerOrderTypeTimeOut:
            imageName = @"iconClosed";
            break;
        case SellerOrderTypeAppealing:
            imageName = @"iconAppeal";
            break;
        default:
            break;
    }
    
    return imageName;
}

- (NSString *) getTransactionOrderTypeSubTitle
{
    NSString* title = @"";
    OrderType type = [self getTransactionOrderType];
    
    switch (type) {
        case SellerOrderTypeWaitDistribute:
            title = @"请确认收到款项后再放行";
            break;
        default:
            title = @"";
            break;
    }
    
    return title;
}

- (NSString *) getTransactionOrderTypeTitle
{
    NSString* title = @"";
    OrderType type = [self getTransactionOrderType];
    
    switch (type) {
        case BuyerOrderTypeNotYetPay:
            title = @"未付款";
            break;
        case BuyerOrderTypeHadPaidWaitDistribute:
            title = @"已付款，等待对方放行";
            break;
        case BuyerOrderTypeHadPaidNotDistribute:
            title = @"已付款，对方未放行";
            break;
        case BuyerOrderTypeFinished:
            title = @"已完成";
            break;
        case BuyerOrderTypeCancel:
            title = @"已取消";
            break;
        case BuyerOrderTypeClosed:
            title = @"已关闭";
            break;
        case BuyerOrderTypeAppealing:
            title = @"申诉中";
            break;
            
        case SellerOrderTypeNotYetPay:
            title = @"等待对方付款";
            break;
        case SellerOrderTypeWaitDistribute:
            title = @"对方已确认付款";
            break;
            
        case SellerOrderTypeFinished:
            title = @"已完成";
            break;
        case SellerOrderTypeCancel:
            title = @"已取消";
            break;
            
        case SellerOrderTypeTimeOut:
            title = @"订单已超时";
            break;
        case SellerOrderTypeAppealing:
            title = @"申诉中";
            break;
        default:
            break;
    }
    
    return title;
}

- (OrderType) getTransactionOrderType
{
    OrderType type = BuyerOrderTypeAllPay;
    NSString *tag = self.status;
    NSInteger times = [self.restTime integerValue];
    UserType userType = [self getUserType];
    
    if (userType == UserTypeBuyer) {
        if ([tag isEqualToString:kOrderTypeNotYetPay])
        {
            type = BuyerOrderTypeNotYetPay;
        }
        else if ([tag isEqualToString:kOrderTypeHadPaid]){
            type = times==0?
    BuyerOrderTypeHadPaidNotDistribute:BuyerOrderTypeHadPaidWaitDistribute;
        }
        else if ([tag isEqualToString:kOrderTypeFinished]){
            type = BuyerOrderTypeFinished;
        }
        
        else if ([tag isEqualToString:kOrderTypeCancel]){
            type = BuyerOrderTypeCancel;
        }
        else if ([tag isEqualToString:kOrderTypeClosed]){
            type = BuyerOrderTypeClosed;
        }
        
        
        else if ([tag isEqualToString:kOrderTypeAppealing]){
            type = BuyerOrderTypeAppealing;
        }
    }
    else if (userType == UserTypeSeller) {
        if ([tag isEqualToString:kOrderTypeNotYetPay])
        {
            type = SellerOrderTypeNotYetPay;
        }
        else if ([tag isEqualToString:kOrderTypeHadPaid]){
            type = SellerOrderTypeWaitDistribute;
        }
        else if ([tag isEqualToString:kOrderTypeFinished]){
            type = SellerOrderTypeFinished;
        }
        else if ([tag isEqualToString:kOrderTypeCancel]){
            type = SellerOrderTypeCancel;
        }
        
        else if ([tag isEqualToString:kOrderTypeClosed]){
            type = SellerOrderTypeTimeOut;
        }
        
        else if ([tag isEqualToString:kOrderTypeAppealing]){
            type = SellerOrderTypeAppealing;
        }
    }
    return type;
}

- (NSString *) getOccurOrderTypeTitle
{
    NSString* title = @"";
    OccurOrderType type = [self getOccurOrderType];
    
    switch (type) {
        case OccurOrderTypeBuy:
            title = @"购买BUB";
            break;
        case OccurOrderTypeSell:
            title = @"出售BUB";
            break;
        default:
            break;
    }
    return title;
}

- (OccurOrderType) getOccurOrderType{
    
    OccurOrderType type = OccurOrderTypeNone;
    NSString *tag = self.orderType;
    
    if ([tag isEqualToString:kOccurOrderTypeBuy])
    {
        type = OccurOrderTypeBuy;
    }
    //    else if ([tag isEqualToString:kTransactionAmountTypeFixed])
    else
    {
        type = OccurOrderTypeSell;
    }
    return type;
}

- (UserType) getUserType{
    UserType type = UserTypeNone;
    LoginModel* userInfoModel = [LoginModel mj_objectWithKeyValues:GetUserDefaultWithKey(kUserInfo)];
    NSString *tag = userInfoModel.userinfo.userType;

    if ([tag isEqualToString:kUserTypeBuyer])
    {
        type = UserTypeBuyer;
    }
    //    else if ([tag isEqualToString:kTransactionAmountTypeFixed])
    else
    {
        type = UserTypeSeller;
    }
    return type;
}

-(NSArray*)getPaywayAppendingDicArr{
    NSMutableArray *pays = [NSMutableArray arrayWithCapacity:3];
    
    for (OrderDetailData * data in self.paymentWay) {
        PaywayType type = [data.paymentWay intValue];
        switch (type) {
            case PaywayTypeWX:
            {
                [pays addObject:@{@"微信支付":@(PaywayTypeWX)}];
            }
                break;
                
            case PaywayTypeZFB:
            {
                [pays addObject:@{@"支付宝":@(PaywayTypeZFB)}];
            }
                break;
                
            case PaywayTypeCard:
            {
                [pays addObject:@{@"银行卡":@(PaywayTypeCard)}];
            }
                break;
            default:
                break;
        }
        
        
    }
    return [pays mutableCopy];
}
-(NSString*)getPaywayAppendingString{
    NSMutableArray *pays = [NSMutableArray arrayWithCapacity:3];
    
    for (OrderDetailData * data in self.paymentWay) {
        PaywayType type = [data.paymentWay intValue];
        switch (type) {
            case PaywayTypeWX:
            {
                [pays addObject:@"微信"];
            }
                break;
                
            case PaywayTypeZFB:
            {
                [pays addObject:@"支付宝"];
            }
                break;
                
            case PaywayTypeCard:
            {
                [pays addObject:@"银行卡"];
            }
                break;
            default:
                break;
        }
        
        
    }
    NSString *string = [[pays mutableCopy] componentsJoinedByString:@"、"];
    return string;
}

-(NSArray*)getPayways{
    NSMutableArray *pays = [NSMutableArray arrayWithCapacity:3];
    
    for (OrderDetailData * data in self.paymentWay) {
        PaywayType type = [data.paymentWay intValue];
        switch (type) {
            case PaywayTypeWX:
            {
                NSDictionary* dicWX = @{kImg:@"icon_weixin",kTit:@"微信支付",kType:@(PaywayTypeWX),kIsOn:@"1",
                                        kSubTit:@{[NSString stringWithFormat:@"请在 %@ 分钟内向以上收款信息支付 %@ 元，超时将自动取消订单",self.prompt,self.orderAmount]:@"\n点击打开微信App付款"}
                                        ,
                                        kUrl:data.QRCode,
                                        kData:@[
                                                
                                                @"付款参考号：",self.paymentNumber
                                                ]
                                        
                                        };
                [pays addObject:dicWX];
            }
                break;
                
            case PaywayTypeZFB:
            {
                NSDictionary* dicZFB = @{kImg:@"icon_zhifubao",kTit:@"支付宝",kType:@(PaywayTypeZFB),kIsOn:@"1",
                                         kSubTit:@{[NSString stringWithFormat:@"请在 %@ 分钟内向以上收款信息支付 %@ 元，超时将自动取消订单",self.prompt,self.orderAmount]:@"\n点击打开支付宝App付款"}
                                         ,
                                         kUrl:data.QRCode,
                                         kData:@[
                                                 
                                                 @"付款参考号：",self.paymentNumber
                                                 ]
                                         
                                         };
                [pays addObject:dicZFB];
            }
                break;
                
            case PaywayTypeCard:
            {
                NSDictionary* dicCard = @{kImg:@"icon_bank",kTit:@"银行卡",kType:@(PaywayTypeCard),kIsOn:@"1",
                                          kSubTit:@{[NSString stringWithFormat:@"请在 %@ 分钟内向以上收款信息支付 %@ 元，超时将自动取消订单",self.prompt,self.orderAmount]:@""},
                                          kData:@[
                                                  @{@"开户行：":data.accountOpenBank},
                                                  @{@"银行账号：":data.accountBankCard},
                                                  @{@"收款人姓名：":data.name},
                                                  @{@"付款参考号：":self.paymentNumber}
                                                  ]
                                          
                                          };
                [pays addObject:dicCard];
            }
                break;
            default:
                break;
        }
        
        
    }
    
    return [pays mutableCopy];
}

+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"paymentWayString" : @"paymentWay",
             
             };
}

+(NSDictionary *)objectClassInArray
{
    return @{
             @"paymentWay" : [OrderDetailData class]
             };
}
@end
