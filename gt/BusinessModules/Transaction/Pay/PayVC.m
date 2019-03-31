//
//  PostAdsVC.m
//  gt
//
//  Created by Aalto on 2018/11/19.
//  Copyright © 2018 Aalto. All rights reserved.
//

#import "PayVC.h"
#import "PayView.h"
#import "PayVM.h"

#import "CancelTipPopUpView.h"
#import "SureTipPopUpView.h"
#import "OrderDetailVC.h"

#import "OrderDetailVM.h"

@interface PayVC () <PayViewDelegate>
@property (nonatomic, strong) PayView *mainView;
@property (nonatomic, strong) PayVM *vm;
@property (nonatomic, strong) id requestParams;
@property (nonatomic, copy) DataBlock block;
@property (nonatomic, strong) PayModel* model;
@property (nonatomic, assign)PaywayType type;
@property (nonatomic, strong)OrderDetailModel* orderDetailModel;
@property (nonatomic, strong)OrderDetailVM *orderDetailvm;
@end

@implementation PayVC

#pragma mark - life cycle
+ (instancetype)pushFromVC:(UIViewController *)rootVC requestParams:(id)requestParams withPayModel:(PayModel*)model success:(DataBlock)block
{
    PayVC *vc = [[PayVC alloc] init];
    vc.block = block;
    vc.requestParams = requestParams;
    vc.model = model;
    [rootVC.navigationController pushViewController:vc animated:true];
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self YBGeneral_baseConfig];
    self.title = @"买币";
    [self initView];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)initView {
    [self.view addSubview:self.mainView];
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self submitOrderEvent];
//    NSArray * dataArray = self.requestParams;
//    [self.mainView requestListSuccessWithArray:dataArray WithPage:1];
    
    WS(weakSelf);
    [self.mainView actionBlock:^(id data,id data2) {
        EnumActionTag btnType  = [data integerValue];
        switch (btnType) {
            case EnumActionTag4:
                {
                    [weakSelf outTimeOrderEvent];
                }
                break;
            case EnumActionTag5:
            {
                if (data2!=nil) {
                    if ([data2 isKindOfClass:[NSString class]]) {
                        NSString* zfbcode =data2;
                        NSURL *url = [NSURL URLWithString:@"alipay://"];
                        NSURL *openurl = [NSURL URLWithString:[NSString stringWithFormat:@"alipayqr://platformapi/startapp?saId=10000007&&qrcode=%@",zfbcode]];
                        //先判断是否能打开该url
                        if ([[UIApplication sharedApplication] canOpenURL:url]) {
                            [[UIApplication sharedApplication] openURL:openurl options:@{} completionHandler:^(BOOL success) {
                                
                            }];//asdfzxcvsadf
                        }else {
                            [YKToastView showToastText:@"没安装支付宝，怎么打开啊！"];
                        }
                    }
                }
            }
                break;
            case EnumActionTag6:
            {
                 NSURL *url = [NSURL URLWithString:@"weixin://"];
                //先判断是否能打开该url
                if ([[UIApplication sharedApplication] canOpenURL:url]) {
//                    [[UIApplication sharedApplication] openURL:url];
                    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
                        
                    }];
                }else {
                    [YKToastView showToastText:@"没安装微信，怎么打开啊！"];
                }
            }
                break;
            case EnumActionTag7:
            {
                return ;
            }
                break;
            default:
                break;
        }
        
    }];
    [self.view bottomTripleButtonInSuperView:self.view leftLittleButtonEvent:^(id data) {
        [self contactEvent];
    } leftButtonEvent:^(id data) {
        CancelTipPopUpView* popupView = [[CancelTipPopUpView alloc]init];
        [popupView showInApplicationKeyWindow];
        [popupView richElementsInViewWithModel:@2];
        [popupView actionBlock:^(id data) {
            [weakSelf cancelOrderEvent];
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotify_IsPayStopTimeRefresh object:nil];
        }];

    } rightButtonEvent:^(id data) {
        if (weakSelf.model.paymentWay ==nil||weakSelf.model.paymentWay.count ==0) {
            [YKToastView showToastText:@"暂无可用支付方式"];
            return ;
        }
        
        SureTipPopUpView* popupView = [[SureTipPopUpView alloc]init];
        [popupView showInApplicationKeyWindow];
        [popupView richElementsInViewWithModel:[weakSelf.model getPaywayAppendingDicArr]];
        [popupView actionBlock:^(id data) {
            weakSelf.type = [data integerValue];
            [weakSelf surePayOrderEvent];
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotify_IsPayStopTimeRefresh object:nil];
        }];
    } ];
}
- (void)contactEvent{
    if (self.orderDetailModel !=nil) {
    
    NSString *sessionId;
    NSString *title;
    LoginModel* userInfoModel = [LoginModel mj_objectWithKeyValues:GetUserDefaultWithKey(kUserInfo)];
    if ([self.orderDetailModel.sellUserId isEqualToString:userInfoModel.userinfo.userid]){
        sessionId = self.orderDetailModel.buyUserId;
        title = self.orderDetailModel.buyerName;
    }else{
        sessionId = self.orderDetailModel.sellUserId;
        title = self.orderDetailModel.sellerName;
    }
    [RongCloudManager updateNickName:title userId:sessionId];
    [RongCloudManager jumpNewSessionWithSessionId:sessionId title:title navigationVC:self.navigationController];
        
    }
}
- (void)submitOrderEvent{
    kWeakSelf(self);
    [self.orderDetailvm network_getOrderDetailListWithPage:1 WithRequestParams:self.model.orderId success:^(id data) {
        kStrongSelf(self);
        NSArray* orderDetailArr = data;
        NSDictionary* orderDetailDic = orderDetailArr[0];
        self.orderDetailModel = orderDetailDic[kData];
        
        NSArray * dataArray = self.requestParams;
        [self.mainView requestListSuccessWithArray:dataArray WithPage:1 WithSec:self.orderDetailModel.restTime];

    } failed:^(id data) {
    } error:^(id data) {
    }];
}
- (OrderDetailVM *)orderDetailvm {
    if (!_orderDetailvm) {
        _orderDetailvm = [OrderDetailVM new];
    }
    return _orderDetailvm;
}

