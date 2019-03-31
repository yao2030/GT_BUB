//
//  OrderDetailVC.m
//  gt
//
//  Created by Aalto on 2018/11/19.
//  Copyright © 2018 Aalto. All rights reserved.
//
#import "OrderDetailVC.h"
#import "OrderDetailView.h"
#import "OrderDetailVM.h"

#import "DistributePopUpView.h"
#import "InputPWPopUpView.h"

#import "PostAppealVC.h"

#import "PayVM.h"
#import "CancelTipPopUpView.h"
#import "SureTipPopUpView.h"

#import "AssetsVC.h"
#import "HomeScanView.h"
#import "ScanCodeVC.h"

#import "LoginModel.h"
@interface OrderDetailVC () <OrderDetailViewDelegate>
@property (nonatomic, strong) OrderDetailView *mainView;
@property (nonatomic, strong) OrderDetailVM *vm;

@property (nonatomic, copy) DataBlock block;
//pay
@property (nonatomic, strong)PayVM* payvm;
@property (nonatomic, assign)PaywayType type;
@property (nonatomic, strong)OrderDetailModel* orderDetailModel;
@end

@implementation OrderDetailVC
#pragma mark - life cycle
+ (instancetype)pushTabViewController:(UITabBarController *)rootVC requestParams:(id)requestParams success:(DataBlock)block{
    OrderDetailVC *vc = [[OrderDetailVC alloc] init];
    vc.block = block;
    vc.requestParams = requestParams;
    [rootVC.selectedViewController pushViewController:vc animated:YES];
    return vc;
}
+ (instancetype)pushViewController:(UIViewController *)rootVC requestParams:(id)requestParams success:(DataBlock)block{
    OrderDetailVC *vc = [[OrderDetailVC alloc] init];
    vc.block = block;
    vc.requestParams = requestParams;
    [rootVC.navigationController pushViewController:vc animated:YES];
    return vc;
}
//-(void)YBGeneral_clickBackItem:(UIBarButtonItem *)item{
//    [self.navigationController popToRootViewControllerAnimated:YES];
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self YBGeneral_baseConfig];
    self.title = @"订单详情";
    [self initView];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self orderDetailView:self.mainView requestListWithPage:1];
//    self.navigationController.fd_fullscreenPopGestureRecognizer.enabled = NO;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    self.navigationController.fd_fullscreenPopGestureRecognizer.enabled = YES;
}

- (void)initView {
    [self.view addSubview:self.mainView];
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    WS(weakSelf);
    [self.mainView actionBlock:^(id data,id data2) {
        EnumActionTag btnType  = [data integerValue];
        
        switch (btnType) {
            case EnumActionTag0:
            {
                OrderType orderType = [data2 integerValue];
                if (orderType ==SellerOrderTypeWaitDistribute) {
                    DistributePopUpView* popupView = [[DistributePopUpView alloc]init];
                    [popupView richElementsInViewWithModel:weakSelf.orderDetailModel];
                    [popupView showInApplicationKeyWindow];
                    [popupView actionBlock:^(id data) {
                        //post
                        InputPWPopUpView* popupView = [[InputPWPopUpView alloc]init];
                        [popupView showInApplicationKeyWindow];
                        [popupView actionBlock:^(id data) {
//                            [YKToastView showToastText:@"已放行"];
                            [weakSelf distributeOrder:data];
                        }];
                    }];
                }
                else if(orderType ==BuyerOrderTypeNotYetPay){
                    NSLog(@"买方 已完成付款");
                    SureTipPopUpView* popupView = [[SureTipPopUpView alloc]init];
                    [popupView showInApplicationKeyWindow];
                    [popupView richElementsInViewWithModel:[weakSelf.orderDetailModel getPaywayAppendingDicArr]];
                    [popupView actionBlock:^(id data) {
                        weakSelf.type = [data integerValue];
                        [weakSelf surePayOrderEvent];
                    }];
                }
                    
                else if(orderType ==BuyerOrderTypeHadPaidNotDistribute){
                    NSLog(@"买方 我要申诉");
                    [PostAppealVC pushViewController:self requestParams:self.orderDetailModel.orderNo success:^(id data) {
                        [self submitAppeal:data];
                    }];
                }
                else if(orderType ==BuyerOrderTypeAppealing
                        ||
                    orderType ==SellerOrderTypeAppealing){
                    NSLog(@"买方、卖方 取消申诉");
                    [self cancelAppeal];
                }
                else if (orderType ==BuyerOrderTypeFinished){
                    NSLog(@"买方 查看资产");
                    [AssetsVC pushFromVC:self requestParams:@1 success:^(id data) {
//                        [self.navigationController popToRootViewControllerAnimated:YES];
                    }];
//                    [self locateTabBar:3];
//                    [[NSNotificationCenter defaultCenter] postNotificationName:kNotify_jumpAssetVC object:nil];
                }
            }
                break;
            case EnumActionTag1:
            {
                OrderType orderType = [data2 integerValue];
                if (orderType ==SellerOrderTypeWaitDistribute) {
                    [PostAppealVC pushViewController:self requestParams:self.orderDetailModel.orderNo success:^(id data) {
                        [self submitAppeal:data];
                    }];
                }
                else if(orderType ==BuyerOrderTypeNotYetPay){
                    NSLog(@"买方 取消订单");
                    CancelTipPopUpView* popupView = [[CancelTipPopUpView alloc]init];
                    [popupView showInApplicationKeyWindow];
                    [popupView richElementsInViewWithModel:@2];
                    [popupView actionBlock:^(id data) {
                        [self cancelOrderEvent];
                    }];
                }
                else if (orderType ==BuyerOrderTypeFinished){
                    NSLog(@"买方 扫码转账");
                    if (GetUserDefaultBoolWithKey(kIsScanTip)) {
                        [ScanCodeVC pushFromVC:self];
                    }else{
                        HomeScanView* scanView = [[HomeScanView alloc]initWithFrame:CGRectMake(0, 0, MAINSCREEN_WIDTH, MAINSCREEN_HEIGHT)];
                        scanView.scanBlock = ^{
                            [ScanCodeVC pushFromVC:self];
                        };
                        scanView.buyBlock = ^{
                            
                            
                        };
                        scanView.helpBlock = ^{
                            
                            
                        };
                        scanView.cancelBlock = ^{
                        };
                        //                    [self.tabBarController.view addSubview:scanView];
                        [[UIApplication sharedApplication].keyWindow addSubview:scanView];
                    }
                }
            }
                break;
            case EnumActionTag2:
            {
                [self contactEvent];
                
            }
                break;
            case EnumActionTag3:
            {
                [self orderDetailView:self.mainView requestListWithPage:1];
            }
                break;
            default:
                break;
        }
    }] ;
}
- (void)cancelOrderEvent{
    [self.payvm network_canclePayListWithRequestParams:self.orderDetailModel.orderNo success:^(id data) {
        [self orderDetailView:self.mainView requestListWithPage:1];
    } failed:^(id data) {
        
    } error:^(id data) {
        
    }];
}

