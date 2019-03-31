//
//  PostAdsVC.h
//  gt
//
//  Created by Aalto on 2018/11/19.
//  Copyright © 2018 Aalto. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class PayModel;
@interface PayVC : BaseVC
+ (instancetype)pushFromVC:(UIViewController *)rootVC requestParams:(id )requestParams withPayModel:(PayModel*)model success:(DataBlock)block;
@end

NS_ASSUME_NONNULL_END
