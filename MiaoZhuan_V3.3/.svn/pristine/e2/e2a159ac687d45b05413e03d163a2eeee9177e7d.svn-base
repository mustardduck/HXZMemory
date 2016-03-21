//
//  ShippingConsultViewController.m
//  miaozhuan
//
//  Created by apple on 14/12/29.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "ShippingConsultViewController.h"
#import "ShippingConsultTableViewCell.h"
#import "ShippingConsultTextViewController.h"
#import "RRLineView.h"
@interface ShippingConsultViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    DictionaryWrapper * dic ;
    
    NSArray * arrPhone;
}
@property (retain, nonatomic) IBOutlet UIButton *consultBtn;
@property (retain, nonatomic) IBOutlet UILabel *enterPhoneLable;
@property (retain, nonatomic) IBOutlet UIButton *enterPhoneBtn;
@property (retain, nonatomic) IBOutlet UITableView *mainTable;
@property (retain, nonatomic) IBOutlet UILabel *titleLable;


- (IBAction)touchUpInside:(id)sender;
@end

@implementation ShippingConsultViewController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    InitNav(@"商品咨询");
    
    RRLineView * line = [[RRLineView alloc] initWithFrame:CGRectMake(0, 193, 320, 0.5)];
    [self.view addSubview:line];
    
    ADAPI_adv3_GoldMall_ConsultSnap([self genDelegatorID:@selector(HandleNotification:)], _proterId,_type);
}

- (void)HandleNotification:(DelegatorArguments *)arguments
{
    if ([arguments isEqualToOperation:ADOP_adv3_GoldMall_ConsultSnap])
    {
        [arguments logError];
        
        DictionaryWrapper *wrapper = arguments.ret;
        
        if (wrapper.operationSucceed)
        {
            dic = wrapper.data;
            
            [dic retain];
            
            _enterPhoneLable.text = [dic getString:@"EnterprisePhone"];
            
            arrPhone = [dic getArray:@"ZditPhones"];
            
            _titleLable.text = [NSString stringWithFormat:@"向供货商家%@咨询",_enterName];
            
            [arrPhone retain];
            
            _mainTable.delegate = self;
            _mainTable.dataSource = self;
            
            [_mainTable reloadData];
            
            [_mainTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        }
        else if (wrapper.operationPromptCode || wrapper.operationErrorCode)
        {
            [AlertUtil showAlert:@"" message:wrapper.operationMessage buttons:@[@"好的"]];
            return;
        }
    }
}

- (IBAction)touchUpInside:(id)sender
{
    if (sender ==  _enterPhoneBtn)
    {
        [[UICommon shareInstance]makeCall:[dic getString:@"EnterprisePhone"]];
    }
    else if (sender == _consultBtn)
    {
        PUSH_VIEWCONTROLLER(ShippingConsultTextViewController);
        model.type = _type;
        model.proterId = [dic getString:@"ProductId"];
    }
}

#pragma mark - tableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrPhone count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ShippingConsultTableViewCell";
    
    ShippingConsultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ShippingConsultTableViewCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.layer.masksToBounds = YES;
    }
    
    cell.cellPhoneLable.text = [arrPhone objectAtIndex:indexPath.row];
    
    [cell.cellPhoneBtn addTarget:self action:@selector(phoneBtn:) forControlEvents:UIControlEventTouchUpInside];
    cell.cellPhoneBtn.tag = indexPath.row;
    
    if ([arrPhone count] == indexPath.row +1)
    {
        cell.cellLine.left = 0;
        cell.cellLine.top = 49.5;
    }
    return cell;
}


- (void)phoneBtn:(UIButton *)button
{
    [[UICommon shareInstance]makeCall:[arrPhone objectAtIndex:button.tag]];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)dealloc
{
    [dic release];
    [arrPhone release];
    [_consultBtn release];
    [_enterPhoneLable release];
    [_enterPhoneBtn release];
    [_mainTable release];
    [_titleLable release];
    [super dealloc];
}

- (void)viewDidUnload
{
    [self setConsultBtn:nil];
    [self setEnterPhoneLable:nil];
    [self setEnterPhoneBtn:nil];
    [super viewDidUnload];
}

@end
