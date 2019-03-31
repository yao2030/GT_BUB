//
//  CancelTipPopUpView.m
//  gtp
//
//  Created by Aalto on 2018/12/30.
//  Copyright © 2018 Aalto. All rights reserved.
//

#import "CancelTipPopUpView.h"
#define XHHTuanNumViewHight 260
#define XHHTuanNumViewWidth 306
@interface CancelTipPopUpView()<UIGestureRecognizerDelegate>
@property(nonatomic,strong)UIView *contentView;
@property (nonatomic, strong) UIImageView *line1;
@property (nonatomic, strong) NSMutableArray* leftLabs;

@property (nonatomic, copy) ActionBlock block;
@property (nonatomic, assign) CGFloat contentViewHeigth;

@property (nonatomic, strong) NSMutableArray *btns;
@property (nonatomic, strong) NSMutableArray *funcBtns;
@property (nonatomic, strong) UIButton *checkButton;
@property (nonatomic, strong) UIButton *singleSureButton;
@end

@implementation CancelTipPopUpView

- (id)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        
        [self setupContent];
    }
    
    return self;
}

- (void)setupContent {
    _leftLabs = [NSMutableArray array];
    
    _funcBtns = [NSMutableArray array];
    
    self.frame = CGRectMake(0, 0, MAINSCREEN_WIDTH, MAINSCREEN_HEIGHT);
    
    self.backgroundColor = COLOR_HEX(0x000000, .8);
    self.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disMissView)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    _contentViewHeigth = XHHTuanNumViewHight;
    if (_contentView == nil) {
        _contentView = [[UIView alloc]initWithFrame:CGRectMake((MAINSCREEN_WIDTH - XHHTuanNumViewWidth)/2, (MAINSCREEN_HEIGHT - _contentViewHeigth)/2, XHHTuanNumViewWidth, _contentViewHeigth)];
        _contentView.layer.cornerRadius = 6;
        _contentView.layer.masksToBounds = YES;
        _contentView.userInteractionEnabled = YES;
        _contentView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_contentView];
        // 右上角关闭按钮
        UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        closeBtn.frame = CGRectMake(_contentView.width -  90, 0, 90, 47);
        closeBtn.titleLabel.font = kFontSize(15);
        [closeBtn setTitleColor:HEXCOLOR(0x666666) forState:UIControlStateNormal];
        [closeBtn setTitle:@"取消" forState:UIControlStateNormal];
//        [closeBtn addTarget:self action:@selector(disMissView) forControlEvents:UIControlEventTouchUpInside];
        [closeBtn addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disMissView)]];
//        [_contentView addSubview:closeBtn];
        
        // 左上角关闭按钮
        UIButton *saftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        saftBtn.frame = CGRectMake(0, 0, _contentView.width, 47);
        saftBtn.titleLabel.font = kFontSize(17);
        [saftBtn setTitleColor:HEXCOLOR(0x232630) forState:UIControlStateNormal];
        [saftBtn setTitle:@"取消订单" forState:UIControlStateNormal];
        saftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_contentView addSubview:saftBtn];
        
        _line1 = [[UIImageView alloc]init];
        [self.contentView addSubview:_line1];
        _line1.backgroundColor = HEXCOLOR(0xe8e9ed);

        [_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(@0);
            make.trailing.equalTo(@0);
            make.top.offset(48);
            make.height.equalTo(@3);
        }];
        
        [self layoutAccountPublic];
        
    }
}

