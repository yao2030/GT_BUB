//
//  BuyABViewController.m
//  OTC
//
//  Created by David on 2018/11/17.
//  Copyright © 2018年 yang peng. All rights reserved.
//

#import "BuyVC.h"
#import "BuyTipPopUpView.h"
#import "BuyHV.h"
#import "PostAdsReplyCell.h"
#import "PostAdsSectionHeaderView.h"
#import "PayVC.h"
#import "TransactionModel.h"
#import "PayVM.h"
#import "BaseCell.h"
#import "SecuritySettingVC.h"
@interface BuyVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) TransactionData * requestParams;
@property (nonatomic, copy) DataBlock block;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) BuyHV* buyHV;
@property (nonatomic, copy) NSString* limitNum;
@property (nonatomic, copy) NSString* remark;
@property (nonatomic, strong) PayVM *vm;
@end

@implementation BuyVC


#pragma mark - life cycle
+ (instancetype)pushFromVC:(UIViewController *)rootVC requestParams:(id )requestParams success:(DataBlock)block
{
    BuyVC *vc = [[BuyVC alloc] init];
    vc.block = block;
    vc.requestParams = requestParams;
    [rootVC.navigationController pushViewController:vc animated:true];
    return vc;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self YBGeneral_baseConfig];
    self.title = @"买币";
    
//    self.view.backgroundColor = HEXCOLOR(0xf6f5fa);
    self.tableView.backgroundColor = kWhiteColor;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view).offset(0);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset([YBSystemTool isIphoneX]? -[YBFrameTool tabBarHeight]-48.5:-48.5);
    }];
    
    CGFloat buyHV_height = 9;
    TransactionAmountType type = [_requestParams.amountType intValue];
    if (type == TransactionAmountTypeLimit){
        buyHV_height = 387+20+15;
    }else{
        buyHV_height = 293;
    }
    _buyHV = [[BuyHV alloc]initWithFrame:CGRectMake(0, 0, MAINSCREEN_WIDTH, buyHV_height) WithModel:_requestParams];
    _tableView.tableHeaderView = _buyHV;
    _tableView.tableHeaderView.backgroundColor = kWhiteColor;
    WS(weakSelf);
    
    [_buyHV actionBlock:^(id data) {
        weakSelf.limitNum = data;
//        if (weakSelf.block) {
//            weakSelf.block(data);
//        }
    }];
    [self.view bottomDoubleButtonInSuperView:self.view WithButtionTitles:@[@"取消",@"提交"] leftButtonEvent:^(id data) {
        [weakSelf cancelEvent];
    } rightButtonEvent:^(id data) {
        [weakSelf confirm:data];
    }];
}
#pragma mark - <UITableViewDataSource, UITableViewDelegate>
#pragma mark - Sectons
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
#pragma mark - Rows
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

#pragma mark - SectonHeader
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [PostAdsSectionHeaderView viewHeight];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    PostAdsSectionHeaderView * sectionHeaderView = (PostAdsSectionHeaderView *)[_tableView dequeueReusableHeaderFooterViewWithIdentifier:PostAdsSectionHeaderReuseIdentifier];
    [sectionHeaderView richElementsInBuyTableHeaderViewWithTitle:@""];//卖家备注：
    return sectionHeaderView;
    
}
#pragma mark - SectonFooter
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 64;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView* sfv = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MAINSCREEN_WIDTH, 49+15)];
    sfv.backgroundColor = kWhiteColor;
    
    UILabel* timeTipLab = [[UILabel alloc]init];
    timeTipLab.textColor = HEXCOLOR(0xff9238);
    timeTipLab.textAlignment = NSTextAlignmentCenter;
    timeTipLab.font = kFontSize(14);
    timeTipLab.text = @"平台已担保交易，可安心付款";
    timeTipLab.frame = CGRectMake(13, 29, MAINSCREEN_WIDTH-26, 20);
    [sfv addSubview:timeTipLab];
    return sfv;
}
#pragma mark - cellForRow
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BaseCell *cell = [BaseCell cellWith:tableView];
    cell.hideSeparatorLine = YES;
    cell.frame = CGRectZero;
    return cell;
    
