//
//  CRAreViewController.m
//  miaozhuan
//
//  Created by abyss on 15/1/7.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "CRAreViewController.h"
#import "pinyin.h"
#import "NSDictionary+expanded.h"
#import "AreaListCell.h"
#import "CRPinyinManager.h"

#import "CRTableSectionBarController.h"

@interface CRAreViewController ()<UITableViewDataSource,UITableViewDelegate, UISearchBarDelegate,CRTableSectionBarDelegate>
{
    UIImageView* _gougou;
    
    CRTableSectionBarController* _selectController;
    NSMutableDictionary *_oriData;
    NSMutableArray *_oriList;
}
@property (retain, nonatomic) IBOutlet UILabel *lbl;
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) NSMutableArray* AreList;
@property (retain, nonatomic) NSMutableDictionary* AreData;
@property (retain, nonatomic) IBOutlet UISearchBar *searchBar;
@property (retain, nonatomic) IBOutlet HightedButton *allButton;
@property (retain, nonatomic) NSIndexPath* holderPath;
@end

@implementation CRAreViewController

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
- (void)onMoveFoward:(UIButton *)sender
{
    NSString* ret = nil;
    
    if (_holderPath)
    {
        AreaListCell *cell = (AreaListCell *)[_tableView cellForRowAtIndexPath:_holderPath];
        ret = cell.lblArea.text;
    }
    else
    {
        ret = @"";
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(AreControl:select:)])
    {
        [_delegate AreControl:self select:ret];
    }
    
    [self onMoveBack:nil];
}

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    InitNav(@"选择城市");
    [self setupMoveFowardButtonWithTitle:@"保存"];
    
    _selectController = [CRTableSectionBarController controllerFrom:_tableView];
    _selectController.delegate = self;
    
    _holderPath = nil;
    _AreList = [NSMutableArray new];
    _AreData = [NSMutableDictionary new];
    
    _searchBar.delegate = self;
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    [self addDoneToKeyboard:_searchBar];
    _tableView.separatorColor = [UIColor clearColor];
    
    
    {
        _gougou          = STRONG_OBJECT(UIImageView, initWithFrame:CGRectMake(320 - 40, 17.5, 13, 10));
        _gougou.size     = CGSizeMake(13, 10);
        _gougou.image    = [UIImage imageNamed:@"ads_list_right@2x.png"];
    }
    
    __block CRAreViewController* weakself = self;
    [_allButton setTapActionWithBlock:^{
        weakself.holderPath = nil;
        [weakself viewDidLayoutSubviews];
    }];
    
    ADAPI_RegionGetAllBaiduRegionList([self genDelegatorID:@selector(getAreList:)]);
}

- (void)viewDidLayoutSubviews
{
    if (_holderPath == nil)
    {
        if (!_gougou) return;
        if (_gougou.superview) [_gougou removeFromSuperview];
        ((AreaListCell*)_gougou.superview.superclass).lblArea.textColor = AppColorBlack43;
        _lbl.textColor = AppColorRed;
        
        _gougou.frame = CGRectMake(320 - 40, 20, 13, 10);
        [_allButton addSubview:_gougou];
    }
}

- (void)getAreData
{
//    APP_ASSERT(_AreData);
    [_AreData removeAllObjects];
    
    for (NSDictionary* dic in _AreList)
    {
        int level = 0;
        NSString* key = nil;
        NSString* spell = nil;
        DictionaryWrapper* wrapper = dic.wrapper;
        
        level = [wrapper getInt:@"Level"];
        if (level == 2)
        {
            spell = [wrapper getString:@"Spell"];
            key   = [[NSString stringWithFormat:@"%c",pinyinFirstLetter([spell characterAtIndex:0])] uppercaseString];
            
            [_AreData setObjects:dic forKey:key];
        }
    }
    
    [_AreData retain];
}

- (void)getAreList:(DelegatorArguments *)arg
{
    if (arg.ret.operationSucceed)
    {
        NSArray* ret = arg.ret.data;
        
        if (!ret && ret.count == 0) [HUDUtil showErrorWithStatus:@"暂无数据"];
        
        _AreList = [NSMutableArray arrayWithArray:ret];
        [_AreList retain];
        
        _oriList = [NSMutableArray arrayWithArray:_AreList];
        [_oriList retain];
                    
        [self getAreData];
        _oriData = [NSMutableDictionary dictionaryWithDictionary:_AreData];
        [_oriData retain];
        
        _tableView.separatorColor = [UIColor groupTableViewBackgroundColor];
        [_tableView reloadData];
        [_selectController reloadData];
    }
    else
    {
        [HUDUtil showErrorWithStatus:arg.ret.operationMessage];
    }
}

#pragma mark - SearchBar Delegate

