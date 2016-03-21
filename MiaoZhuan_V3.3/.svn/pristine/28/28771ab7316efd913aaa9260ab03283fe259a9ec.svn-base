//
//  YinYuanAdvertEditSubController.m
//  miaozhuan
//
//  Created by momo on 14-11-19.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "YinYuanAdvertEditSubController.h"
#import "SelectIncomeCell.h"
#import "RRLineView.h"

@interface YinYuanAdvertEditSubController ()

@property (retain, nonatomic) IBOutlet RRLineView *line;


@end

@implementation YinYuanAdvertEditSubController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setNavigateTitle:_naviTitle];
    [self setupMoveBackButton];
    [self setupMoveFowardButtonWithTitle:@"保存"];
    
    _sexType = 0;
    
    _quesArr = STRONG_OBJECT(NSMutableArray, init);
    
    _selQuesArr = STRONG_OBJECT(NSMutableArray, init);
    
    _agePicker = [[AgePicker alloc]initWithStyle:self];
    
    CGFloat offset = [UICommon getIos4OffsetY];
    
    _agePicker.frame = CGRectMake(0, 0, 320, 460 + offset);
    
    _agePicker.isAll = YES;
    
    self.minAge = @"0";
    
    self.maxAge = @"100";

    [_agePicker displayAgeView];
    
    if([_userDic allKeys].count)
    {
        _srcData = STRONG_OBJECT(NSMutableDictionary, initWithDictionary:_userDic);
        
        _sexType = [_srcData.wrapper getInt:@"PutSex"];

        [self displayUserView];

    }
    else
    {
        _srcData = STRONG_OBJECT(NSMutableDictionary, init);
        
        [_srcData setObject:@"1" forKey:@"isQuesAll"];
        
        [_srcData setObject:@"0" forKey:@"PutSex"];
        
        [_srcData setObject:@"0" forKey:@"PutMinAge"];
        
        [_srcData setObject:@"100" forKey:@"PutMaxAge"];
    }
    
    ADAPI_adv3_CustomerSurvey_GetQuestion([self genDelegatorID:@selector(handleGetQuestion:)], @"9", @"");
    
    [self fixView];
}

- (void) fixView
{
    _line.top = 49.5;
}

- (void) displayUserView
{
    [self changeSexText];

    [self changeMoneyText];
    
    [self setSelectTableView];
    
    [self changeAgeText];
}

- (void) changeAgeText
{
    self.minAge = [_srcData.wrapper getString:@"PutMinAge"];
    self.maxAge = [_srcData.wrapper getString:@"PutMaxAge"];
    
    NSString * ageText = @"";
    
    if([_minAge intValue] == 0 && [_maxAge intValue] == 100)
    {
        ageText = @"不限";
        _agePicker.isAll = YES;
        _agePicker.firstText = ageText;
        _agePicker.secondText = @"0";
    }
    else
    {
        ageText = [NSString stringWithFormat:@"%@ - %@ 岁", _minAge, _maxAge ];
        _agePicker.isAll = NO;
        _agePicker.firstText = _minAge;
        _agePicker.secondText = _maxAge;
    }
    
    [_ageBtn setTitle:ageText forState:UIControlStateNormal];
}

- (void)handleGetQuestion:(DelegatorArguments*)arguments
{
    [arguments logError];
    
    DictionaryWrapper *wrapper = arguments.ret;
    
    if (wrapper.operationSucceed)
    {
        [_quesArr removeAllObjects];
        
        NSMutableDictionary * dic = WEAK_OBJECT(NSMutableDictionary, init);
        [dic setObject:@"0" forKey:@"Id"];
        [dic setObject:@"不限" forKey:@"Text"];
        [_quesArr addObject:dic];

        [_quesArr addObjectsFromArray:[wrapper.data getArray:@"Options"]];
        
        [_incomeTableview reloadData];
    }
    else
    {
        [HUDUtil showErrorWithStatus:wrapper.operationMessage];
    }
}

- (void) onMoveBack:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) onMoveFoward:(UIButton *)sender
{
    [_srcData setObject:[NSNumber numberWithInteger:_sexType] forKey:@"PutSex"];
    
    if([_agePicker.firstText isEqualToString:@"不限"])
    {
        [_srcData setObject:@"0" forKey:@"PutMinAge"];
        
        [_srcData setObject:@"100" forKey:@"PutMaxAge"];
    }
    else
    {
        [_srcData setObject:_agePicker.firstText forKey:@"PutMinAge"];
        
        [_srcData setObject:_agePicker.secondText forKey:@"PutMaxAge"];
    }

    [_delegate passAdvertUser:_srcData];
    
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSInteger sheetTag = actionSheet.tag;
    
    if (sheetTag == 101) {
        
        if (buttonIndex != 3) {
            
            _sexType = buttonIndex;
            
            [self changeSexText];
        }
    }
}

