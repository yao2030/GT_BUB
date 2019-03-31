//
//  InputPWPopUpView.h
//  gtp
//
//  Created by Aalto on 2018/12/30.
//  Copyright © 2018 GT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InputPWPopUpView : UIView
- (void)richElementsInViewWithModel;//:(id)paysDic
- (void)actionBlock:(ActionBlock)block;
- (void)disMissActionBlock:(ActionBlock)disMissBlock;
- (void)showInApplicationKeyWindow;
- (void)showInView:(UIView *)view;
- (id)initWithFrame:(CGRect)frame WithIsForceShowGoogleCodeField:(BOOL)isForceShowGoogleCodeField;

@end

NS_ASSUME_NONNULL_END
