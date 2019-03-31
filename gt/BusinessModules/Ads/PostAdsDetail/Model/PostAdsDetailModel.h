//
//  HomeModel.h
//  LiNiuYang
//
//  Created by Aalto on 2017/3/30.
//  Copyright © 2017年 . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PostAdsDetailSubDataItem : NSObject
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

@interface PostAdsDetailSubData : NSObject
@property (nonatomic, strong) NSArray * arr;
@property (nonatomic, strong) NSString * category;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * subtitle;
+(NSDictionary *)objectClassInArray;
@end

@interface PostAdsDetailData : NSObject
@property (nonatomic, strong) NSArray * b;

+(NSDictionary *)objectClassInArray;
@end



@interface PostAdsDetailResult : NSObject
@property (nonatomic, strong) PostAdsDetailData * data;
@property (nonatomic, copy) NSString*  code;
@property (nonatomic, copy) NSString*  info;
@end


@interface PostAdsDetailModel : NSObject
@property (nonatomic, copy) NSString * info;
@property (nonatomic, strong) PostAdsDetailResult * result;

@end