- (void)changeSexText
{
    if (_sexType == 0) {
        
        [_sexBtn setTitle:@"不限" forState:UIControlStateNormal];
    }
    else if (_sexType == 1){
        
        [_sexBtn setTitle:@"男" forState:UIControlStateNormal];
    }
    else if (_sexType == 2){
        
        [_sexBtn setTitle:@"女" forState:UIControlStateNormal];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setSelectTableView
{
    NSArray * arr = [_srcData.wrapper getArray:@"PutAnnualIncomeOptions"];
    
    int isAll = [_srcData.wrapper getInt:@"isQuesAll"];
    
    if(isAll == 1)
    {
        [_selQuesArr removeAllObjects];
        NSMutableDictionary * dic = WEAK_OBJECT(NSMutableDictionary, init);
        [dic setObject:@"0" forKey:@"Id"];
        [dic setObject:@"不限" forKey:@"Text"];
        [_selQuesArr addObject:dic];
        
        _isQuesAll = YES;
    }
    else
    {
        for (NSDictionary * dic in arr)
        {
            NSString * optId = [dic.wrapper getString:@"Id"];
            
            if([optId isEqualToString:@"0"])
            {
                _isQuesAll = YES;
            }
            
            [_selQuesArr addObject:dic];
        }
    }

    [_incomeTableview reloadData];

}

- (void)changeMoneyText
{
    NSString * incomeStr = @"";

    if([[_srcData.wrapper getString:@"isQuesAll"] intValue] == 1)
    {
        incomeStr = [incomeStr stringByAppendingString:@"不限"];
    }
    else
    {
        NSArray * arr = [_srcData.wrapper getArray:@"PutAnnualIncomeOptions"];
        
        for (NSDictionary * dic in arr)
        {
            incomeStr = [incomeStr stringByAppendingString:[NSString stringWithFormat:@"%@、", [dic valueForKey:@"Text"]]];

        }
        
        if([[incomeStr substringFromIndex:(incomeStr.length - 1)] isEqualToString:@"、"])
        {
            incomeStr = [incomeStr substringToIndex:incomeStr.length - 1];
        }
    }
    
    [_moneyBtn setTitle:incomeStr forState:UIControlStateNormal];
    
}

- (IBAction)touchUpInsideOnBtn:(id)sender
{
    UIButton * btn = (UIButton *) sender;
    
    if(sender == _sexBtn)
    {
        UIActionSheet *actionSheet = [[[UIActionSheet alloc]
                                       initWithTitle:@"选择性别"
                                       delegate:self
                                       cancelButtonTitle:@"取消"
                                       destructiveButtonTitle:nil
                                       otherButtonTitles:@"不限", @"男",@"女",nil]autorelease];
        
        actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
        
        [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
        
        actionSheet.tag = 101;

    }
    else if (sender == _moneyBtn)
    {
        _incomeView.hidden = NO;
        
        CGRect rect = _incomeTableview.frame;
        rect.size.height = 217;
        _incomeTableview.frame = rect;
        
        rect = _incomeSubView.frame;
        rect.size.height = YH(_incomeTableview);
        rect.origin.y = H(self.view) - H(_incomeSubView);
        _incomeSubView.frame = rect;
        
        if([_moneyBtn.titleLabel.text isEqualToString:@"不限"])
        {
            _isQuesAll = YES;
            
            NSMutableDictionary * dic = WEAK_OBJECT(NSMutableDictionary, init);
            [dic setObject:@"0" forKey:@"Id"];
            [dic setObject:@"不限" forKey:@"Text"];
            [_selQuesArr addObject:dic];
            
            [_incomeTableview reloadData];
        }
    }
    else if (sender == _ageBtn)
    {
        _agePicker.firstText = _minAge;
        
        _agePicker.secondText = _maxAge;
        
        [_agePicker displayAgeView];
        
        [self.view addSubview:_agePicker];
    }
    else if (sender == _fullScreenBtn)
    {
        _incomeView.hidden = YES;
    }
    else if (sender == _cancelBtn)
    {
        _incomeView.hidden = YES;
        
        [_selQuesArr removeAllObjects];
    }
    else if (sender == _okBtn)
    {
        if(_selQuesArr.count)
        {
            _incomeView.hidden = YES;
            
            [self changeMoneyText];
        }
    }
    else if (btn.tag >= 1000)
    {
        NSInteger index = btn.tag - 1000;
        
        [self changeItemSelByIndex:index];
    }
}

- (NSInteger) isSelWare:(DictionaryWrapper *)dic{
    
    NSString *wareId = [dic getString:@"Id"];
    
    for (NSDictionary * tempDic in _selQuesArr)
    {
        NSString *tempId = @"";
        
        tempId = [tempDic.wrapper getString:@"Id"];
        
        if ([wareId isEqualToString:tempId]) {
            
            return 1;
        }
    }
    
    return 0;
}

- (void) changeItemSelByIndex:(NSInteger)index{
    
    if (index >= 0&&index < [_quesArr count]) {
        
        NSDictionary *dic = [_quesArr objectAtIndex:index];
        
        NSIndexPath *curPath = [NSIndexPath indexPathForRow:index inSection:0];
        
        SelectIncomeCell *cell = (SelectIncomeCell *)[_incomeTableview cellForRowAtIndexPath:curPath];

        NSInteger selNum = [self isSelWare:dic.wrapper];
        
        if (selNum == 0) {
            
            if(index == 0 && !_isQuesAll)//选中不限
            {
                _isQuesAll = YES;
                
                [_srcData removeObjectForKey:@"PutAnnualIncomeOptions"];
                
                [_srcData setObject:@"1" forKey:@"isQuesAll"];
                
                [_selQuesArr removeAllObjects];
                
                [_selQuesArr addObject:dic];
                
                cell.iconView.image = [UIImage imageNamed:@"findShopfilterSelectBtn"];
                
                [_incomeTableview reloadData];
            }
            else if(!_isQuesAll)
            {
                [_selQuesArr addObject:dic];
                
                cell.iconView.image = [UIImage imageNamed:@"findShopfilterSelectBtn"];
                
                [_srcData setObject:@"0" forKey:@"isQuesAll"];

            }
        }
        else {
            
            if(index == 0 && _isQuesAll)//取消不限
            {
                _isQuesAll = NO;
                
                [_selQuesArr removeObject:dic];
                
                cell.iconView.image = [UIImage imageNamed:@"findShopfilterBtn"];
                
                [_srcData setObject:@"0" forKey:@"isQuesAll"];

            }
            else if (!_isQuesAll)
            {
                [_selQuesArr removeObject:dic];
                
                cell.iconView.image = [UIImage imageNamed:@"findShopfilterBtn"];
                
                [_srcData setObject:@"0" forKey:@"isQuesAll"];

            }
            
        }
        
        if(_selQuesArr.count)
        {
            [_srcData setObject:_selQuesArr forKey:@"PutAnnualIncomeOptions"];
        }
    }
}

#pragma mark UITableViewDelegate and UITableViewDatasource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _quesArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"SelectIncomeCell";
    
    SelectIncomeCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SelectIncomeCell" owner:self options:nil] firstObject];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSInteger index = [indexPath row];
    
    DictionaryWrapper * dic = [_quesArr[index] wrapper];
    
    cell.titleLbl.text = [dic getString:@"Text"];
    
    cell.iconBtn.tag = 1000 + index;
    
    [cell.iconBtn addTarget:self action:@selector(touchUpInsideOnBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    NSInteger allNum = [self isSelWare:dic];
    
    cell.iconView.image = allNum ? [UIImage imageNamed:@"findShopfilterSelectBtn"] : [UIImage imageNamed:@"findShopfilterBtn"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark AgePickerDelegate

- (void) pickerAgeCancel:(AgePicker *)picker
{
    [picker removeFromSuperview];
}

- (void) pickerAgeOk:(AgePicker *)picker
{
    [_ageBtn setTitle:picker.curText forState:UIControlStateNormal];
    
    self.minAge = picker.firstText;
    
    self.maxAge = picker.secondText;
    
    [picker removeFromSuperview];
}

- (void) pickerAgeDidChaneStatus:(AgePicker *)picker
{
    
}


- (void)dealloc {
    
    [_quesArr release];
    _quesArr = nil;
    
    [_selQuesArr release];
    _selQuesArr = nil;
    
    [_srcData release];
    _srcData = nil;
    
    [_sexBtn release];
    [_moneyBtn release];
    [_ageBtn release];
    [_incomeTableview release];
    [_incomeView release];
    [_cancelBtn release];
    [_okBtn release];
    [_incomeSubView release];
    [_fullScreenBtn release];
    [_line release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setSexBtn:nil];
    [self setMoneyBtn:nil];
    [self setAgeBtn:nil];
    [self setIncomeTableview:nil];
    [self setIncomeView:nil];
    [super viewDidUnload];
}
@end
