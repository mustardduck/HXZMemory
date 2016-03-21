//
//  PsAdvertListViewController.m
//  miaozhuan
//
//  Created by 孙向前 on 15-3-17.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "PsAdvertListViewController.h"
#import "MJRefreshController.h"
#import "PutInCell.h"
#import "KxMenu.h"
#import "PSAsDetailController.h"

@interface PsAdvertListViewController ()<KxMenuDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) MJRefreshController *MJRefreshCon;
@property (retain, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation PsAdvertListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigateTitle:@"所有投放中的广告"];
     [self setupMoveFowardButtonWithImage:@"more.png" In:@"morehover.png"];
    [self setupMoveBackButton];
    
    [_MJRefreshCon release];
    _MJRefreshCon = nil;
    _MJRefreshCon = [[MJRefreshController controllerFrom:_tableview name:@"PublicService/GetPlayingAdverts"] retain];
    
    [self initTableView];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)initTableView
{
    NSString * refreshName = @"PublicService/GetPlayingAdverts";
    __block __typeof(self)weakself = self;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"service":[NSString stringWithFormat:@"%@%@", @"api/", refreshName]}];
    
    [_MJRefreshCon setURLGenerator:MJREFRESH_URL_GENERATOR_BLOCK{
        
        _orzId = _orzId.length ? _orzId : @"";
        [dic setValue:@{@"PageIndex":@(pageIndex), @"PageSize":@(pageSize), @"PublicServiceOrgId":_orzId} forKey:@"parameters"];
        return dic.wrapper;
    }];
    
    MJRefreshOnRequestDone block = MJREFRESH_ON_REQUEST_DONE
    {
        if(controller.refreshCount > 0)
        {
        }
        else
        {
            [weakself.tableview reloadData];
        }
    };
    
    [_MJRefreshCon setOnRequestDone:block];
    [_MJRefreshCon setPageSize:30];
    
    [self refreshTableView];
    
}

- (void) refreshTableView
{
    [_MJRefreshCon refreshWithLoading];
}

#pragma mark - UITableViewDelegate/UITableViewDatasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 145;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _MJRefreshCon.refreshCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    PutInCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PutInCell" owner:self options:nil] lastObject];
    }
    cell.lblSubTitle.hidden = YES;
    cell.dataDic = [_MJRefreshCon.refreshData[indexPath.row] wrapper];
    cell.lblTitle.top = 145 / 2 - cell.lblTitle.height / 2;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DictionaryWrapper *dic = [_MJRefreshCon.refreshData[indexPath.row] wrapper];
    PUSH_VIEWCONTROLLER(PSAsDetailController);
    model.notShow = YES;
    model.adId = [dic getString:@"Id"];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - actions
//商家详情
- (IBAction)onMoveFoward:(UIButton*) sender{
    
    // show menu
    if(![KxMenu isOpen])
    {
        NSMutableArray *menuItems = [NSMutableArray arrayWithCapacity:0];

        [menuItems addObject:[KxMenuItem menuItem:@"首页"
                                                image:[UIImage imageNamed:@"ads_home"]
                                            highlight:[UIImage imageNamed:@"ads_homehover"]
                                               target:self
                                               action:@selector(pushMenuItem:)]];

        CGRect rect = sender.frame;
        rect.origin.y = self.navigationController.navigationBar.frame.size.height;
        
        [KxMenu showMenuInView:self.navigationController.view
                      fromRect:rect
                     menuItems:menuItems
                     itemWidth:140.f];
        [KxMenu sharedMenu].delegate = self;
    }
    else
    {
        [KxMenu dismissMenu];
    }
    
    
}

//打开Menu
- (void) pushMenuItem:(id)sender
{
    //    NSLog(@"%@", sender);
}

-(void)which_tag_clicked:(int)tag
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc {
    [_tableview release];
    [super dealloc];
}
@end
