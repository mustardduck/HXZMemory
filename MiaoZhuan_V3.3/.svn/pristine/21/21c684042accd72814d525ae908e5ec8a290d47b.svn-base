//
//  IWCompanyNatureViewController.m
//  miaozhuan
//
//  Created by admin on 15/4/27.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "IWCompanyTreatmentViewController.h"
#import "IWCompanyTreatmentCell.h"

@interface IWCompanyTreatmentViewController ()<UITableViewDataSource,UITableViewDelegate>{
    
    UINib *nib;
}

@property (retain, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation IWCompanyTreatmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if(nil == _selectedItems){
        _selectedItems = [[NSMutableArray alloc] init];
    }
    
    InitNav(@"福利待遇");
    
    [self setupMoveFowardButtonWithTitle:@"保存"];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.view.backgroundColor = RGBACOLOR(239, 239, 244, 1);
    self.tableView.backgroundColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- custom events
#pragma mark -- 保存
- (void)onMoveFoward:(UIButton*) sender{
    if(self.finished){
        self.finished(_selectedItems);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark -- uitableview delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _chooseItems.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kIWCompanyTreatmentCellHeight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1.f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identy = @"IWCompanyTreatmentCell_reuseIdentifier";
    if (!nib) {
        nib = [UINib nibWithNibName:@"IWCompanyTreatmentCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:identy];
    }
    IWCompanyTreatmentCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    cell.changed = ^(BOOL selected){
        if(selected){
            if(![_selectedItems containsObject:indexPath]){
                [_selectedItems addObject:indexPath];
            }           
        }else{
            [_selectedItems removeObject:indexPath];
        }
    };
    [cell setIsSelected:[_selectedItems containsObject:indexPath]];
    
    cell.label_Title.text = _chooseItems[indexPath.row];
    
    cell.bottomLine.hidden = (indexPath.row == _chooseItems.count - 1);
    
    
    return cell;
}

@end
