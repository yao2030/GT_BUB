//
//  TabContentView.h
//  TestTabTitle
//
//  Created by 张小明 on 2018/3/29.
//  Copyright © 2018年 张小明. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^TabSwitchBlcok)(NSInteger index);
@interface TabContentView : UIView<UIPageViewControllerDelegate,UIPageViewControllerDataSource,UIGestureRecognizerDelegate,UIScrollViewDelegate>

- (void)actionBlock:(ActionBlock)block;
/**
 page
 */
@property (nonatomic,strong)UIPageViewController *pageController;

/**
 内容页数组
 */
@property (nonatomic,strong)NSArray<UIViewController*> *controllers;
/**
 内容页数组
 */
@property (nonatomic,strong)TabSwitchBlcok tabSwitch;


-(void)updateTab:(NSInteger)index;


-(void)configParam:(NSMutableArray<UIViewController*>*)controllers Index:(NSInteger)index block:(TabSwitchBlcok) tabSwitch;
//空手势 在这里起手势锁的作用 在适当的时候禁用UIPageViewController中pan手势  实现既有侧滑返回又无弹簧效果
@property (nonatomic,strong)UIPanGestureRecognizer *fakePan;
@end
