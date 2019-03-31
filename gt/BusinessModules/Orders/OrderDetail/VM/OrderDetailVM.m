//
//  YBHomeDataCenter.m
//  Aa
//
//  Created by Aalto on 2018/11/19.
//  Copyright © 2018 Aalto. All rights reserved.
//

#import "OrderDetailVM.h"

@interface OrderDetailVM()
@property (strong,nonatomic)NSMutableArray   *listData;
@property (strong,nonatomic)NSArray* gridSectionNames;
@property (nonatomic,strong) OrderDetailModel* model;
@end

@implementation OrderDetailVM
- (void)network_submitAppealWithRequestParams:(id)requestParams success:(DataBlock)success failed:(DataBlock)failed error:(DataBlock)err{
    NSArray* arr = requestParams;
    _listData = [NSMutableArray array];
    
    NSDictionary *params = @{
                             @"remark": arr[0],
                             @"appealReason": arr[1],
                             @"contactWay": arr[2],
                             @"orderNo": arr[3]
                             };
    [SVProgressHUD showWithStatus:@"加载中..." maskType:SVProgressHUDMaskTypeNone];
    
    WS(weakSelf);
    [[YTSharednetManager sharedNetManager]postNetInfoWithUrl:[ApiConfig getAppApi:ApiType_SubmitAppeal] andType:All andWith:params success:^(NSDictionary *dic) {
        
        [SVProgressHUD dismiss];
        
        self.model = [OrderDetailModel mj_objectWithKeyValues:dic];
        
        if ([NSString getDataSuccessed:dic]) {
            success(weakSelf.model);
            
        }
        else{
            [YKToastView showToastText:weakSelf.model.msg];
            failed(weakSelf.model);
        }
        
    } error:^(NSError *error) {
        [SVProgressHUD dismiss];
        [YKToastView showToastText:error.description];
        err(error);
    }];
}

- (void)network_cancelAppealWithRequestParams:(id)requestParams success:(DataBlock)success failed:(DataBlock)failed error:(DataBlock)err{
    
    _listData = [NSMutableArray array];
    if (requestParams==nil) {
        [YKToastView showToastText:@"申述ID缺失"];
    }
    NSDictionary *params = @{
                             @"appealId": requestParams
                             };
    [SVProgressHUD showWithStatus:@"加载中..." maskType:SVProgressHUDMaskTypeNone];
    
    WS(weakSelf);
    [[YTSharednetManager sharedNetManager]postNetInfoWithUrl:[ApiConfig getAppApi:ApiType_CancelAppeal] andType:All andWith:params success:^(NSDictionary *dic) {
        
        [SVProgressHUD dismiss];
        
        self.model = [OrderDetailModel mj_objectWithKeyValues:dic];
        
        if ([NSString getDataSuccessed:dic]) {
            success(weakSelf.model);
            
        }
        else{
            [YKToastView showToastText:weakSelf.model.msg];
            failed(weakSelf.model);
        }
        
    } error:^(NSError *error) {
        [SVProgressHUD dismiss];
        [YKToastView showToastText:error.description];
        err(error);
    }];
}

- (void)network_transactionOrderSureDistributeWithCodeDic:(NSDictionary*)codeDic WithRequestParams:(id)requestParams success:(DataBlock)success failed:(DataBlock)failed error:(DataBlock)err {
    
    _listData = [NSMutableArray array];
    
    
    NSDictionary *params =
                          @{@"transactionPassword":codeDic.allKeys[0],
                             @"googlecode":codeDic.allValues[0],
                                 @"orderNo":requestParams
                             };
    
    [SVProgressHUD showWithStatus:@"加载中..." maskType:SVProgressHUDMaskTypeNone];
    WS(weakSelf);
    
    [[YTSharednetManager sharedNetManager]postNetInfoWithUrl:[ApiConfig getAppApi:ApiType_TransactionOrderSureDistribute] andType:All andWith:params success:^(NSDictionary *dic) {
        self.model = [OrderDetailModel mj_objectWithKeyValues:dic];
        if ([NSString getDataSuccessed:dic]) {
            [YKToastView showToastText:weakSelf.model.msg];
            success(weakSelf.model);
        }
        else{
            [YKToastView showToastText:weakSelf.model.msg];
            failed(weakSelf.model);
            
        }
    } error:^(NSError *error) {
        [YKToastView showToastText:error.description];
        err(error);
    }];
    [SVProgressHUD dismiss];
}

