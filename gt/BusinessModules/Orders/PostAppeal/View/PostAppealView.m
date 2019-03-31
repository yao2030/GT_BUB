//
//  PostAdsView.m
//  gtp
//
//  Created by Aalto on 2018/11/19.
//  Copyright © 2018 Aalto. All rights reserved.
//

#import "PostAppealView.h"
#import "PostAppealCell.h"

#import "PostAdsReplyCell.h"

#import "BaseCell.h"

#import "PostAppealSectionHeaderView.h"

#import "PostAppealVM.h"
#import "PickerPopUpView.h"

@interface PostAppealView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSUInteger currentPage;
@property (nonatomic, strong) NSMutableArray *sections;

@property (nonatomic, copy) TwoDataBlock block;
@property (nonatomic, copy) NSString*  remark;
@property (nonatomic, copy) NSString*  pickTag;
@property (nonatomic, copy) NSString*  contactTx;
@end

@implementation PostAppealView

#pragma mark - life cycle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = kWhiteColor;
        [self initViews];
        
        [self.tableView.mj_header beginRefreshing];
        
        
    }
    return self;
}

- (void)initViews {
    [self addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self);
        make.top.left.right.mas_equalTo(self).offset(0);
        make.bottom.mas_equalTo(self.mas_bottom).offset([YBSystemTool isIphoneX]? -[YBFrameTool tabBarHeight]:-48.5);
    }];
    
    
    [self bottomDoubleButtonInSuperView:self leftButtonEvent:^(id data) {
        if (self.block) {
            self.block(@(EnumActionTag0), data);
        }
    } rightButtonEvent:^(id data) {
        NSString* remark = ![NSString isEmpty:self.remark]?self.remark:@"";
        NSString* pickTag = ![NSString isEmpty:self.pickTag]?self.pickTag:@"";
        NSString* contactTx = ![NSString isEmpty:self.contactTx]?self.contactTx:@"";
        if ([NSString isEmpty:pickTag]||[pickTag isEqualToString:@"0"]) {
            [YKToastView showToastText:@"请选择申诉原因"];
            return ;
        }
        if ([NSString isEmpty:contactTx]) {
            [YKToastView showToastText:@"请填写联系方式"];
            return ;
        }
        if (self.block) {
            self.block(@(EnumActionTag1), @[remark,pickTag,contactTx]);
        }
    }];
}

#pragma mark - public
- (void)requestListSuccessWithArray:(NSArray *)array {
    
    if (array.count > 0) {
        if (self.currentPage == 0) {
            [self.sections removeAllObjects];
        }
        [self.sections addObjectsFromArray:array];
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    } else {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
    [self.tableView.mj_header endRefreshing];
    
    _tableView.tableFooterView.backgroundColor = kWhiteColor;
}

- (void)requestListFailed {
    self.currentPage = 0;
    [self.sections removeAllObjects];
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

#pragma mark - <UITableViewDataSource, UITableViewDelegate>
#pragma mark - Sectons
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _sections.count;
}
#pragma mark - Rows
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section >= _sections.count) {
        section = _sections.count - 1;
    }
//    IndexSectionType type = [(_sections[section])[kIndexSection] integerValue];
    return [(_sections[section])[kIndexRow] count];
}

#pragma mark - SectonHeader
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section >= _sections.count) {
        section = _sections.count - 1;
    }
    
    IndexSectionType type = [(_sections[section])[kIndexSection] integerValue];
    switch (type) {
        case IndexSectionZero:
            return 5;
            break;
        case IndexSectionOne:
            return [PostAppealSectionHeaderView viewHeight];
            break;
        default:
            return 0.1f;
            break;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if(section >= _sections.count) {
        section = _sections.count - 1;
    }
    IndexSectionType type = [(_sections[section])[kIndexSection] integerValue];
    switch (type) {
        case IndexSectionOne: {
            NSDictionary* model = (NSDictionary*)(_sections[section]);
            PostAppealSectionHeaderView * sectionHeaderView = (PostAppealSectionHeaderView *)[_tableView dequeueReusableHeaderFooterViewWithIdentifier:PostAppealSectionHeaderReuseIdentifier];
            [sectionHeaderView richElementsInViewWithModel:model];
            
            return sectionHeaderView;
        }
            break;
        
        default:
            return [UIView new];
            break;
            
    }
    
}

