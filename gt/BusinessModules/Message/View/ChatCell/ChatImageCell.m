//
//  ChatImageCell.m
//  gt
//
//  Created by cookie on 2018/12/31.
//  Copyright © 2018 GT. All rights reserved.
//

#import "ChatImageCell.h"

@implementation ChatImageCell

-(void)initSSChatCellUserInterface{
    
    [super initSSChatCellUserInterface];
    
    self.mImgView = [UIImageView new];
    self.mImgView.layer.cornerRadius = 5;
    self.mImgView.layer.masksToBounds  = YES;
    self.mImgView.contentMode = UIViewContentModeScaleAspectFill;
    self.mImgView.backgroundColor = [UIColor whiteColor];
    [self.mBackImgButton addSubview:self.mImgView];
    
}


-(void)setLayout:(ChatMessageLayout *)layout{
    [super setLayout:layout];
    
    UIImage *image = [UIImage imageNamed:layout.message.backImgString];
    image = [image resizableImageWithCapInsets:layout.imageInsets resizingMode:UIImageResizingModeStretch];
    self.mBackImgButton.frame = layout.backImgButtonRect;
    [self.mBackImgButton setBackgroundImage:image forState:UIControlStateNormal];
    
    
    self.mImgView.frame = self.mBackImgButton.bounds;
    self.mImgView.image = self.layout.message.image;
    self.mImgView.contentMode = self.layout.message.contentMode;
    
    
    //给图片设置一个描边 描边跟背景按钮的气泡图片一样
    UIImageView *btnImgView = [[UIImageView alloc]initWithImage:image];
    btnImgView.frame = CGRectInset(self.mImgView.frame, 0.0f, 0.0f);
    self.mImgView.layer.mask = btnImgView.layer;
    
}


//点击展开图片
-(void)buttonPressed:(UIButton *)sender{
//    if(self.delegate && [self.delegate respondsToSelector:@selector(SSChatImageVideoCellClick:layout:)]){
//        [self.delegate SSChatImageVideoCellClick:self.indexPath layout:self.layout];
//    }
}
@end
