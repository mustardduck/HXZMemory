//
//  PreferenceDetailViewController.m
//  miaozhuan
//
//  Created by Santiago on 14-10-28.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "PreferenceDetailViewController.h"
#import "PreferenceDetailCell.h"

@interface PreferenceDetailViewController ()<UITableViewDataSource,UITableViewDelegate>{

    IBOutlet UITableView *_mainTable;
    
    NSArray*            _questions;
    int                 _currentPage;
    BOOL                _modified;
    NSMutableArray*     _answerStatus;
}

@property (retain, nonatomic) IBOutlet UIView *mainTableHead;
@property (retain, nonatomic) IBOutlet UILabel *mainTitle;
@property (retain, nonatomic) IBOutlet UIView *UILineView;
@end

@implementation PreferenceDetailViewController
@synthesize mainTableHead = _mainTableHead;
@synthesize mainTitle = _mainTitle;
MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [_mainTable registerNib:[UINib nibWithNibName:@"PreferenceDetailCell" bundle:nil] forCellReuseIdentifier:@"PreferenceDetailCell"];
    [_mainTable setTableHeaderView:_mainTableHead];

    _mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.UILineView setFrame:CGRectMake(0, 37.5, 320, 0.5)];
    [self setupMoveBackButton];
    [self gotoPage:_currentPage];
}

- (void) setQuestions:(NSArray*) questions curPage:(int)curPage
{
    _questions      = questions;
    _currentPage    = curPage;
}

- (void) gotoPage:(int)page
{
    if(page >= _questions.count)
    {
        [super onMoveBack:nil];
        
        return ;
    }
    
    page = MIN(page, (int)_questions.count-1);
    
    _currentPage = page;
    
    [self setupMoveFowardButtonWithTitle:_currentPage+1 == _questions.count ? @"完成" : @"下一题"];
    [self setTitle:[_questions[_currentPage] getString:@"CategoryName"]];
    [_mainTitle setText:[_questions[_currentPage] getString:@"Title"]];
    
    _modified = NO;
    
    NSArray* options = [_questions[_currentPage] getArray:@"Options"];
    
    [_answerStatus release];
    _answerStatus = nil;
    _answerStatus = STRONG_OBJECT(NSMutableArray, initWithCapacity:options.count);
    
    for(DictionaryWrapper* option in options)
    {
        [_answerStatus addObject:[NSNumber numberWithBool:[option getBool:@"IsSelected"]]];
    }
    
    [_mainTable reloadData];
}

- (WDictionaryWrapper*) getOptionData:(int)optIdx
{
    return [_questions[_currentPage] getArray:@"Options"][optIdx];
}

#pragma mark- UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _answerStatus.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {

    UIView *temp = WEAK_OBJECT(UIView, init);
    [temp setBackgroundColor:[UIColor clearColor]];
    return temp;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PreferenceDetailCell *cell=[tableView dequeueReusableCellWithIdentifier:@"PreferenceDetailCell"];

    cell.detailLabel.text = [[self getOptionData:(int)indexPath.row] getString:@"Text"];
    
    if ([_questions[_currentPage] getInt:@"Type"])
    {

        [cell.btnSeleted setFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width - 13 - 26, 12, 26, 26)];
        [cell.btnSeleted setImage:[UIImage imageNamed:@"address_single_boxhover"] forState:UIControlStateSelected];
        [cell.btnSeleted setImage:[UIImage imageNamed:@"address_single_box"] forState:UIControlStateNormal];
    }else {
        
        [cell.btnSeleted setFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width - 13 - 13, 20, 13, 10)];
        [cell.btnSeleted setImage:[UIImage imageNamed:@"theCheckIcon"] forState:UIControlStateSelected];
        [cell.btnSeleted setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }
    
    cell.btnSeleted.selected = [_answerStatus[indexPath.row] boolValue];
    
    cell.detailLabel.textColor = cell.btnSeleted.selected ? [UIColor redColor] : [UIColor blackColor];
    
    if (indexPath.row == [_answerStatus count] - 1) {
        
        [cell.UILineView setFrame:CGRectMake(0, 49.5, 320, 0.5)];
    }else {
    
        [cell.UILineView setFrame:CGRectMake(15, 49.5, 305, 0.5)];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(![_questions[_currentPage] getInt:@"Type"])    // Single-Selection
    {
        for(int i=0; i<(int)_answerStatus.count; ++i)
        {
            _answerStatus[i] = [NSNumber numberWithBool:false];
        }
        _answerStatus[indexPath.row] = [NSNumber numberWithBool:true];
    }
    else
    {
        _answerStatus[indexPath.row] = [NSNumber numberWithBool:![_answerStatus[indexPath.row] boolValue]];
    }
    
    _modified = TRUE;
    
    [_mainTable reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 50;
}

- (void) onCommitAnswer:(DelegatorArguments*)arguments
{
    DictionaryWrapper* netData =  arguments.ret;
    if(netData.operationSucceed)
    {
        [_questions[_currentPage] set:@"IsSelected" bool:TRUE];
        
        for(int i = 0; i<(int)_answerStatus.count; ++i)
        {
            [[_questions[_currentPage] getArray:@"Options"][i] set:@"IsSelected" value:_answerStatus[i]];
        }
        
        if([[arguments getArgument:DELEGATOR_ARGUMENT_USERDATA] boolValue]) // To Next
        {
            [self gotoPage:_currentPage+1];
        }
        else
        {
            [super onMoveBack:nil];
        }
        
        
        NSLog(@"提交成功！");
    }
    else
    {
        [HUDUtil showErrorWithStatus:netData.operationMessage];
        
        if(![[arguments getArgument:DELEGATOR_ARGUMENT_USERDATA] boolValue]) // To Back
        {
            [super onMoveBack:nil];
        }
    }
}

- (void) commitAnswer:(BOOL)toNext
{
    if(_modified)
    {
        NSMutableArray* selectedOptions = WEAK_OBJECT(NSMutableArray, init);
        for(int i = 0; i<(int)_answerStatus.count; ++i)
        {
            if([_answerStatus[i] boolValue])
            {
                [selectedOptions addObject:[NSString stringWithFormat:@"%d",[[self getOptionData:i] getInt:@"Id"]]];
            }
        }
        
        ADAPI_PersonalPreferenceSet([self genDelegatorID:@selector(onCommitAnswer:) strongData:[NSNumber numberWithBool:toNext]],
                                    [NSString stringWithFormat:@"%d",[_questions[_currentPage] getInt:@"Id"]],
                                    selectedOptions);
        
        return ;
    }
    
    // Not modified answers
    if(toNext)
    {
        [self gotoPage:_currentPage+1];
    }
    else
    {
        [super onMoveBack:nil];
    }
}

- (IBAction) onMoveFoward:(UIButton*) sender
{
    [self commitAnswer:TRUE];
}

- (IBAction) onMoveBack:(UIButton *)sender
{
    [self commitAnswer:FALSE];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [_answerStatus release];
    [_mainTable release];
    [_mainTableHead release];
    [_mainTitle release];
    [_UILineView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [_mainTable release];
    _mainTable = nil;
    [self setMainTableHead:nil];
    [self setMainTitle:nil];
    [super viewDidUnload];
}
@end
