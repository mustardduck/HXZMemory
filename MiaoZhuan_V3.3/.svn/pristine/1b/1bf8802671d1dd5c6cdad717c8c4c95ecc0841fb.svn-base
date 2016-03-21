//
//  IViewController.m
//  guanggaoban
//
//  Created by Santiago on 14-10-20.
//  Copyright (c) 2014年 Arvin. All rights reserved.
//

#import "IViewController.h"
#import "ITableViewCell1.h"
#import "ITableViewCell2.h"

@interface IViewController ()<UITableViewDelegate,UITableViewDelegate>

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSArray *imageSource;
@end

@implementation IViewController

@synthesize myTable = _myTable;
@synthesize footer = _footer;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self initNav];
    [self setFooter];
    self.dataSource = @[@[@"个人认证",@"感恩机制"],@[@"我的银元",@"我的现金",@"我的广告金币"],@[@"通用设置",@"关于秒赚"]];
    self.imageSource = @[@[@"zhuanzhang",@"zhuanzhang"],@[@"zhuanzhang",@"zhuanzhang",@"zhuanzhang"],@[@"zhuanzhang",@"zhuanzhang"]];
    [_myTable registerNib:[UINib nibWithNibName:@"ITableViewCell1" bundle:nil] forCellReuseIdentifier:@"ITableViewCell1"];
    [_myTable registerNib:[UINib nibWithNibName:@"ITableViewCell2" bundle:nil] forCellReuseIdentifier:@"ITableViewCell2"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//导航栏
- (void)initNav
{
    [self setNavigateTitle:@"我"];
    [self setupMoveFowardButtonWithImage:@"zhuanzhang" In:@"zhuanzhang"];
    [self setupMoveBackButton];
}

- (void)setFooter {
    
    _footer = [[NSBundle mainBundle]loadNibNamed:@"IViewController" owner:self options:nil][1];
    [self.watchAdImage setImage:[UIImage imageNamed:@"zhuanzhang"]];
    [self.sendAdImage setImage:[UIImage imageNamed:@"zhuanzhang"]];
    [self.IPageImage setImage:[UIImage imageNamed:@"zhuanzhang"]];
    
    self.watchAdLabel.text = @"看广告";
    self.sendAdLabel.text = @"发广告";
    self.IPageLabel.text = @"我的";
    [_footer setBackgroundColor:[UIColor lightGrayColor]];
    [_myTable setTableFooterView:_footer];

}


#pragma mark - UITableViewDelagate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 8;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView *temp = [[UIView alloc] init];
    [temp setBackgroundColor:[UIColor clearColor]];
    return temp;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    int rowsInSection = 0;

    switch (section) {
        case 0:
            rowsInSection =  1;
            break;
        case 1:
            rowsInSection =  2;
            break;
        case 2:
            rowsInSection =  3;
            break;
        case 3:
            rowsInSection =  2;
            break;
        default:
            break;
    }
    return rowsInSection;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        ITableViewCell1 *cell;
        cell = [_myTable dequeueReusableCellWithIdentifier:@"ITableViewCell1" forIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        //设置信息
        return cell;
    }else{
        
        ITableViewCell2 *cell;
        cell = [_myTable dequeueReusableCellWithIdentifier:@"ITableViewCell2" forIndexPath:indexPath];
        cell.textLabel.text = [[self.dataSource objectAtIndex:indexPath.section-1]objectAtIndex:indexPath.row];
        cell.imageView.image = [UIImage imageNamed:[[self.imageSource objectAtIndex:indexPath.section-1]objectAtIndex:indexPath.row]];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        //第一个cell手机实名认证标识
        //设置image
        return cell;
        
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 4;
}

- (void)dealloc {
    [_myTable release];
    [_watchAdImage release];
    [_sendAdImage release];
    [_IPageImage release];
    [_watchAdLabel release];
    [_sendAdLabel release];
    [_IPageLabel release];
    [super dealloc];
}

- (void)viewDidUnload {
    [self setMyTable:nil];
    [self setWatchAdImage:nil];
    [self setSendAdImage:nil];
    [self setIPageImage:nil];
    [self setWatchAdLabel:nil];
    [self setSendAdLabel:nil];
    [self setIPageLabel:nil];
    [super viewDidUnload];
}
@end