//    PostAdsReplyCell *cell = [PostAdsReplyCell cellWith:tableView];
//    cell.userInteractionEnabled = NO;
//    TransactionData* data = _requestParams;
//    cell.isHiddenLimitCount = YES;
//    [cell richElementsInBuyVCCellWithModel:@{[NSString stringWithFormat:@"%@",(data.autoReplyContent!=nil
//                            &&![NSString isEmpty:data.autoReplyContent])?data.autoReplyContent:@"亲爱的买家，请仔细确认好订单相关信息。\n合作愉快！"]:@""}];
//    self.remark = [NSString stringWithFormat:@"%@",(data.autoReplyContent!=nil
//                                                    &&![NSString isEmpty:data.autoReplyContent])?data.autoReplyContent:@""];
//    WS(weakSelf);
//    [cell actionBlock:^(id data) {
////        if (self.block) {
////            self.block(data);
////        }
//        weakSelf.remark = data;
//    }];
//    return cell;
    
}
#pragma mark - heightForRow
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    return [PostAdsReplyCell cellHeightWithModel:@{}];
    return .1f;
}

-(void)actionBlock:(ActionBlock)block{
    self.block= block;
}

#pragma mark - getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        //        [_tableView YBGeneral_configuration];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [PostAdsSectionHeaderView sectionHeaderViewWith:_tableView];
    }
    return _tableView;
}

- (void)confirm:(UIButton*)sender{    
    if (GetUserDefaultBoolWithKey(kIsBuyTip)) {
        [self sureBuyEvent];
    }
    else
    {
        BuyTipPopUpView* popupView = [[BuyTipPopUpView alloc]init];
        [popupView showInApplicationKeyWindow];
        [popupView richElementsInViewWithModel:_requestParams.prompt];
        [popupView actionBlock:^(id data) {
            [self sureBuyEvent];
//            [YKToastView showToastText:@"已提交"];
        }];
    }
}

- (void)cancelEvent{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)sureBuyEvent
{
    if([self isloginBlock])return;
    [self loginSuccessBlockMethod];
}

-(void)loginSuccessBlockMethod{
    NSString* num = @"";
    NSString* remark = ![NSString isEmpty:self.remark]?self.remark:@"";
    TransactionAmountType type = [_requestParams.amountType intValue];
    if (type == TransactionAmountTypeLimit){
        num = ![NSString isEmpty:self.limitNum]?self.limitNum:@"";//![NSString isEmpty:self.numTf.text]?self.numTf.text:_requestParams.number;
    }else{
        num = _requestParams.fixedAmount;
    }
    
    kWeakSelf(self);
    [self.vm network_postPayListWithPage:1 WithRequestParams:@[_requestParams.ugOtcAdvertId,num,remark] success:^(id data, id data2) {
//        NSArray * dataArray = data;
        kStrongSelf(self);
//        [self.mainView requestListSuccessWithArray:dataArray WithPage:page];
        [PayVC pushFromVC:self requestParams:data withPayModel:data2 success:^(id data) {
            
        }];
    } failed:^(id data){
        PayModel* model = data;
        NSString* msg = model.msg;
        if ([msg isEqualToString:@"设置完支付密码才能进行买卖流程哦"]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"您还没有设置支付密码" message:@"设置完支付密码才能进行买卖流程哦" preferredStyle:  UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"稍后验证" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"现在去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [SecuritySettingVC pushFromVC:self requestParams:@1 success:^(id data) {
                
            }];
        }]];
        [self presentViewController:alert animated:true completion:nil];
        }
        else{
            [YKToastView showToastText:msg];
        }
        
    } error:^(id data){
//        kStrongSelf(self);
//        [self.mainView requestListFailed];
//        [self.navigationController popViewControllerAnimated:YES];
    }
     ];
    
    
}

- (PayVM *)vm {
    if (!_vm) {
        _vm = [PayVM new];
    }
    return _vm;
}
@end