- (void)network_getOrderDetailListWithPage:(NSInteger)page WithRequestParams:(id)requestParams success:(DataBlock)success failed:(DataBlock)failed error:(DataBlock)err{
    
    _listData = [NSMutableArray array];
    
    NSDictionary *params = @{
                             @"orderId": requestParams
                             };
    
    
    WS(weakSelf);
    [[YTSharednetManager sharedNetManager]postNetInfoWithUrl:[ApiConfig getAppApi:ApiType_TransactionOrderDetail] andType:All andWith:params success:^(NSDictionary *dic) {
        
//        [SVProgressHUD dismiss];
        
        self.model = [OrderDetailModel mj_objectWithKeyValues:dic];
        
        if ([NSString getDataSuccessed:dic]) {
            //success(weakSelf.model);
            [weakSelf assembleApiData:self.model];
            success(weakSelf.listData);
        }
        else{
            failed(weakSelf.model);
            [YKToastView showToastText:weakSelf.model.msg];
        }
        
    } error:^(NSError *error) {
//        [SVProgressHUD dismiss];
        err(error);
        [YKToastView showToastText:error.description];
        
    }];
    
}

- (void)assembleApiData:(OrderDetailModel*)data{
    
    [self removeContentWithType:IndexSectionOne];
    OrderType orderType = [data getTransactionOrderType];
    NSDictionary* dic1 = @{
                           kArr:@(IndexSectionOne),
                           kData:data,
                           kType:@([data getTransactionOrderType]),
                           kImg:[data getTransactionOrderTypeImageName],
                           kTit:[data getTransactionOrderTypeTitle],
                           kSubTit:[data getTransactionOrderTypeSubTitle],
                           kIndexSection:@{
                                   kTit:[NSString stringWithFormat:@"%@",data.restTime] ,
//                                       [NSString stringWithFormat:@"%@",[NSString timeWithSecond:[data.restTime integerValue]]],
                                   kSubTit:[NSString stringWithFormat:@"%@",[data getTransactionOrderTypeFooterSubTitle]]
                                   },
                           
                           kIndexRow:
                               orderType== BuyerOrderTypeFinished?
                               @[
                                   @{@"订单号：":[NSString stringWithFormat:@"%@",data.orderNo]},
                                   @{@"订单金额：":[NSString stringWithFormat:@"%@",data.orderAmount]},
                                   @{@"单价：":@"1 CNY = 1 BUB"},
                                   @{@"数量：":[NSString stringWithFormat:@"%@ BUB",data.number]},
                                   @{@"支付方式：":[data getPaywayAppendingString]},
                                   @{@"付款参考号：":[NSString stringWithFormat:@"%@",data.paymentNumber]}
                                     
                                   ]
                           :
                           @[
                               @{@"订单号：":[NSString stringWithFormat:@"%@",data.orderNo]},
                               @{@"订单金额：":[NSString stringWithFormat:@"%@",data.orderAmount]},
                               @{@"单价：":@"1 CNY = 1 BUB"},
                               @{@"数量：":[NSString stringWithFormat:@"%@ BUB",data.number]},
                               @{@"订单时间：":[NSString stringWithFormat:@"%@",data.createdTime]
                                           
                                           }
                               ]
                           
                           };
    [self.listData addObjectsFromArray:@[dic1]];
    [self sortData];
}

- (void)sortData {
    [self.listData sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSNumber *number1 = [NSNumber numberWithInteger:[[obj1 objectForKey:kArr] integerValue]];
        NSNumber *number2 = [NSNumber numberWithInteger:[[obj2 objectForKey:kArr] integerValue]];
        
        NSComparisonResult result = [number1 compare:number2];
        
        return result == NSOrderedDescending;
    }];
}

- (void)removeContentWithType:(IndexSectionType)type {
    [self.listData enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        IndexSectionType contentType = [[(NSDictionary *)obj objectForKey:kArr] integerValue];
        if (contentType == type) {
            *stop = YES;
            [self.listData removeObject:obj];
        }
    }];
}


@end
