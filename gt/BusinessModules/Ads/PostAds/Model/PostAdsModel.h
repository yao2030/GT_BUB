//
//  HomeModel.h
//  LiNiuYang
//
//  Created by Aalto on 2017/3/30.
//  Copyright © 2017年 LiNiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PostAdsSubDataItem : NSObject
@property (nonatomic, strong) NSString * sid;
@property (nonatomic, strong) NSString * iid;
@property (nonatomic, strong) NSString * type;
@property (nonatomic, strong) NSString * category;
@property (nonatomic, strong) NSString * img;
@property (nonatomic, strong) NSString * tit;
@property (nonatomic, strong) NSString * subtit;
@property (nonatomic, strong) NSString * attachtit;

@property (nonatomic, strong) NSString * price;
@property (nonatomic, strong) NSString * title;
@end

@interface PostAdsSubData : NSObject
@property (nonatomic, strong) NSArray * arr;
@property (nonatomic, strong) NSString * category;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * subtitle;
+(NSDictionary *)objectClassInArray;
@end




@interface PostAdsData : NSObject

@property (nonatomic, strong) NSArray * b;

+(NSDictionary *)objectClassInArray;
@end



@interface PostAdsResult : NSObject
@property (nonatomic, strong) PostAdsData * data;
@property (nonatomic, copy) NSString*  code;
@property (nonatomic, copy) NSString*  info;
@end


@interface PostAdsModel : NSObject
@property (nonatomic, copy) NSString * ugOtcAdvertId;
@property (nonatomic, copy) NSString * errcode;
@property (nonatomic, copy) NSString * msg;
@property (nonatomic, copy) NSString * price;
@property (nonatomic, copy) NSString * optionPrice;
@property (nonatomic, copy) NSString * prompt;
@property (nonatomic, copy) NSString * paymentWay;
@property (nonatomic, copy) NSString * number;
//@property (nonatomic, strong) PostAdsResult * result;

@end
