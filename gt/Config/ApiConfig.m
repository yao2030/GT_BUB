//
//  ApiConfig.m
//  gtp
//
//  Created by Aalto on 2019/1/3.
//  Copyright © 2019 Aalto. All rights reserved.
//

#import "ApiConfig.h"

@implementation ApiConfig
+ (NSString *)getAppApi:(ApiType)type{
    NSString *api = nil;
    switch (type)
    {
        case ApiType_Home: api = @"mar/pbmts.do"; break;
        case ApiType_HomeBanner: api = @"fac/pbqbs.do"; break;
        
        case ApiType_UserAssert: api = @"acc/pbads.do"; break;
        case ApiType_UserAssertList: api = @"acc/pbahs.do"; break;
            
            
        case ApiType_Transfer: api = @"acc/pbats.do"; break;
        case ApiType_MultiTransfer: api = @"acc/pbata.do"; break;
        
        case ApiType_TransferBrokeageRate: api = @"fac/pbqps.do"; break;
         
        case ApiType_TransferRecord:api = @"acc/pbtrs.do"; break;
        case ApiType_TransferDetail:api = @"acc/pbtds.do"; break;
        
        case ApiType_Transaction: api = @"mer/pbadv.do"; break;
        case ApiType_TransactorInfo: api = @"mer/pbmms.do"; break;
        case ApiType_TransactionPay: api = @"ord/pbpos.do"; break;
        case ApiType_TransactionComfirmPay: api = @"ord/pbcfs.do"; break;
        case ApiType_TransactionCancelPay: api = @"ord/pbcos.do"; break;
        case ApiType_TransactionOrderDetail: api = @"ord/pbquo.do"; break;
        case ApiType_TransactionOrderList: api = @"ord/pbuos.do"; break;
        case ApiType_TransactionOrderSureDistribute: api = @"ord/pbcrs.do"; break;
           
        
        case ApiType_NoReadMsgList: api = @"mes/pbqms.do"; break;
        case ApiType_EventMsgList: api = @"ord/pbmls.do"; break;
         
        case ApiType_SubmitAppeal: api = @"ord/pbaos.do"; break;
        case ApiType_CancelAppeal: api = @"ord/pbcls.do"; break;
            
        case ApiType_Register: api = @"usr/pbrus.do"; break;
        case ApiType_Login: api = @"usr/pblin.do"; break;
            
        case ApiType_LoginOut: api = @"usr/pblou.do"; break;
        case ApiType_FetchNickName: api = @"usr/pbqun.do"; break;
        
        
        case ApiType_CheckUserInfo: api = @"usr/pbpis.do"; break;
        case ApiType_ChangeNickname: api = @"usr/pbmns.do"; break;
        
        case ApiType_IdentityApply: api = @"usr/pbvcs.do"; break;
        case ApiType_IdentitySaveFacePlusResult: api = @"fac/pbsrs.do"; break;
            
        case ApiType_IdentityVertify: api = @"usr/pbrps.do"; break;    
                
        case ApiType_Vertify: api = @"usr/pbggc.do"; break;
        case ApiType_RongCloudToken: api = @"usr/pbqus.do"; break;
        case ApiType_RongCloudTemporaryToken: api = @"usr/pbtrt.do"; break;
        
        case ApiType_SettingFundPW: api = @"usr/pbstg.do"; break;
        case ApiType_ChangeFundPW: api = @"usr/pbvcs.do"; break;
        case ApiType_ChangeLoginPW: api = @"usr/pbvcs.do"; break;
        case ApiType_AboutUs: api = @"sys/pbqis.do"; break;
        case ApiType_MyTransferCode: api = @"acc/pbaas.do"; break;
        case ApiType_FaceIdentity: api = @"fac/pbfrs.do"; break;
            
            
        case ApiType_HelpCentre: api = @"fac/pbpcs.do"; break;
        
        
        
        case ApiType_GoogleSecret: api = @"usr/pbggg.do"; break;
        case ApiType_BindingGoogle: api = @"usr/pbbgg.do";break;
        case ApiType_DismissGoogle:api = @"usr/pbrgc.do";break;
        case ApiType_SwitchGoogle:api = @"usr/pbsvs.do";break;
            
            
        case ApiType_AddAccount: api = @"mer/pbapw.do"; break;
        case ApiType_EditAccount: api = @"mer/pbupw.do"; break;
        case ApiType_DeleteAccount: api = @"mer/pbdpw.do"; break;
        case ApiType_PayMentAccountList: api = @"mer/pbpws.do"; break;
            
        case ApiType_TransactionsOptionsCheck: api = @"fac/pbacs.do"; break;
        case ApiType_PostAdsCheck: api = @"mer/pbadl.do"; break;
        case ApiType_PostAds: api = @"mer/pbpas.do"; break;
        case ApiType_ModifyAds: api = @"mer/pbuas.do"; break;
            
        case ApiType_AdsDetail: api = @"mer/pbqad.do"; break;
        case ApiType_AdsList: api = @"mer/pbmas.do"; break;
        case ApiType_OutlineAds: api = @"mer/pbcas.do"; break;
        case ApiType_OnlineAds: api = @"mer/pbsas.do"; break;
            
            
        case ApiType_BTCCheck: api = @"btc/pbers.do"; break;
        case ApiType_BTCApply: api = @"btc/pbebs.do"; break;
        case ApiType_BTCList: api = @"btc/pbels.do"; break;
        case ApiType_BTCDetail: api = @"btc/pbeds.do"; break;
        case ApiType_BTCBack: api =@"btc/pbces.do"; break;
            
        case ApiType_Homes: api = @"itemApi/searchIndexSourceList"; break;
            
    }
    return api;
}
@end
