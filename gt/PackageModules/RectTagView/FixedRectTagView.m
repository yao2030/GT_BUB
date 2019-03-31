//
//  PHTagView.m
//  TagUtilViews
//
//  Created by AaltoChen on 16/8/23.
//  Copyright © 2016年 Aalto. All rights reserved.
//

#import "FixedRectTagView.h"

@implementation FixedRectTagView
-(instancetype)initBtnWithFrame:(CGRect)frame isFixedBtnWidth:(BOOL)isFixed withTitleArray:(NSArray*)titleArray{
    if (self = [super initWithFrame:frame]) {
        _btns = [NSMutableArray array];
        CGFloat midMargin = 22.f;
        
        int itmesInLines = 4;//(IS_IPHONE4 || IS_IPHONE5)?3:4
        
        CGFloat btnHeight = 35.f;
        
        CGFloat lRMargin = 0; //7.f;
        CGFloat uDMargin = 18.f;
        
        CGFloat btnWith = (frame.size.width -2*lRMargin -(itmesInLines-1)*midMargin)/itmesInLines;//68;
        
        
        int width = 0;
        int height = 0;
        int number = 0;
        int han = 0;
        if ([titleArray isKindOfClass:[NSArray class]]) {
            //创建button
            for (int i = 0; i < titleArray.count; i++) {
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.tag =  i;
                
                if (isFixed) {
                    button.frame = CGRectMake((i%itmesInLines+1)==1?lRMargin+i%itmesInLines*btnWith:
                                              lRMargin+(i%itmesInLines)*midMargin+i%itmesInLines*btnWith, ((i/itmesInLines)+1)*uDMargin+(i/itmesInLines)*btnHeight, btnWith, btnHeight);
                }else{
                    CGSize titleSize = [titleArray[i] boundingRectWithSize:CGSizeMake(MAXFLOAT, 35) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil].size;
                    titleSize.width += 20;
                    //自动的折行
                    han = han +titleSize.width+10;
                    if (han > MAINSCREEN_WIDTH) {
                        han = 0;
                        han = han + titleSize.width;
                        height++;
                        width = 0;
                        width = width+titleSize.width;
                        number = 0;
                        button.frame = CGRectMake(10, 50*height, titleSize.width, 35);
                    } else {
                        button.frame = CGRectMake(width+10+(number*10), 50*height, titleSize.width, 35);
                        width = width+titleSize.width;
                    }
                    number++;
                }
                
                
                
                
                
                
                
                button.titleLabel.font = [UIFont systemFontOfSize:18];
                button.layer.masksToBounds = YES;
                button.layer.cornerRadius = 17.5;
                button.layer.borderWidth = 0.5;
                button.layer.borderColor = RGBCOLOR(225, 218, 216).CGColor;
                [button setTitle:titleArray[i] forState:UIControlStateNormal];
                [button setTitleColor:HEXCOLOR(0x394368) forState:UIControlStateNormal];
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
                
                [button setBackgroundImage:[UIImage imageWithColor:HEXCOLOR(0xf2f1f6)] forState:UIControlStateNormal];
                [button setBackgroundImage:[UIImage imageWithColor:[YBGeneralColor themeColor]] forState:UIControlStateSelected];
                
                //button.backgroundColor = [UIColor clearColor];
                
                
                button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
                [button addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
                
                [self addSubview:button];
                [_btns addObject:button];
            }
            UIButton* tagBtn = (UIButton*)[self viewWithTag:titleArray.count-1];
            CGRect vframe = self.frame;
            vframe.size.height = tagBtn.frame.origin.y+tagBtn.frame.size.height;
            self.frame =  vframe;
        }

    }
    return self;
}
+(UIView *)creatBtnWithFrame:(CGRect)frame isFixedBtnWidth:(BOOL)isFixed withTitleArray:(NSArray*)titleArray{
    
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width , 0)];
    view.backgroundColor = [UIColor whiteColor];
    
    CGFloat midMargin = 22.f;
    
    int itmesInLines = 4;//(IS_IPHONE4 || IS_IPHONE5)?3:4
    
    CGFloat btnHeight = 35.f;
    
    CGFloat lRMargin = 0; //7.f;
    CGFloat uDMargin = 18.f;
    
    CGFloat btnWith = (frame.size.width -2*lRMargin -(itmesInLines-1)*midMargin)/itmesInLines;//68;
    
    int width = 0;
    int height = 0;
    int number = 0;
    int han = 0;
    if ([titleArray isKindOfClass:[NSArray class]]) {
        //创建button
        for (int i = 0; i < titleArray.count; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag =  i;
            
            if (isFixed) {
                button.frame = CGRectMake((i%itmesInLines+1)==1?lRMargin+i%itmesInLines*btnWith:lRMargin+(i%itmesInLines)*midMargin+i%itmesInLines*btnWith, ((i/itmesInLines)+1)*uDMargin+(i/itmesInLines)*btnHeight, btnWith, btnHeight);
            }else{
                CGSize titleSize = [titleArray[i] boundingRectWithSize:CGSizeMake(MAXFLOAT, 35) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil].size;
                titleSize.width += 20;
                //自动的折行
                han = han +titleSize.width+10;
                if (han > MAINSCREEN_WIDTH) {
                    han = 0;
                    han = han + titleSize.width;
                    height++;
                    width = 0;
                    width = width+titleSize.width;
                    number = 0;
                    button.frame = CGRectMake(10, 50*height, titleSize.width, 30);
                } else {
                    button.frame = CGRectMake(width+10+(number*10), 50*height, titleSize.width, 30);
                    width = width+titleSize.width;
                }
                number++;
            }
            
            
            
            
            
            
            
            button.titleLabel.font = [UIFont systemFontOfSize:18];
            button.layer.masksToBounds = YES;
            button.layer.cornerRadius = 17.5;
            button.layer.borderWidth = 0.5;
            button.layer.borderColor = RGBCOLOR(225, 218, 216).CGColor;
            [button setTitle:titleArray[i] forState:UIControlStateNormal];
            [button setTitleColor:HEXCOLOR(0x394368) forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            
            [button setBackgroundImage:[UIImage imageWithColor:HEXCOLOR(0xf2f1f6)] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageWithColor:[YBGeneralColor themeColor]] forState:UIControlStateSelected];
            
            //button.backgroundColor = [UIColor clearColor];
            
            
            button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            [button addTarget:self action:@selector(clickYammy:) forControlEvents:UIControlEventTouchUpInside];
            
            [view addSubview:button];
        }
        UIButton* tagBtn = (UIButton*)[view viewWithTag:titleArray.count-1];
        CGRect vframe = view.frame;
        vframe.size.height = tagBtn.frame.origin.y+tagBtn.frame.size.height;
        view.frame =  vframe;
    }
    
    return view;
}

