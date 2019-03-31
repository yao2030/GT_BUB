//  Created by Aalto on 2018/12/23.
//  Copyright © 2018 Aalto. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PostAppealSubDataItem;
@interface PostAppealCell : UITableViewCell
- (void)actionBlock:(TwoDataBlock)block;
- (void)txActionBlock:(DataBlock)block;
+(CGFloat)cellHeightWithModel:(id)model;
+(instancetype)cellWith:(UITableView*)tableView;
- (void)richElementsInCellWithModel:(id)model;
@end