-(void)layoutAccountPublic{
    _btns = [NSMutableArray array];
    
    for (int i = 0; i < 2; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        button.tag =  i;
        button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        button.titleLabel.numberOfLines = 0;
        //            [button addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:button];
        [_btns addObject:button];
    }
    UIButton* bt1 =_btns[1];
    [_btns mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:15 leadSpacing:68 tailSpacing:116];
    
    [_btns mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@20);
        make.trailing.equalTo(@-20);
        make.height.mas_equalTo(@30);
    }];
    
    self.checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.checkButton.tag =  EnumActionTag0;
    self.checkButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    self.checkButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    self.checkButton.titleLabel.numberOfLines = 0;
    
    [self.contentView addSubview:self.checkButton];
    [self.checkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(@0);
        make.top.mas_equalTo(bt1.mas_bottom).offset(28);
        make.height.equalTo(@20);
    }];
    [self.checkButton addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(funAdsButtonClickItem:)]];
    self.checkButton.adjustsImageWhenHighlighted = NO;

    

    NSArray* subtitleArray =@[@"稍后再说",@"取消订单"];
    for (int i = 0; i < subtitleArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag =  i+1;
        button.adjustsImageWhenHighlighted = NO;
        button.titleLabel.font = kFontSize(16);
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 6;
        button.layer.borderWidth = 1;
        
        [button setTitle:subtitleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:HEXCOLOR(0x333333) forState:UIControlStateNormal];
        button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//        [button addTarget:self action:@selector(funAdsButtonClickItem:) forControlEvents:UIControlEventTouchUpInside];
        [button addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(funAdsButtonClickItem:)]];
        [self.contentView addSubview:button];
        [_funcBtns addObject:button];
        //        [_fucBtns[i] layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:10];
    }
    UIButton* btn0 =_funcBtns.firstObject;
    [btn0 setBackgroundImage:[UIImage imageWithColor:HEXCOLOR(0xffffff)] forState:UIControlStateNormal];
    [btn0 setTitleColor:HEXCOLOR(0x4c7fff) forState:UIControlStateNormal];
    btn0.layer.borderColor = HEXCOLOR(0x4c7fff).CGColor;


    UIButton* btn1 =_funcBtns.lastObject;
    [btn1 setBackgroundImage:[UIImage imageWithColor:HEXCOLOR(0x9b9b9b)] forState:UIControlStateNormal];
    [btn1 setTitleColor:HEXCOLOR(0xf7f9fa) forState:UIControlStateNormal];
    
    [btn1 setBackgroundImage:[UIImage imageWithColor:HEXCOLOR(0x4c7fff)] forState:UIControlStateSelected];
    [btn1 setTitleColor:HEXCOLOR(0xffffff) forState:UIControlStateSelected];
    btn1.layer.borderColor = kClearColor.CGColor;

    [_funcBtns mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:12 leadSpacing:24 tailSpacing:24];

    [_funcBtns mas_makeConstraints:^(MASConstraintMaker *make) {
    make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-18);
        make.height.equalTo(@40);
    }];
}

- (void)actionBlock:(ActionBlock)block
{
    self.block = block;
}

- (void)funAdsButtonClickItem:(UITapGestureRecognizer*)btn{
    EnumActionTag tag = btn.view.tag;
    switch (tag) {
        case EnumActionTag0:
            {
            NSString* btnTit = @"";
            UIButton* button = (UIButton*)[btn view] ;
            UIButton* funcBtn1 =_funcBtns.lastObject;
            
            button.selected = !button.selected;
            if (button.selected) {
                //        for (UIButton *btn in self.btns) {
                //            btn.selected = NO;
                //        }
                btnTit = button.titleLabel.text;
                
                [button setTitleColor:HEXCOLOR(0x4c7fff) forState:UIControlStateNormal];
                
                [button setImage:[UIImage imageNamed:@"checkbox-checked"] forState:UIControlStateNormal];
                
                funcBtn1.selected = YES;
                funcBtn1.userInteractionEnabled = YES;
            } else {
                btnTit = @"";
                
                [button setTitleColor:HEXCOLOR(0x4a4a4a) forState:UIControlStateNormal];
                [button setImage:[UIImage imageNamed:@"checkbox"] forState:UIControlStateNormal];
                
                funcBtn1.selected = NO;
                funcBtn1.userInteractionEnabled = NO;
            }
            //        SetUserBoolKeyWithObject(kIsBuyTip, button.selected);
            //        UserDefaultSynchronize;
            }
            break;
        case EnumActionTag1:
        {
            [self disMissView];
        }
            break;
        case EnumActionTag2:
        {
            UIButton* funcBtn1 =_funcBtns.lastObject;
            if (funcBtn1.selected
                &&funcBtn1.userInteractionEnabled) {
                [self disMissView];
                if (self.block) {
                    self.block(@(btn.view.tag));
                }
            }
            
        }
            break;
        default:
            break;
    }
}