- (void)clearSelecedBtn{
    for (UIButton *btn in self.btns) {
        btn.selected = NO;
    }
}

- (void)selecedBtn:(NSString*)btnTit{
    int intString = [btnTit intValue];
    NSString *stringInt = [NSString stringWithFormat:@"%d",intString];
    for (UIButton *btn in self.btns) {
        btn.selected = NO;
        if ([btn.titleLabel.text isEqualToString:stringInt]) {//same tagBtn
            btn.selected = YES;
        }

    }
}

- (void)clickItem:(UIButton*)button{
    NSString* btnTit = @"";//only one,can no one
    button.selected = !button.selected;
    if (button.selected) {
        for (UIButton *btn in self.btns) {
            btn.selected = NO;
//            if (btn.tag == button.tag) {//same tagBtn
//                btn.selected = YES;
//            }
        }
        UIButton *tagBtn = [self.btns objectAtIndex:button.tag];
        tagBtn.selected = YES;
        
////only one,can no one 2
//        for (UIButton *btn in _btns) {
//            btn.selected = NO;
//            [btn setTitleColor:HEXCOLOR(0x4a4a4a) forState:UIControlStateNormal];
//            [btn setImage:[UIImage imageNamed:@"checkbox"] forState:UIControlStateNormal];
//        }
//
//        UIButton *tagBtn = [_btns objectAtIndex:button.tag];
//        tagBtn.selected = YES;
//
//        [tagBtn setTitleColor:HEXCOLOR(0x4c7fff) forState:UIControlStateNormal];
//        [tagBtn setImage:[UIImage imageNamed:@"checkbox-checked"] forState:UIControlStateNormal];
        
        btnTit = button.titleLabel.text;
    } else {
        //only one,cannot no one
//        button.selected = YES;
//        btnTit = button.titleLabel.text;
        
        
//        for (UIButton *btn in _btns) {
//            btn.selected = NO;
//            [btn setTitleColor:HEXCOLOR(0x4a4a4a) forState:UIControlStateNormal];
//            [btn setImage:[UIImage imageNamed:@"checkbox"] forState:UIControlStateNormal];
//        }

        btnTit = @"";
    }

    if (self.clickSectionBlock) {
        self.clickSectionBlock(button,btnTit);
        //.clickSectionBlock = ^(NSInteger *sec, NSString* btnTit){
    }
}
+ (void)clickYammy:(UIButton*)button{
    button.selected = !button.selected;
    NSLog(@"%ld",(long)button.tag);
}


@end