- (void) hiddenKeyboard
{
    [_searchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    searchBar.text = [searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if(searchBar.text.length == 0)
    {
        return;
    }
    
    NSString *pinyin = searchBar.text;
    
    BOOL isEnglish = [CRPinyinManager isChinese:pinyin];
    if(!isEnglish) pinyin = [pinyin lowercaseString];
    
    NSMutableArray * arr = [NSMutableArray arrayWithArray:_AreList];
    [arr retain];
    [_AreList removeAllObjects];
    
//    int checkru = 0;
//    
    for (NSInteger i = 0; i < [arr count]; i++)
    {
        NSDictionary * dic = [arr objectAtIndex:i];
        
        NSString *str = nil;
        
        if (!isEnglish)
        {
            
            str = [[dic objectForKey:@"Spell"] description];
        }
        else
        {
            str = [[dic objectForKey:@"Name"] description];
        }
        
        if ([str length] >= [pinyin length])
        {
            
            NSRange ran = [str rangeOfString:pinyin];
            
            if (ran.length >= 1)
            {
                if ([dic.wrapper getInt:@"Level"] == 2)
                {
//                    checkru = 1;
                    [_AreList addObject:dic];
                }
            }
        }
    }
    [self getAreData];
    [_tableView reloadData];
    [_selectController reloadData];
    [self hiddenKeyboard];
}

#pragma mark - TableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[_AreData allKeys] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = [_AreData objectForKey:[[[_AreData allKeys] sortedArrayUsingSelector:@selector(compare:)] objectAtIndex:section]];
    
    return [array count];
}

- (void) layoutSubviews
{
//    [self layoutSubviews]
    for (UIView *view in self.searchBar.subviews) {
        if ([view isKindOfClass: [UITextField class]])
        {
            view.frame = CGRectMake(0, 0, 320, 50);
            ((UITextField *)view).textColor = AppColorRed;
            [_allButton addSubview:_gougou];
        }
//        ((AreaListCell*)_gougou.superview.superclass).lblArea.textColor = AppColorBlack43;
        
//        _gougou.frame = CGRectMake(320 - 40, 20, 13, 10);
    }
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    _AreData = [NSMutableDictionary dictionaryWithDictionary:[_oriData copy]];
    [_AreData retain];
    
    _AreList = [NSMutableArray arrayWithArray:[_oriList copy]];
    [_AreList retain];
    return YES;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *title = [[_AreData allKeys] sortedArrayUsingSelector:@selector(compare:)][section];
    UIView *view = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 20));
    view.backgroundColor = AppColor(247);
    UILabel *lblTitle = WEAK_OBJECT(UILabel, initWithFrame:CGRectMake(15, 5, 200, 10));
    lblTitle.textColor = RGBCOLOR(153, 153, 153);
    lblTitle.font = Font(10);
    lblTitle.text = title;
    [view addSubview:lblTitle];
    
    {
        UIView * view1 = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(0, 0, 320, 0.5));
        view1.backgroundColor = AppColor(204);
        [view addSubview:view1];
    }
    return view;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array = [_AreData objectForKey:[[[_AreData allKeys] sortedArrayUsingSelector:@selector(compare:)] objectAtIndex:indexPath.section]];
    NSDictionary* dict = [array objectAtIndex:indexPath.row];
    
    NSString *identify = dict.description;
    AreaListCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AreaListCell" owner:self options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.btnSelected.hidden = YES;
    cell.imgArrow.hidden = YES;
    cell.lblArea.font = Font(16);
    cell.dataDic = dict;
    
    if (indexPath == _holderPath)
    {
            [self gougouOn:cell];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self gougouOn:cell];
    ((AreaListCell*)cell).lblArea.textColor = AppColorRed;
    
    [self.view endEditing:YES];
    _holderPath = indexPath;
    [_holderPath retain];
    
    _lbl.textColor = AppColorBlack43;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    ((AreaListCell*)cell).lblArea.textColor = AppColorBlack43;
    [self gougouOn:cell];
    _holderPath = indexPath;
    [_holderPath retain];
}

- (void)gougouOn:(UITableViewCell *)cell
{
    if (!_gougou) return;
    if (_gougou.superview) [_gougou removeFromSuperview];
    
    _gougou.frame = CGRectMake(320 - 40, 20, 13, 10);
    [cell.contentView addSubview:_gougou];
}

- (void)dealloc
{
    CRDEBUG_DEALLOC();
    
    [_AreList release];
    [_AreData release];
    [_oriData release];
    [_tableView release];
    [_allButton release];
    [_searchBar release];
    [_lbl release];
    [super dealloc];
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = AppColor(220);
    return YES;
}
- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];
}


#pragma mark - add!!!!~

- (NSInteger)numberOfSectionsInSectionSelectionView:(CRTableSectionBarController *)sectionSelectionView
{
    return [[_AreData allKeys] count];
//    return [_tableView.dataSource numberOfSectionsInTableView:_tableView];
}

- (UIView *)sectionSelectionView:(CRTableSectionBarController *)sectionSelectionView callOutViewForSelectedSection:(NSInteger)section
{
    UILabel* word = WEAK_OBJECT(UILabel, initWithFrame:CGRectMake(0, 0, 40, 40));
    word.font = Font(32);
    word.textColor = AppColorGray153;
    word.backgroundColor = [UIColor clearColor];
    word.text = [[_AreData allKeys] sortedArrayUsingSelector:@selector(compare:)][section];
    return word;
}

-(CRTableSectionBarItem *)sectionSelectionView:(CRTableSectionBarController *)selectionView sectionSelectionItemViewForSection:(NSInteger)section
{
    CRTableSectionBarItem *selectionItem = [[CRTableSectionBarItem alloc] init];
    
//    selectionItem.titleLabel.text = [_testTableView.dataSource tableView:_testTableView titleForHeaderInSection:section];
    selectionItem.titleLabel.text = [[_AreData allKeys] sortedArrayUsingSelector:@selector(compare:)][section];
    
    return selectionItem;
}

-(void)sectionSelectionView:(CRTableSectionBarController *)sectionSelectionView didSelectSection:(NSInteger)section
{
    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

@end
