//
//  SelectListVC.m
//  guanggaoban
//
//  Created by CQXianMai on 14-8-10.
//  Copyright (c) 2014年 Arvin. All rights reserved.
//

#import "SelectListVC.h"
#import "HightedButton.h"


@interface SelectListVC ()<UITableViewDataSource,UITableViewDelegate>
{
    NSIndexPath* _initPath;
    
    BOOL         _disonce;
}
@end

@implementation SelectListVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIView * view = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(0, 0, 320, 10));
    view.backgroundColor = [UIColor clearColor];
    _chooseList.tableHeaderView = view;
    [self initNaviItem];
    self.view.backgroundColor = AppColorBackground;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_chooseList release];
    [_listArr release];
    [_titleNameStr release];
    self.delegate = nil;
    [super dealloc];
}

- (void)initNaviItem
{
    [self setNavigateTitle:_titleNameStr];
    [self setupMoveBackButton];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%d", [_listArr count]);
    return [_listArr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyIdentifier"] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = Font(16.0);
        cell.contentView.backgroundColor = AppColorWhite;
        
//        HightedButton *bt = WEAK_OBJECT(HightedButton, initWithFrame:CGRectMake(0, 0, 320, 50));
//        [cell.contentView addSubview:bt];
//        [cell.contentView bringSubviewToFront:cell.textLabel];
        
        UIView *line = [[[UIView alloc] initWithFrame:CGRectMake(15, 49.5, 320, 0.5)] autorelease];
        line.tag = 9876;
        line.backgroundColor = AppColor(204);
        [cell.contentView addSubview:line];
        
        UIImageView *gougou = WEAK_OBJECT(UIImageView, initWithFrame:CGRectMake(320 - 28, 20, 13, 10));
        gougou.image = [UIImage imageNamed:@"ads_list_right@2x.png"];
        [cell.contentView addSubview:gougou];
        gougou.hidden = YES;
        gougou.tag = 998;
    }
    NSInteger row = indexPath.row;
    
    if (![_listArr count])
    {
        return cell;
    }
    
    if (indexPath.row == 0)
    {
        UIView *line = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.5)] autorelease];
        line.backgroundColor = AppColor(204);
        line.tag = 10;
        [cell.contentView addSubview:line];
    }
    else
    {
        UIView *v = [cell.contentView viewWithTag:10];
        [v removeFromSuperview];
    }
    
    if (indexPath.row == _listArr.count - 1)
    {
        [cell.contentView viewWithTag:9876].left = 0;
    }
    else
    {
        [cell.contentView viewWithTag:9876].left = 15;
    }
    
    switch (_listType)
    {
        case check_User_RankName:
        case check_Com_RankName:
            cell.textLabel.text = _listArr[row];
            break;
        case check_Month_RankTime:
        case check_Week_RankTime:
        {
            cell.textLabel.text = [((NSDictionary *)_listArr[row]).wrapper getString:@"Text"];
            break;
        }
        default:
            break;
    }
    
    if ([cell.textLabel.text isEqualToString:_selectTitle] && !_disonce)
    {
        _initPath = indexPath;
        [_initPath retain];
    }
    
    if (_initPath.row == indexPath.row && _initPath != nil)
    {
        UIView *v = [cell.contentView viewWithTag:998];
        v.hidden = NO;
        cell.textLabel.textColor = AppColorRed;
    }
    else
    {
        UIView *v = [cell.contentView viewWithTag:998];
        v.hidden = YES;
        cell.textLabel.textColor = AppColorBlack43;
    }

    return cell;
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
    cell.contentView.backgroundColor = [UIColor whiteColor];}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    {
        _disonce = YES;
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:_initPath];
        for (UIView *viw in cell.contentView.subviews)
        {
            if (viw.tag == 998) viw.hidden = YES;
        }
        cell.textLabel.textColor = AppColorBlack43;
    }
//
//    UIImageView *gougou = WEAK_OBJECT(UIImageView, initWithFrame:CGRectMake(320 - 28, 20, 13, 10));
//    gougou.image = [UIImage imageNamed:@"ads_list_right@2x.png"];
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    cell.textLabel.textColor = AppColorRed;
//    [cell.contentView addSubview:gougou];
//    gougou.tag = 999;
    _initPath = indexPath;
    [_initPath retain];
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    NSInteger row = [indexPath row];
    NSInteger searchType = INIT_VAL_USER;
    NSString *selectDateStr = @"";
    NSString *checkStr = @"";
    
    
    switch (_listType) {
        case check_User_RankName:
            searchType = INIT_VAL_USER + row;
            checkStr = _listArr[row];
            break;
        case check_Com_RankName:
            searchType = INIT_VAL_COM + row;
            checkStr = _listArr[row];
            break;
        case check_Month_RankTime:
        case check_Week_RankTime:
        {
            DictionaryWrapper *_list = ((NSDictionary *)_listArr[row]).wrapper;
            selectDateStr = [_list getString:@"Value"];
            checkStr = [_list getString:@"Text"];
            break;
        }
        default:
            break;
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(checkRightInfoName:ListType:andSearchType:andSelectDate:)]) {
        
        if (row < [_listArr count]) {
            [_delegate checkRightInfoName:checkStr ListType:_listType andSearchType:searchType andSelectDate:selectDateStr];
//            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0)
{
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    for (UIView *viw in cell.contentView.subviews)
//    {
//        if (viw.tag == 998) [viw removeFromSuperview];
//    }
//    cell.textLabel.textColor = AppColorBlack43;
}

@end