- (void)outTimeOrderEvent{
    [OrderDetailVC pushViewController:self requestParams:self.model.orderId success:^(id data) {
        
    }];
}

- (void)cancelOrderEvent{
    [self.vm network_canclePayListWithRequestParams:_model.orderNo success:^(id data) {
        [OrderDetailVC pushViewController:self requestParams:self.model.orderId success:^(id data) {
            
        }];
    } failed:^(id data) {
        
    } error:^(id data) {
        
    }];
}

- (void)surePayOrderEvent{
    kWeakSelf(self);
    [self.vm network_confirmPayListWithRequestParams:_model.orderNo WithPaymentWay:[NSString stringWithFormat:@"%lu",(unsigned long)self.type] success:^(id data) {
        kStrongSelf(self);
        [OrderDetailVC pushViewController:self requestParams:self.model.orderId success:^(id data) {
            
        }];
        
    } failed:^(id data) {
        
    } error:^(id data) {
        
    }];
}
#pragma mark - PayViewDelegate NO
- (void)payView:(PayView *)view requestListWithPage:(NSInteger)page {
   kWeakSelf(self);
    [self.vm network_postPayListWithPage:page WithRequestParams:self.requestParams success:^(id data,id data2) {
        NSArray * dataArray = data;
        kStrongSelf(self);
        [self.mainView requestListSuccessWithArray:dataArray WithPage:page WithSec:@"60"];
    } failed:^(id data){
        kStrongSelf(self);
        [self.mainView requestListFailed];
        [self.navigationController popViewControllerAnimated:YES];
    } error:^(id data){
        kStrongSelf(self);
        [self.mainView requestListFailed];
        [self.navigationController popViewControllerAnimated:YES];
    }
     ];
}

#pragma mark - getter
- (PayView *)mainView {
    if (!_mainView) {
        _mainView = [PayView new];
        _mainView.delegate = self;
    }
    return _mainView;
}

- (PayVM *)vm {
    if (!_vm) {
        _vm = [PayVM new];
    }
    return _vm;
}

@end
