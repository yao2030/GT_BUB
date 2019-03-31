//  Created by Aalto on 2018/12/28.
//  Copyright © 2018 Aalto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataStatisticsVM.h"

static NSString *DataStatisticsSectionHeaderReuseIdentifier = @"DataStatisticsSectionHeaderView";
static NSString *DataStatisticsSectionFooterReuseIdentifier = @"DataStatisticsSectionFooterView";

@protocol DataStatisticsSectionHeaderViewDelegate <NSObject>

@optional
-(void)sectionHeaderSubBtnClickTag:(UIButton*)sender;
@end

@interface DataStatisticsSectionHeaderView : UITableViewHeaderFooterView
@property(nonatomic,weak)id<DataStatisticsSectionHeaderViewDelegate> delegate;
+ (CGFloat)viewHeight;
- (void)setDataWithType:(IndexSectionType)type withTitle:(NSString*)title  withSubTitle:(NSString*)subTitle ;
+ (void)sectionHeaderViewWith:(UITableView*)tableView;
@property (copy, nonatomic) void(^clickSectionBlock)(NSString* sec);

@end

@interface DataStatisticsSectionFooterView : UITableViewHeaderFooterView

- (void)setDataWithType:(IndexSectionType)type withTitle:(NSString*)title withSubTitle:(NSString*)subTitle;
+ (void)sectionFooterViewWith:(UITableView*)tableView;
- (void)loadButtonTitle:(NSString*)string;
- (void)moreActionBlock:(DataBlock)block;
+ (CGFloat)viewHeight;

@end