- (void)surePayOrderEvent{
    kWeakSelf(self);
    [self.payvm network_confirmPayListWithRequestParams:self.orderDetailModel.orderNo WithPaymentWay:[NSString stringWithFormat:@"%lu",(unsigned long)self.type] success:^(id data) {
        kStrongSelf(self);
        [self orderDetailView:self.mainView requestListWithPage:1];
        
    } failed:^(id data) {
        
    } error:^(id data) {
        
    }];
}
- (PayVM *)payvm {
    if (!_payvm) {
        _payvm = [PayVM new];
    }
    return _payvm;
}

- (void)submitAppeal:(id)data{
    kWeakSelf(self);
    [self.vm network_submitAppealWithRequestParams:data success:^(id data) {
        kStrongSelf(self);
        [self orderDetailView:self.mainView requestListWithPage:1];
    } failed:^(id data) {
        
    } error:^(id data) {
        
    }];
}

- (void)cancelAppeal{
    kWeakSelf(self);
    [self.vm network_cancelAppealWithRequestParams:self.orderDetailModel.appealId success:^(id data) {
        kStrongSelf(self);
        [self orderDetailView:self.mainView requestListWithPage:1];
    } failed:^(id data) {
        
    } error:^(id data) {
        
    }];
}

- (void)distributeOrder:(id)data{
    kWeakSelf(self);
    [self.vm network_transactionOrderSureDistributeWithCodeDic:data WithRequestParams:self.orderDetailModel.orderNo
    success:^(id data) {
        kStrongSelf(self);
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotify_IsStopTimeRefresh object:nil];
        [self orderDetailView:self.mainView requestListWithPage:1];
    } failed:^(id data) {
        
    } error:^(id data) {
        
    }];
}
- (void)contactEvent{
    if (self.orderDetailModel!=nil) {
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
#pragma mark - orderDetailViewDelegate
- (void)orderDetailView:(OrderDetailView *)view requestListWithPage:(NSInteger)page{
    kWeakSelf(self);
    [self.vm network_getOrderDetailListWithPage:page WithRequestParams:self.requestParams success:^(id data) {
        kStrongSelf(self);
        NSArray* model = data;
        NSDictionary* dic = model[0];
        self.orderDetailModel = dic[kData];
        
        
        [self.mainView requestListSuccessWithArray:data WithPage:page];
    } failed:^(id data) {
        kStrongSelf(self);
        [self.mainView requestListFailed];
    } error:^(id data) {
        kStrongSelf(self);
        [self.mainView requestListFailed];
    }];
}

#pragma mark - getter

- (OrderDetailView *)mainView {
    if (!_mainView) {
        _mainView = [OrderDetailView new];
        _mainView.delegate = self;
    }
    return _mainView;
}

- (OrderDetailVM *)vm {
    if (!_vm) {
        _vm = [OrderDetailVM new];
    }
    return _vm;
}

@end