- (void)richElementsInViewWithModel:(id)model{
    UIButton* bt0 =_btns[0];
    UIButton* bt1 =_btns[1];
    
    [bt0 setTitleColor:HEXCOLOR(0x333333) forState:UIControlStateNormal];
    bt0.titleLabel.font = kFontSize(15);
    [bt0 setTitle:@"如已转账付款给卖家，请慎重取消订单，否则款项可能无法追回。" forState:UIControlStateNormal];
    
    [bt1 setTitleColor:HEXCOLOR(0x4a4a4a) forState:UIControlStateNormal];
    bt1.titleLabel.font = kFontSize(12);
    [bt1 setTitle:[NSString stringWithFormat:@"取消规则：当日累计取消%s笔，会限制当日买入功能。","3"] forState:UIControlStateNormal];
    
    
    [self.checkButton setTitle:@"我确认还没有付款" forState:UIControlStateNormal];
    [self.checkButton setTitleColor:HEXCOLOR(0x4a4a4a) forState:UIControlStateNormal];
    [self.checkButton setTitleColor:HEXCOLOR(0x4c7fff) forState:UIControlStateSelected];
//    [self.checkButton setImage:[UIImage imageNamed:@"icon_check"] forState:UIControlStateNormal];
    [self.checkButton setImage:[UIImage imageNamed:@"checkbox"] forState:UIControlStateNormal];
    [self.checkButton setImage:[UIImage imageNamed:@"checkbox-checked"] forState:UIControlStateSelected];
    [self.checkButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:7];
    
//    self.checkButton.selected = NO;
    UIButton* btn1 =_funcBtns.lastObject;
    btn1.selected = NO;
    btn1.userInteractionEnabled = NO;
//    SetUserBoolKeyWithObject(kIsBuyTip, YES);
//    UserDefaultSynchronize;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isKindOfClass:[UIButton class]])
    {
        return NO;
    }
    return YES;
}

- (void)showInApplicationKeyWindow{
    [self showInView:[UIApplication sharedApplication].keyWindow];
    
    //    [popupView showInView:self.view];
    //
    //    [popupView showInView:[UIApplication sharedApplication].keyWindow];
    //
    //    [[UIApplication sharedApplication].keyWindow addSubview:popupView];
}

- (void)showInView:(UIView *)view {
    if (!view) {
        return;
    }
    
    [view addSubview:self];
    [view addSubview:_contentView];
    
    [_contentView setFrame:CGRectMake((MAINSCREEN_WIDTH - XHHTuanNumViewWidth)/2, MAINSCREEN_HEIGHT, XHHTuanNumViewWidth, _contentViewHeigth)];
    WS(weakSelf);
    [UIView animateWithDuration:0.3 animations:^{
        
        weakSelf.alpha = 1.0;
        
        [weakSelf.contentView setFrame:CGRectMake((MAINSCREEN_WIDTH - XHHTuanNumViewWidth)/2, (MAINSCREEN_HEIGHT - weakSelf.contentViewHeigth)/2,XHHTuanNumViewWidth,weakSelf.contentViewHeigth)];
        
    } completion:nil];
}

//移除从上向底部弹下去的UIView（包含遮罩）
- (void)disMissView {
    WS(weakSelf);
    [_contentView setFrame:CGRectMake((MAINSCREEN_WIDTH - XHHTuanNumViewWidth)/2, (MAINSCREEN_HEIGHT - _contentViewHeigth)/2, XHHTuanNumViewWidth, _contentViewHeigth)];
    [UIView animateWithDuration:0.3f
                     animations:^{
                         
                         weakSelf.alpha = 0.0;
                         
                         [weakSelf.contentView setFrame:CGRectMake((MAINSCREEN_WIDTH - XHHTuanNumViewWidth)/2, MAINSCREEN_HEIGHT, XHHTuanNumViewWidth, weakSelf.contentViewHeigth)];
                     }
                     completion:^(BOOL finished){
                         
                         [weakSelf removeFromSuperview];
                         [weakSelf.contentView removeFromSuperview];
                         
                     }];
    
}
@end

