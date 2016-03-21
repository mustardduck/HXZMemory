//
//  CustomerQuestionsViewController.m
//  miaozhuan
//
//  Created by 孙向前 on 14-11-18.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "CustomerQuestionsViewController.h"
#import "CustomBaseCell.h"
#import "MoreChooseCell.h"
#import "CustomAgeCell.h"
#import "SingleChooseCell.h"
#import "BaserHoverView.h"
#import "RRLineView.h"

@interface CustomerQuestionsViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{
    NSInteger _currentRow;//判断性别单选
    NSMutableArray *_selectSections;
}

@property (retain, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, retain) NSArray *dataArray;//所有数据
@property (nonatomic, retain) NSDictionary *sexDic;//sex数据

@property(nonatomic, retain) NSMutableArray *itemArray;//选项集合

@property (nonatomic, retain) NSArray *ageRegion;//年龄范围

@property (nonatomic, copy) NSString *minAge;
@property (nonatomic, copy) NSString *maxAge;

@property (nonatomic, assign) BOOL doubles;
@property (nonatomic, assign) BOOL singles;
@property (nonatomic, assign) BOOL nones;

@end

@implementation CustomerQuestionsViewController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setNavigateTitle:_navTitle];
    [self setupMoveBackButton];
    
    [self _initData];
    [self setExtraCellLineHidden:_tableView];
    
    _selectSections = [[NSMutableArray alloc] initWithCapacity:0];
    
    ADAPI_DirectAdvert_CustomerQuestion([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleCustomQuestion:)], (int)_type);
    
    _tableView.panGestureRecognizer.delaysTouchesBegan = YES;
    
    self.ageRegion = [NSArray array];
    
}
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 10));
     RRLineView *linebottom = WEAK_OBJECT(RRLineView, initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 1));
    view.backgroundColor = AppColorBackground;
    [view addSubview:linebottom];
    [tableView setTableFooterView:view];
}
- (void)_initData{
 
    if (!_type) {
        
        _tableView.hidden = NO;
        
        if (_doubles) {
            
            self.sexDic = @{
                            @"Answer":@[
                                    @{@"OptionId":@"0",@"Answer":@"不限"},
                                    @{@"OptionId":@"1",@"Answer":@"男"},
                                    @{@"OptionId":@"2",@"Answer":@"女"}
                                    ]};
            NSString *sex = [[NSUserDefaults standardUserDefaults] valueForKey:@"CustomQuestionSex"];
            
            _currentRow = -1;
            if (sex.length) {
                _currentRow =  [sex integerValue];
            }
            
            self.ageRegion = [[NSUserDefaults standardUserDefaults] valueForKey:@"CustomQuestionAge"];
            
        } else if (_singles) {
            
            self.ageRegion = [[NSUserDefaults standardUserDefaults] valueForKey:@"CustomQuestionAge"];
        }
    }

    NSArray *temp = [[NSUserDefaults standardUserDefaults] valueForKey:@"PostOptions"];
    self.itemArray = [NSMutableArray arrayWithArray:temp];
}

#pragma mark - 网络数据请求回调
- (void)handleCustomQuestion:(DelegatorArguments *)arguments{
    DictionaryWrapper* dic = arguments.ret;
    if (dic.operationSucceed) {
        if (dic.data) {
            self.dataArray = [dic.data getArray:@"Questions"];
            if (!_type) {
                self.doubles = [dic.data getBool:@"HasGander"] && [dic.data getBool:@"HasAge"];
                self.singles = [dic.data getBool:@"HasGander"] || [dic.data getBool:@"HasAge"];
            }
            [self _initData];
            _tableView.hidden = NO;
             [self.tableView reloadData];
        } else {
            [self createHoverViewWhenNoData];
        }
    } else {
        
        [HUDUtil showErrorWithStatus:dic.operationMessage];
        return;
    }
}

