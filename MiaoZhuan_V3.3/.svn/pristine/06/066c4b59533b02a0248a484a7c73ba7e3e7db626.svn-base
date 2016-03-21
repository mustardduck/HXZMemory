//
//  IWComplaintViewController.m
//  miaozhuan
//
//  Created by admin on 15/5/4.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "IWComplaintViewController.h"
#import "IWComplainReasonListTableViewCellStyle1.h"
#import "IWComplainReasonListTableViewCellStyle2.h"
#import "SharedData.h"
#import "API_PostBoard.h"
#import "Model_PostBoard.h"


@interface IWComplaintViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *_reasonsList;
    NSUInteger _reasonIndex;
}
@property (retain, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation IWComplaintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    InitNav(@"举报");
    
    [self setupMoveFowardButtonWithTitle:@"提交"];
    
    _reasonIndex = -1;
    
//    _reasonsList = [[NSMutableArray alloc] initWithObjects:@"色情",@"欺诈",@"谣言",@"广告骚扰",@"诱导分享",@"政治敏感",@"隐私信息收集",@"其他原因", nil];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"IWComplainReasonListTableViewCellStyle1" bundle:nil] forCellReuseIdentifier:@"IWComplainReasonListTableViewCellStyle1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"IWComplainReasonListTableViewCellStyle2" bundle:nil] forCellReuseIdentifier:@"IWComplainReasonListTableViewCellStyle2"];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUpdateSuccessAction:) name:UpdateSuccessAction object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUpdateFailureAction:) name:UpdateFailureAction object:nil];
    
    if ([[SharedData getInstance].postBoardReportReasionList count] != 0) {
        _reasonsList = [SharedData getInstance].postBoardReportReasionList;
    }else{
        [[API_PostBoard getInstance] engine_outside_postBoard_reportReasonList];
    }
}

- (void)handleUpdateSuccessAction:(NSNotification *)note
{
    
    NSDictionary *dict = [note userInfo];
    update_type type = [[dict objectForKey:@"update"]intValue];
    int ret = [[dict objectForKey:@"ret"] intValue];
    
    if(type == ut_postBoard_reportReasonList)
    {
        if(ret == 1)
        {
            _reasonsList = [SharedData getInstance].postBoardReportReasionList;
            [_tableView reloadData];
        }else{
            [HUDUtil showSuccessWithStatus:dict[@"msg"]];
        }
    }
}

-(void) handleUpdateFailureAction:(NSNotification *) note{
    
    [HUDUtil showErrorWithStatus:@"数据加载失败"];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- 提交举报
- (void)onMoveFoward:(UIButton*) sender{
    
    ReportReasonInfo *obj = _reasonsList[_reasonIndex];
    
#warning inout reason need value
    if (self.complaint) {
        self.complaint(obj.code,@"input reason");
        
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- uiscrollview delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    IWComplainReasonListTableViewCellStyle2 *cell = (IWComplainReasonListTableViewCellStyle2 *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:(_reasonsList.count - 1) inSection:0]];
    if(cell){
       [cell.textView resignFirstResponder];
    }
    
}

#pragma mark -- uitableview delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _reasonsList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == _reasonsList.count - 1)return kIWComplainReasonListTableViewCellStyle2Height;
    return kIWComplainReasonListTableViewCellStyle1Height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == _reasonsList.count - 1){
        IWComplainReasonListTableViewCellStyle2 *cell = [self.tableView dequeueReusableCellWithIdentifier:@"IWComplainReasonListTableViewCellStyle2"];
       ReportReasonInfo *obj = _reasonsList[indexPath.row];
        cell.label_Title.text = obj.reason;
        
        if(indexPath.row == _reasonIndex){
            cell.imageView_Check.hidden = NO;
            cell.label_Title.textColor = RGBACOLOR(240, 5, 0, 1);
            cell.view_BottomView.backgroundColor = RGBACOLOR(255, 255, 255, 1);
        }else{
            cell.imageView_Check.hidden = YES;
            cell.label_Title.textColor = RGBACOLOR(34, 34, 34, 1);
            cell.view_BottomView.backgroundColor = RGBACOLOR(239, 239, 244, 1);
        }
        cell.textView.editable = !cell.imageView_Check.hidden;
        [cell.textView resignFirstResponder];
        
        cell.textViewShouldBeginInput = ^{
            [UIView animateWithDuration:0.2 animations:^{
                [self.tableView setContentOffset:CGPointMake(0, 360.f)];
            }];            
        };
        cell.textViewShouldEndInput = ^{
            [UIView animateWithDuration:0.2 animations:^{
                [self.tableView setContentOffset:CGPointMake(0, 140.f)];
            }];
        };
        
        return cell;
    }
    
    
    IWComplainReasonListTableViewCellStyle1 *cell = [self.tableView dequeueReusableCellWithIdentifier:@"IWComplainReasonListTableViewCellStyle1"];
     ReportReasonInfo *obj = _reasonsList[indexPath.row];
    cell.label_Title.text = obj.reason;
    if(indexPath.row == _reasonIndex){
        cell.imageView_Check.hidden = NO;
        cell.label_Title.textColor = RGBACOLOR(240, 5, 0, 1);
    }else{
        cell.imageView_Check.hidden = YES;
        cell.label_Title.textColor = RGBACOLOR(34, 34, 34, 1);
    }
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(_reasonIndex != indexPath.row){
        _reasonIndex = indexPath.row;
        [tableView reloadData];
    }
}


@end
