//
//  SelectListVC.m
//  guanggaoban
//
//  Created by CQXianMai on 14-8-10.
//  Copyright (c) 2014年 Arvin. All rights reserved.
//

#import "SelectListVC.h"

@interface SelectListVC ()

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initNaviItem];
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
    return [_listArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyIdentifier"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.textLabel.font = Font(15.0);
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 43, 320, 1)];
        line.backgroundColor = RGBCOLOR(235, 235, 235);
        [cell.contentView addSubview:line];
        [line release];
        cell.selectedBackgroundView.backgroundColor = RGBCOLOR(251, 244, 236);
    }
    
    NSInteger row = indexPath.row;
    if (![_listArr count]) {
        return cell;
    }
    
    switch (_listType) {
        case check_User_RankName:
        case check_Com_RankName:
            cell.textLabel.text = _listArr[row];
            break;
        case check_Month_RankTime:
        case check_Week_RankTime:
            cell.textLabel.text = [_listArr[row] valueForJSONStrKey:@"Text"];
            break;
        default:
            break;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
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
            selectDateStr = [_listArr[row] valueForJSONStrKey:@"Value"];
            checkStr = [_listArr[row] valueForJSONStrKey:@"Text"];
            break;
        default:
            break;
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(checkRightInfoName:ListType:andSearchType:andSelectDate:)]) {
        
        if (row < [_listArr count]) {
            [_delegate checkRightInfoName:checkStr ListType:_listType andSearchType:searchType andSelectDate:selectDateStr];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

@end