#pragma mark - SectonFooter
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section >= _sections.count) {
        section = _sections.count - 1;
    }
    
    IndexSectionType type = [(_sections[section])[kIndexSection] integerValue];
    
    switch (type) {
        case IndexSectionOne:
            return [PostAppealSectionFooterView viewHeightWithType:type];
            break;
        default:
            return 0.1f;
            break;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section >= _sections.count) {
        section = _sections.count - 1;
    }
    IndexSectionType type = [(_sections[section])[kIndexSection] integerValue];
    switch (type) {
        case IndexSectionOne: {
            NSDictionary* model = (NSDictionary*)(_sections[section]);
            PostAppealSectionFooterView * sectionHeaderView = (PostAppealSectionFooterView *)[_tableView dequeueReusableHeaderFooterViewWithIdentifier:PostAppealSectionFooterReuseIdentifier];
            [sectionHeaderView actionBlock:^(id data, id data2) {
                
            }];
            [sectionHeaderView richElementsInViewWithModel:model];
            
            return sectionHeaderView;
        }
            break;
            
        default:
            return [UIView new];
            break;
            
    }
    
    return nil;
}
#pragma mark - cellForRow
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WS(weakSelf);
    
    NSInteger section = indexPath.section;
    if(section >= _sections.count)
    section = _sections.count - 1;
    
    IndexSectionType type = [_sections[section][kIndexSection] integerValue];
    id itemData = ((_sections[section])[kIndexRow])[indexPath.row];
    switch (type) {
        case IndexSectionZero:
        {
            PostAppealCell *cell = [PostAppealCell cellWith:tableView];
            [cell richElementsInCellWithModel:itemData];
            [cell actionBlock:^(id data,id data2) {
                UIButton* pickerButton=(UIButton*)data;
                PickerPopUpView* popupView = [[PickerPopUpView alloc]init];
                [popupView richElementsInViewWithModel:data2];
                [popupView showInApplicationKeyWindow];
                [popupView actionBlock:^(id data) {
                    NSDictionary* dic = data;
                    [pickerButton setTitle:[NSString stringWithFormat:@"     %@",dic.allValues[0]] forState:UIControlStateNormal];
                    weakSelf.pickTag = dic.allKeys[0];
                }];
            }];
            [cell txActionBlock:^(id data) {
                weakSelf.contactTx = data;
            }];
            return cell;
            
        }
            break;
        case IndexSectionOne:
        {
            PostAdsReplyCell *cell = [PostAdsReplyCell cellWith:tableView];
            
            NSDictionary* paysDic = (NSDictionary*)itemData;
            //            WData* wData = (WData*)itemData;
            [cell richElementsInCellWithModel:paysDic];
            [cell actionBlock:^(id data) {
                //        if (self.block) {
                //            self.block(data);
                //        }
                weakSelf.remark = data;
            }];
            return cell;
        }
            break;
        default:{
            BaseCell *cell = [BaseCell cellWith:tableView];
            cell.hideSeparatorLine = YES;
            cell.frame = CGRectZero;
            return cell;
        }
            break;
    }
}

#pragma mark - heightForRow
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    if(section >= _sections.count)
    section = _sections.count - 1;
    
    IndexSectionType type = [_sections[section][kIndexSection] integerValue];
    id itemData = ((_sections[section])[kIndexRow])[indexPath.row];
    switch (type) {
        case IndexSectionZero:
            return [PostAppealCell cellHeightWithModel:itemData];
            break;
            
        case IndexSectionOne:
        {
            return [PostAdsReplyCell cellHeightWithModel:itemData];
        }
            break;
        default:
            return 0;
            break;
    }
}
- (void)actionBlock:(TwoDataBlock)block
{
    self.block = block;
}

#pragma mark - getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
//        [_tableView YBGeneral_configuration];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [PostAppealSectionHeaderView sectionHeaderViewWith:_tableView];
        [PostAppealSectionFooterView sectionFooterViewWith:_tableView];
       kWeakSelf(self);
        [_tableView YBGeneral_addRefreshHeader:^{
            kStrongSelf(self);
            self.currentPage = 0;
            [self.delegate postAppealView:self requestListWithPage:self.currentPage];
        }
//                                        footer:^{
//            kStrongSelf(self);
//            ++self.currentPage;
//            [self.delegate homeView:self requestHomeListWithPage:self.currentPage];
//        }
         ];
    }
    return _tableView;
}

- (NSUInteger)currentPage {
    if (!_currentPage) {
        _currentPage = 0;
    }
    return _currentPage;
}

- (NSMutableArray *)sections {
    if (!_sections) {
        _sections = [NSMutableArray array];
    }
    return _sections;
}

@end
