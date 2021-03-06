//
//  YBHomeDataCenter.h
//  Aa
//
//  Created by Aalto on 2018/11/19.
//  Copyright © 2018 Aalto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataStatisticsModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface DataStatisticsVM : NSObject

//这里也可以用代理回调网络请求
- (void)network_getDataStatisticsListWithPage:(NSInteger)page success:(void(^)(NSArray *dataArray))success failed:(void(^)(void))failed;
@end

NS_ASSUME_NONNULL_END
