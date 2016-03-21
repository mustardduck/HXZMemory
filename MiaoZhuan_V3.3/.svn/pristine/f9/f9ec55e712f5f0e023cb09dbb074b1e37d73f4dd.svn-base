//
//  PermissonViewController.m
//  miaozhuan
//
//  Created by abyss on 14/11/10.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "PermissonViewController.h"
#import "PSTCommonTableViewCell.h"
#import "PreviewViewController.h"
#import "CRHolderView.h"

@interface PermissonViewController ()<UIScrollViewDelegate>
{
    PSTCollectionView *_tableView;
    NSMutableArray *_dic;
}
@property (retain, nonatomic) IBOutlet UIScrollView *scrollerview;
@end

CGSize PermissonCellSize = {.height = 130,.width = 80};
UIEdgeInsets PermissonCellEdge = {.top = 20,.left = 20,.bottom = 0,.right = 20};
@implementation PermissonViewController

- (void)dealloc
{
    CRDEBUG_DEALLOC();
    [_dic release];
    
    [_scrollerview release];
    [super dealloc];
}

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    InitNav(@"兑换承诺书");
//    ADAPI_adv3_GetExchangePromiseList([self genDelegatorID:@selector(myHandle:)]);
    ADAPI_adv3_3_Enterprise_PicRes([self genDelegatorID:@selector(myHandle:)], @[@4001]);
    [self initCollectionView];
        // Do any additional setup after loading the view from its nib.
}

    
- (void)initCollectionView
{
    PSTCollectionViewFlowLayout *layout = WEAK_OBJECT(PSTCollectionViewFlowLayout, init);
    layout.sectionInset = PermissonCellEdge;
    layout.minimumInteritemSpacing = 10.f;
    layout.minimumLineSpacing = 10.f;
//    [layout setFooterReferenceSize:nil];
    
    CGRect frame = self.view.bounds;
    frame.size.height = SCREENHEIGHT - 64 - 40;
    frame.origin.y = 40;
    _tableView = WEAK_OBJECT(PSTCollectionView, initWithFrame:frame collectionViewLayout:layout);
    _tableView.delegate = self;
    _tableView.dataSource = self;
        
    _tableView.allowsMultipleSelection = NO;
    _tableView.backgroundColor = [UIColor whiteColor];
    
    [_tableView registerClass:[PSTCommonTableViewCell class] forCellWithReuseIdentifier:@"PSTCommonTableViewCell"];
        
    [_scrollerview addSubview:_tableView];
    
    
//    int num = (int)(((NSArray *)_dic).count)/3;
//    
//    //奇数
//    if ((((NSArray *)_dic).count) %3 == 1)
//    {
//        [_scrollerview setContentSize:CGSizeMake(SCREENWIDTH, 120 * num + 120 + 40)];
//    }
}
    
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)myHandle:(DelegatorArguments *)arg
{
    DictionaryWrapper *wrapper = arg.ret;
    [arg logError];
    if (wrapper.operationSucceed)
    {
        _dic = wrapper.data;
        [_dic retain];
        [_tableView reloadData];
        
        if(_dic.count == 0)
        {
            [self showHolderWithImg:nil text2:@"您还没有成功发布过银元广告\n所以没有兑换承诺书"];
        }
        else
        {
            [self displayHoder:NO];
        }
    }
    else
    {
        [HUDUtil showErrorWithStatus:wrapper.operationMessage];
    }
}

#pragma mark -
- (PSTCollectionViewCell *)collectionView:(PSTCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PSTCommonTableViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PSTCommonTableViewCell" forIndexPath:indexPath];
//    [cell.img requestIcon:[[_dic[indexPath.row] wrapper] getString:@"ExchangePromisePicUrl"]];
//    cell.label.text = [[_dic[indexPath.row] wrapper] getString:@"Name"];
    [cell.img requestIcon:[[_dic[indexPath.row] wrapper] getString:@"ResUrl"]];
    cell.label.text = [[_dic[indexPath.row] wrapper] getString:@"ResTitle"];
//    PSTCommonTableViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PSTCommonTableViewCell" forIndexPath:indexPath];
//    [cell.img requestIcon:[[_dic[indexPath.row] wrapper] getString:@"CertificationPicUrl"]];
//    cell.label.text = [[_dic[indexPath.row] wrapper] getString:@"Name"];
    return cell;
}
    
- (CGSize)collectionView:(PSTCollectionView *)collectionView layout:(PSTCollectionViewFlowLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return PermissonCellSize;
}
    
- (NSInteger)collectionView:(PSTCollectionView *)view numberOfItemsInSection:(NSInteger)section
{
    return ((NSArray *)_dic).count;
}
    
#pragma mark - 选中样式
    
- (void)collectionView:(PSTCollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    PSTCommonTableViewCell *cell = (PSTCommonTableViewCell *)[_tableView cellForItemAtIndexPath:indexPath];
//    PreviewViewController *p = WEAK_OBJECT(PreviewViewController, init);
//    p.dataArray = @[@{@"PictureUrl":[[_dic[indexPath.row] wrapper] getString:@"CertificationPicUrl"]}];
//    __block PreviewViewController *weakSelf = p;
//    [self presentViewController:p animated:NO completion:^(void)
//     {
//         weakSelf.pageControl.hidden = YES;
//         weakSelf.xlcycle.scrollView.scrollEnabled = NO;
//     }];
    PreviewViewController *p = WEAK_OBJECT(PreviewViewController, init);
//    NSString *url = [[_dic[indexPath.row] wrapper] getString:@"ExchangePromisePicUrl"];
    NSString *url = [[_dic[indexPath.row] wrapper] getString:@"ResUrl"];
    url = url?url:@"";
    p.dataArray = @[@{@"PictureUrl":url}];
    __block PreviewViewController *weakSelf = p;
    [self presentViewController:p animated:NO completion:^(void)
     {
         weakSelf.pageControl.hidden = YES;
     }];
}

- (void)collectionView:(PSTCollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    PSTCommonTableViewCell *cell = (PSTCommonTableViewCell *)[_tableView cellForItemAtIndexPath:indexPath];
}

@end