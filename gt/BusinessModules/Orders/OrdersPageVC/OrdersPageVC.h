//
//  PageViewController.h
//  TestTabTitle
//
//  Created by Aalto on 2018/12/20.
//  Copyright © 2018年 Aalto. All rights reserved.
//

#import <UIKit/UIKit.h>
//@class OrdersPageListView;
#import "OrdersPageListView.h"

@interface OrdersPageVC : UIViewController
- (void)actionBlock:(TwoDataBlock)block;

@property (nonatomic, strong) OrdersPageListView *mainView;
@property (nonatomic,copy)NSString *tag;
@property (nonatomic,assign)UserType utype;
- (void)ordersPageListView:(OrdersPageListView *)view requestListWithPage:(NSInteger)page;
@end