#pragma mark - UITableViewDelegate/UITableViewDatasource
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 40));
    view.backgroundColor = [UIColor clearColor];
    UILabel *lbltitle = WEAK_OBJECT(UILabel, initWithFrame:CGRectMake(15, 12, 250, 20));
    lbltitle.font = Font(14);
    lbltitle.textColor = RGBCOLOR(153, 153, 153);
    if (!_type) {
        
        if (_doubles) {
            if (!section) {
                lbltitle.text = @"年龄";
            } else if (section == 1) {
                lbltitle.text = @"性别";
            } else {
                NSString *title = [[_dataArray[section - 2] wrapper] getString:@"Question"];
                if ([[_dataArray[section - 2] wrapper] getInt:@"Type"]) {
                    lbltitle.text = [NSString stringWithFormat:@"%@(多选)",title];
                } else {
                    lbltitle.text = title;
                }
            }
        } else if (_singles) {
            if (!section) {
                lbltitle.text = @"年龄";
            } else {
                NSString *title = [[_dataArray[section - 1] wrapper] getString:@"Question"];
                if ([[_dataArray[section - 1] wrapper] getInt:@"Type"]) {
                    lbltitle.text = [NSString stringWithFormat:@"%@(多选)",title];
                } else {
                    lbltitle.text = title;
                }
            }
        } else {
            NSString *title = [[_dataArray[section] wrapper] getString:@"Question"];
            if ([[_dataArray[section] wrapper] getInt:@"Type"]) {
                lbltitle.text = [NSString stringWithFormat:@"%@(多选)",title];
            } else {
                lbltitle.text = title;
            }
        }
        
        
    } else {
        NSString *title = [[_dataArray[section] wrapper] getString:@"Question"];
        if ([[_dataArray[section] wrapper] getInt:@"Type"]) {
            lbltitle.text = [NSString stringWithFormat:@"%@(多选)",title];
        } else {
            lbltitle.text = title;
        }
    }
    
    //线条
    if (section) {
        RRLineView *line = WEAK_OBJECT(RRLineView, initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 0.5));
        [view addSubview:line];
    }
    
    [view addSubview:lbltitle];
    
    RRLineView *linebottom = WEAK_OBJECT(RRLineView, initWithFrame:CGRectMake(0, 39.5, SCREENWIDTH, 0.5));
    [view addSubview:linebottom];
    return view;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
   if (_doubles) {
        return self.dataArray.count + 2;
    } else if (_singles) {
        return self.dataArray.count + 1;
    } else {
        return self.dataArray.count;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (!indexPath.section && !_type) {
        return 65;
    } else {
        return 50;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (!_type) {
        if (_doubles) {
            if (!section) {
                return 1;
            } else if (section == 1) {
                return [[[_sexDic wrapper] getArray:@"Answer"] count];
            } else {
                return [[[_dataArray[section - 2] wrapper] getArray:@"Answer"] count];
            }
        } else if (_singles) {
            if (!section) {
                return 1;
            } else {
                return [[[_dataArray[section - 1] wrapper] getArray:@"Answer"] count];
            }
        } else {
            return [[[_dataArray[section] wrapper] getArray:@"Answer"] count];
        }
        
        
    } else {
        return [[[_dataArray[section] wrapper] getArray:@"Answer"] count];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier;
    identifier = [NSString stringWithFormat:@"%ld",(long)indexPath.section*1000 + indexPath.row];
    CustomBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        if (_type) {
            
            DictionaryWrapper *dic = [self.dataArray[indexPath.section] wrapper];
            cell = [CustomBaseCell createCellWithType:(NSInteger)[dic getInteger:@"Type"] data:[[dic getArray:@"Answer"][indexPath.row] wrapper]];
        } else {
            
            if (_doubles) {
                
                if (!indexPath.section) {
                    
                    cell = [CustomBaseCell createCellWithType:-1 data:nil];
                    ((CustomAgeCell *) cell).txtMinAge.delegate = self;
                    ((CustomAgeCell *) cell).txtMinAge.tag = 9999;
                    [((CustomAgeCell *) cell).txtMinAge addTarget:self action:@selector(textFieldWithText:) forControlEvents:UIControlEventEditingChanged];
                    ((CustomAgeCell *) cell).txtMaxAge.delegate = self;
                    [((CustomAgeCell *) cell).txtMaxAge addTarget:self action:@selector(textFieldWithText:) forControlEvents:UIControlEventEditingChanged];
                    [self addDoneToKeyboard:((CustomAgeCell *) cell).txtMaxAge];
                    [self addDoneToKeyboard:((CustomAgeCell *) cell).txtMinAge];
                    
                    if (_minAge.length) {
                        ((CustomAgeCell *) cell).txtMinAge.text = _minAge;
                    }
                    if (_maxAge.length) {
                        ((CustomAgeCell *) cell).txtMaxAge.text = _maxAge;
                    }
                    
                    if (_ageRegion.count == 2) {
                        if ([_ageRegion[0] intValue] != -1) {
                            ((CustomAgeCell *) cell).txtMinAge.text = _ageRegion[0];
                            self.minAge = _ageRegion[0];
                        }
                        if ([_ageRegion[1] intValue] != -1) {
                            ((CustomAgeCell *) cell).txtMaxAge.text = _ageRegion[1];
                            self.maxAge = _ageRegion[1];
                        }
                    }
                    
                } else if (indexPath.section == 1) {
                    
                    DictionaryWrapper *dic = [[[self.sexDic wrapper] getArray:@"Answer"][indexPath.row] wrapper];
                    cell = [CustomBaseCell createCellWithType:0 data:dic];
                    
                } else {
                    
                    DictionaryWrapper *dic = [self.dataArray[indexPath.section - 2] wrapper];
                    cell = [CustomBaseCell createCellWithType:(NSInteger)[dic getInteger:@"Type"] data:[[dic getArray:@"Answer"][indexPath.row] wrapper]];
                }

                
            } else if (_singles) {
                
                if (!indexPath.section) {
                    cell = [CustomBaseCell createCellWithType:-1 data:nil];
                    ((CustomAgeCell *) cell).txtMinAge.delegate = self;
                    ((CustomAgeCell *) cell).txtMinAge.tag = 9999;
                    [((CustomAgeCell *) cell).txtMinAge addTarget:self action:@selector(textFieldWithText:) forControlEvents:UIControlEventEditingChanged];
                    ((CustomAgeCell *) cell).txtMaxAge.delegate = self;
                    [((CustomAgeCell *) cell).txtMaxAge addTarget:self action:@selector(textFieldWithText:) forControlEvents:UIControlEventEditingChanged];
                    [self addDoneToKeyboard:((CustomAgeCell *) cell).txtMaxAge];
                    [self addDoneToKeyboard:((CustomAgeCell *) cell).txtMinAge];
                    
                    if (_minAge.length) {
                        ((CustomAgeCell *) cell).txtMinAge.text = _minAge;
                    }
                    if (_maxAge.length) {
                        ((CustomAgeCell *) cell).txtMaxAge.text = _maxAge;
                    }
                    
                    if (_ageRegion.count == 2) {
                        if ([_ageRegion[0] intValue] != -1) {
                            ((CustomAgeCell *) cell).txtMinAge.text = _ageRegion[0];
                            self.minAge = _ageRegion[0];
                        }
                        if ([_ageRegion[1] intValue] != -1) {
                            ((CustomAgeCell *) cell).txtMaxAge.text = _ageRegion[1];
                            self.maxAge = _ageRegion[1];
                        }

                    }

                } else {
                    
                    DictionaryWrapper *dic = [self.dataArray[indexPath.section - 1] wrapper];
                    cell = [CustomBaseCell createCellWithType:(NSInteger)[dic getInteger:@"Type"] data:[[dic getArray:@"Answer"][indexPath.row] wrapper]];
                }
                
            } else {
                
                DictionaryWrapper *dic = [self.dataArray[indexPath.section] wrapper];
                cell = [CustomBaseCell createCellWithType:(NSInteger)[dic getInteger:@"Type"] data:[[dic getArray:@"Answer"][indexPath.row] wrapper]];
            }
  
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (_type) {
        
        DictionaryWrapper *dic = [self.dataArray[indexPath.section] wrapper];
        int answerId = [[[dic getArray:@"Answer"][indexPath.row] wrapper] getInt:@"OptionId"];
        
        if ([self isContains:answerId]) {
            if (![self selectionsIsContains:indexPath.section]) {
                [_selectSections addObject:[NSString stringWithFormat:@"%ld",(long)indexPath.section]];
            }
        }
        
        if ([dic getInteger:@"Type"]) {
            //多选
            ((MoreChooseCell *)cell).btnSelected.selected = [self isContains:answerId];
            if (![self selectionsIsContains:indexPath.section] && [self isContains:answerId]) {
                [_selectSections addObject:[NSString stringWithFormat:@"%d", (int)indexPath.section]];
            }
            
            ((MoreChooseCell *)cell).btnSelected.tag = indexPath.section * 1000 + indexPath.row;
            [((MoreChooseCell *)cell).btnSelected addTarget:self action:@selector(chooseItem:) forControlEvents:UIControlEventTouchUpInside];
        } else {
            //单选
            ((SingleChooseCell *)cell).btnItem.selected = [self isContains:answerId];
            if (![self selectionsIsContains:indexPath.section] && [self isContains:answerId]) {
                [_selectSections addObject:[NSString stringWithFormat:@"%d", (int)indexPath.section]];
            }
            
            ((SingleChooseCell *)cell).btnItem.tag = indexPath.section * 1000 + indexPath.row;
            ((SingleChooseCell *)cell).imgRight.hidden = !((SingleChooseCell *)cell).btnItem.selected;
            [((SingleChooseCell *)cell).btnItem addTarget:self action:@selector(chooseRow:) forControlEvents:UIControlEventTouchUpInside];
        }
        
    } else {
        
        if (_doubles) {
            
            if (!indexPath.section) {
            } else if (indexPath.section == 1) {
                //单选
                [((SingleChooseCell *)cell).btnItem addTarget:self action:@selector(chooseSex:) forControlEvents:UIControlEventTouchUpInside];
                ((SingleChooseCell *)cell).btnItem.selected = (indexPath.row == _currentRow);
                
                if (![self selectionsIsContains:indexPath.section] && (indexPath.row == _currentRow)) {
                    [_selectSections addObject:[NSString stringWithFormat:@"%d", (int)indexPath.section]];
                }
                
                if ((indexPath.row == _currentRow)) {
                    if (![self selectionsIsContains:indexPath.section]) {
                        [_selectSections addObject:[NSString stringWithFormat:@"%d",(int)indexPath.section]];
                    }
                }
                ((SingleChooseCell *)cell).imgRight.hidden = !((SingleChooseCell *)cell).btnItem.selected;
                ((SingleChooseCell *)cell).btnItem.tag = indexPath.section * 1000 + indexPath.row;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                return cell;
            } else {
                DictionaryWrapper *dic = [self.dataArray[indexPath.section - 2] wrapper];
                int answerId = [[[dic getArray:@"Answer"][indexPath.row] wrapper] getInt:@"OptionId"];
                if ([dic getInteger:@"Type"]) {
                    //多选
                    ((MoreChooseCell *)cell).btnSelected.selected = [self isContains:answerId];
                    
                    if (![self selectionsIsContains:indexPath.section] && [self isContains:answerId]) {
                        [_selectSections addObject:[NSString stringWithFormat:@"%d", (int)indexPath.section]];
                    }
                    
                    if (((MoreChooseCell *)cell).btnSelected.selected) {
                        if (![self selectionsIsContains:indexPath.section]) {
                            [_selectSections addObject:[NSString stringWithFormat:@"%d",(int)indexPath.section]];
                        }
                        ((MoreChooseCell *)cell).lblItemName.textColor = RGBCOLOR(240, 5, 0);
                    } else {
                        ((MoreChooseCell *)cell).lblItemName.textColor = RGBCOLOR(43, 43, 43);
                    }
                    ((MoreChooseCell *)cell).btnSelected.tag = indexPath.section * 1000 + indexPath.row;
                    [((MoreChooseCell *)cell).btnSelected addTarget:self action:@selector(chooseItem:) forControlEvents:UIControlEventTouchUpInside];
                } else {
                    //单选
                    ((SingleChooseCell *)cell).btnItem.selected = [self isContains:answerId];
                    
                    if (![self selectionsIsContains:indexPath.section] && [self isContains:answerId]) {
                        [_selectSections addObject:[NSString stringWithFormat:@"%d", (int)indexPath.section]];
                    }
                    
                    if ([self isContains:answerId]) {
                        if (![self selectionsIsContains:indexPath.section]) {
                            [_selectSections addObject:[NSString stringWithFormat:@"%d",(int)indexPath.section]];
                        }
                    }
                    ((SingleChooseCell *)cell).btnItem.tag = indexPath.section * 1000 + indexPath.row;
                    ((SingleChooseCell *)cell).imgRight.hidden = !((SingleChooseCell *)cell).btnItem.selected;
                    [((SingleChooseCell *)cell).btnItem addTarget:self action:@selector(chooseRow:) forControlEvents:UIControlEventTouchUpInside];
                }
                
            }
        
        } else if (_singles) {
            
            if (indexPath.section == 0) {
//                //单选
//                [((SingleChooseCell *)cell).btnItem addTarget:self action:@selector(chooseSex:) forControlEvents:UIControlEventTouchUpInside];
//                ((SingleChooseCell *)cell).btnItem.selected = (indexPath.row == _currentRow);
//                if ((indexPath.row == _currentRow)) {
//                    if (![_selectSections containsObject:[NSString stringWithFormat:@"%d",(int)indexPath.section]]) {
//                        [_selectSections addObject:[NSString stringWithFormat:@"%d",(int)indexPath.section]];
//                    }
//                }
//                ((SingleChooseCell *)cell).imgRight.hidden = !((SingleChooseCell *)cell).btnItem.selected;
//                ((SingleChooseCell *)cell).btnItem.tag = indexPath.section * 1000 + indexPath.row;
//                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                return cell;
            } else {
                DictionaryWrapper *dic = [self.dataArray[indexPath.section - 1] wrapper];
                int answerId = [[[dic getArray:@"Answer"][indexPath.row] wrapper] getInt:@"OptionId"];
                if ([dic getInteger:@"Type"]) {
                    //多选
                    ((MoreChooseCell *)cell).btnSelected.selected = [self isContains:answerId];
                    
                    if (((MoreChooseCell *)cell).btnSelected.selected) {
                        if (![self selectionsIsContains:indexPath.section]) {
                            [_selectSections addObject:[NSString stringWithFormat:@"%d",(int)indexPath.section]];
                        }
                        ((MoreChooseCell *)cell).lblItemName.textColor = RGBCOLOR(240, 5, 0);
                    } else {
                        ((MoreChooseCell *)cell).lblItemName.textColor = RGBCOLOR(43, 43, 43);
                    }
                    ((MoreChooseCell *)cell).btnSelected.tag = indexPath.section * 1000 + indexPath.row;
                    [((MoreChooseCell *)cell).btnSelected addTarget:self action:@selector(chooseItem:) forControlEvents:UIControlEventTouchUpInside];
                } else {
                    //单选
                    ((SingleChooseCell *)cell).btnItem.selected = [self isContains:answerId];
                    if ([self isContains:answerId]) {
                        if (![self selectionsIsContains:indexPath.section]) {
                            [_selectSections addObject:[NSString stringWithFormat:@"%d",(int)indexPath.section]];
                        }
                    }
                    ((SingleChooseCell *)cell).btnItem.tag = indexPath.section * 1000 + indexPath.row;
                    ((SingleChooseCell *)cell).imgRight.hidden = !((SingleChooseCell *)cell).btnItem.selected;
                    [((SingleChooseCell *)cell).btnItem addTarget:self action:@selector(chooseRow:) forControlEvents:UIControlEventTouchUpInside];
                }
                
            }
        } else {
            DictionaryWrapper *dic = [self.dataArray[indexPath.section] wrapper];
            int answerId = [[[dic getArray:@"Answer"][indexPath.row] wrapper] getInt:@"OptionId"];
            
            if ([self isContains:answerId]) {
                if (![self selectionsIsContains:indexPath.section]) {
                    [_selectSections addObject:[NSString stringWithFormat:@"%ld",(long)indexPath.section]];
                }
            }
            
            if ([dic getInteger:@"Type"]) {
                //多选
                ((MoreChooseCell *)cell).btnSelected.selected = [self isContains:answerId];
                
                if (![self selectionsIsContains:indexPath.section] && [self isContains:answerId]) {
                    [_selectSections addObject:[NSString stringWithFormat:@"%d", (int)indexPath.section]];
                }
                
                ((MoreChooseCell *)cell).btnSelected.tag = indexPath.section * 1000 + indexPath.row;
                [((MoreChooseCell *)cell).btnSelected addTarget:self action:@selector(chooseItem:) forControlEvents:UIControlEventTouchUpInside];
            } else {
                //单选
                ((SingleChooseCell *)cell).btnItem.selected = [self isContains:answerId];
                
                if (![self selectionsIsContains:indexPath.section] && [self isContains:answerId]) {
                    [_selectSections addObject:[NSString stringWithFormat:@"%d", (int)indexPath.section]];
                }
                
                ((SingleChooseCell *)cell).btnItem.tag = indexPath.section * 1000 + indexPath.row;
                ((SingleChooseCell *)cell).imgRight.hidden = !((SingleChooseCell *)cell).btnItem.selected;
                [((SingleChooseCell *)cell).btnItem addTarget:self action:@selector(chooseRow:) forControlEvents:UIControlEventTouchUpInside];
            }

        }
        
    }
    
    return cell;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 40;
    if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >= 0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

- (BOOL)isContains:(int)anwserId{
    for (id aid in _itemArray) {
        if ([aid intValue] == anwserId) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)selectionsIsContains:(NSInteger)cid{
    for (id aid in _selectSections) {
        if ([aid intValue] == cid) {
            return YES;
        }
    }
    return NO;
}

#pragma mark - uitextfiled delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.view endEditing:YES];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField.text.length && ([textField.text intValue] > 100 || [textField.text intValue] < 0)) {
        [HUDUtil showErrorWithStatus:@"年龄输入错误，区间为0-100"];return;
    }

    if (textField.text.length && ([self.maxAge intValue] < 0 || [self.maxAge intValue] < 0)) {
        [HUDUtil showErrorWithStatus:@"年龄不能小于0"];return;
    }
    
    if (self.maxAge.length && self.minAge.length && [self.maxAge intValue] >= 0 && [self.minAge intValue] >= 0) {
        if (self.maxAge.intValue < [self.minAge intValue]) {
            [HUDUtil showErrorWithStatus:@"最小年龄不能大于最大年龄"];return;
        }
    }
}

- (void)textFieldWithText:(UITextField *)textField{
    switch (textField.tag) {
        case 9999:
            self.minAge = textField.text.length ? textField.text : @"";
            break;
            
        default:
            self.maxAge = textField.text.length ? textField.text : @"";
            break;
    }
}

#pragma mark - 事件
- (void)hiddenKeyboard{
    [self.view endEditing:YES];
}
//无数据hoverview
- (void)createHoverViewWhenNoData{
    BaserHoverView *hover = STRONG_OBJECT(BaserHoverView, initWithTitle:@"抱歉" message:@"没有筛选到此类问题");
    hover.frame = self.view.bounds;
    [self.view addSubview:hover];
    [hover release];
}
//多选
- (void)chooseItem:(UIButton *)button{
    NSInteger section = button.tag / 1000;
    NSInteger row = button.tag % 1000;
    
    NSInteger tempSection = 0;
    
    if (!_type) {
        if (_doubles) {
            tempSection = section - 2;
        } else if (_singles) {
            tempSection = section - 1;
        } else {
            tempSection = section;
        }
    } else {
        tempSection = section;
    }

    NSArray *temp = [[self.dataArray[tempSection] wrapper] getArray:@"Answer"];
    int curOpId = [[temp[row] wrapper] getInt:@"OptionId"];
    if ([self isContains:curOpId]) {
        [_itemArray removeObject:[NSString stringWithFormat:@"%d",curOpId]];
    } else {
        [_itemArray addObject:[NSString stringWithFormat:@"%d",curOpId]];
    }
    
    if (![self selectionsIsContains:section]) {
        [_selectSections addObject:[NSString stringWithFormat:@"%d",(int)section]];
    } else {
        [_selectSections removeObject:[NSString stringWithFormat:@"%d",(int)section]];
    }
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
//单选
- (void)chooseRow:(UIButton *)button{
    NSInteger section =  button.tag / 1000;
    NSInteger row = button.tag % 1000;
    
    NSInteger tempSection = 0;
    
    if (!_type) {
        if (_doubles) {
            tempSection = section - 2;
        } else if (_singles) {
            tempSection = section - 1;
        } else {
            tempSection = section;
        }
    } else {
        tempSection = section;
    }
    
    NSArray *temp = [[self.dataArray[tempSection] wrapper] getArray:@"Answer"];
    int curOpId = [[temp[row] wrapper] getInt:@"OptionId"];
    if ([self isContains:curOpId]) {
        return;
    }
    for (NSDictionary *dic in temp) {
        int opId = [[dic wrapper] getInt:@"OptionId"];
        if ([self isContains:opId]) {
            [_itemArray removeObject:[NSString stringWithFormat:@"%d",opId]];
        }
    }
    [_itemArray addObject:[NSString stringWithFormat:@"%d",curOpId]];
    
    if (![self selectionsIsContains:section]) {
        [_selectSections addObject:[NSString stringWithFormat:@"%d",(int)section]];
    } else {
        [_selectSections removeObject:[NSString stringWithFormat:@"%d",(int)section]];
    }
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
}
//性别选择
- (void)chooseSex:(UIButton *)button{
    NSInteger section = button.tag / 1000;
    NSInteger row = button.tag % 1000;
    _currentRow = row;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%ld",(long)row] forKey:@"CustomQuestionSex"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//返回
- (void)onMoveBack:(UIButton *)sender{
    
    int count = 0;
    
    for (NSDictionary *dic in self.dataArray) {
        NSArray *array = [[dic wrapper] getArray:@"Answer"];
        for (NSDictionary *item in array) {
            if ([self isContains:[[item wrapper] getInt:@"OptionId"]]) {
                count ++;
                break;
            }
        }
    }
    
    if (count != self.dataArray.count) {
        __block typeof(self) weakself = self;
        
        [AlertUtil showAlert:@"" message:@"为了更多的用户接收广告，系统将默认未完成的题目答案为“不限”" buttons:@[
                                                                     @"继续完成",
                                                                     @{
                                                                         @"title":@"确定",
                                                                         @"delegator":ALERT_VIEW_DELEGATOR_BLOCK({
            [weakself saveDataWhenBack];
        })
                                                                         }
                                                                     ]];
    } else {
        [self saveDataWhenBack];
    }
    
}

- (void)saveDataWhenBack{
    
    __block typeof(self) weakself = self;
    for (NSDictionary *dic in weakself.dataArray) {
        NSArray *temp = [dic.wrapper getArray:@"Answer"];
        for (NSDictionary *op in temp) {
            int opId = [op.wrapper getInt:@"OptionId"];
            if ([weakself isContains:opId]) {
                break;
            } else {
                NSString *anwser = [op.wrapper getString:@"Answer"];
                if ([anwser isEqualToString:@"不限"]) {
                    [weakself.itemArray addObject:[NSString stringWithFormat:@"%d", opId]];
                    break;
                }
            }
        }
    }
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:_navTitle];
    self.minAge = _minAge.length ? _minAge : @"";
    self.maxAge = _maxAge.length ? _maxAge : @"";
    [[NSUserDefaults standardUserDefaults] setValue:@[_minAge, _maxAge] forKey:@"CustomQuestionAge"];
    [[NSUserDefaults standardUserDefaults] setValue:self.itemArray forKey:@"PostOptions"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [weakself.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 内存管理
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc {
    [_selectSections release];
    [_minAge release];
    [_maxAge release];
    [_ageRegion release];
    [_itemArray release];
    [_navTitle release];
    [_dataArray release];
    [_sexDic release];
    [_tableView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTableView:nil];
    [super viewDidUnload];
}
@end
