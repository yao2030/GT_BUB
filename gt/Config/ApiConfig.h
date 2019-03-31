//
//  ApiConfig.m
//  gtp
//
//  Created by Aalto on 2019/1/3.
//  Copyright © 2019 Aalto. All rights reserved.
//

#ifndef ApiConfig_h
#define ApiConfig_h
//正式发布环境
//#define URL_IP @"https://api.bubchain.com/ug/"

//预生产环境
//#define URL_IP ？？？？？

//测试环境
#define URL_IP @"http://192.168.15.157:8010/ug/"

//外包的环境
//#define URL_IP @"http://47.52.45.85:8010/ug/"

//Lewis的环境
//#define URL_IP @"http://192.168.21.180:8010/ug/"

#define LNURL_IP @"http://www.liniuyang.com/"
//请求Cookie接口
#define API_GetCookie @"uuserApi/OKay"

#endif /* ApiConfig_h */

typedef NS_ENUM(NSInteger, ApiType)
{
    //    ApiTypeNone = 0,
    ApiType_Home,
    ApiType_HomeBanner,
    ApiType_UserAssert,
    ApiType_UserAssertList,
    
    
    ApiType_Transfer,
    ApiType_MultiTransfer,
    
    ApiType_TransferBrokeageRate,
    
    ApiType_TransferRecord,
    
    ApiType_TransferDetail,
    
    ApiType_Transaction,
    ApiType_TransactorInfo,
    ApiType_TransactionPay,
    ApiType_TransactionComfirmPay,
    ApiType_TransactionCancelPay,
    ApiType_TransactionOrderDetail,
    ApiType_TransactionOrderList,
    ApiType_TransactionOrderSureDistribute,
    
    ApiType_NoReadMsgList,
    ApiType_EventMsgList,
//    ApiType_CancelAppeal,
    
    ApiType_SubmitAppeal,
    ApiType_CancelAppeal,
    
    ApiType_Register,
    ApiType_Login,
    ApiType_LoginOut,
    ApiType_FetchNickName,
    
    ApiType_CheckUserInfo,
    ApiType_ChangeNickname,
    
    
    ApiType_IdentityApply,
    ApiType_IdentitySaveFacePlusResult,
    ApiType_IdentityVertify,
//    ApiType_ForgetPW,
    ApiType_Vertify,
    
    ApiType_SettingFundPW,
    ApiType_ChangeFundPW,
    ApiType_ChangeLoginPW,
    ApiType_RongCloudToken,//登录状态，由userID，得到Token
    ApiType_RongCloudTemporaryToken,//未登录状态，由服务器分配一个Token

    ApiType_FaceIdentity,
    
    ApiType_AboutUs,
    ApiType_MyTransferCode,
    ApiType_HelpCentre,
    
    ApiType_GoogleSecret,
    ApiType_BindingGoogle,
    ApiType_DismissGoogle,
    ApiType_SwitchGoogle,
    
    ApiType_AddAccount,
    ApiType_EditAccount,
    ApiType_DeleteAccount,
    ApiType_PayMentAccountList,
    
    ApiType_TransactionsOptionsCheck,
    ApiType_PostAdsCheck,
    ApiType_PostAds,
    ApiType_ModifyAds,
    ApiType_AdsDetail,
    ApiType_AdsList,
    ApiType_OutlineAds,
    ApiType_OnlineAds,
    
    ApiType_BTCCheck,
    ApiType_BTCApply,
    ApiType_BTCList,
    ApiType_BTCDetail,
    ApiType_BTCBack,
        
    ApiType_Homes,
};
@interface ApiConfig : NSObject

+ (NSString *)getAppApi:(ApiType)type;

@end
