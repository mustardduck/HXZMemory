//
//  ZiZhiViewController.m
//  miaozhuan
//
//  Created by abyss on 14/11/10.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "ZiZhiViewController.h"
#import "PSTCommonTableViewCell.h"
#import "PreviewViewController.h"

@interface ZiZhiViewController ()
{
    PSTCollectionView *_tableView;
    
    NSMutableArray *_dic;
}
@end

CGSize ZiZhiCellSize = {.height = 130,.width = 80};
UIEdgeInsets ZiZhiCellEdge = {.top = 20,.left = 20,.bottom = 0,.right = 20};
@implementation ZiZhiViewController

- (void)dealloc
{
    CRDEBUG_DEALLOC();
    [_dic release];
    
    [super dealloc];
}

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    [super viewDidLoad];
    
    InitNav(@"商家资质");
//    ADAPI_adv3_GetCertificationList([self genDelegatorID:@selector(myHandle:)]);
    
    ADAPI_adv3_3_Enterprise_PicRes([self genDelegatorID:@selector(myHandle:)], @[@1101,@1102,@1103]);
    
    [self initCollectionView];
    // Do any additional setup after loading the view from its nib.
}

- (void)initCollectionView
{
    PSTCollectionViewFlowLayout *layout = WEAK_OBJECT(PSTCollectionViewFlowLayout, init);
    layout.sectionInset = ZiZhiCellEdge;
    layout.minimumInteritemSpacing = 10.f;
    layout.minimumLineSpacing = 10.f;
//    [layout setFooterReferenceSize:nil];
    
    CGRect frame = self.view.bounds;
    frame.size.height -= 40 + (SCREENHEIGHT>560?0:88);
    frame.origin.y = 33;
    _tableView = WEAK_OBJECT(PSTCollectionView, initWithFrame:frame collectionViewLayout:layout);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _tableView.allowsMultipleSelection = NO;
    _tableView.backgroundColor = [UIColor whiteColor];
    
    [_tableView registerClass:[PSTCommonTableViewCell class] forCellWithReuseIdentifier:@"PSTCommonTableViewCell"];

    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning {
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
    }
    else
    {
        [HUDUtil showErrorWithStatus:wrapper.operationMessage];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - 
- (PSTCollectionViewCell *)collectionView:(PSTCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    PSTCommonTableViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PSTCommonTableViewCell" forIndexPath:indexPath];
//    [cell.img requestIcon:[[_dic[indexPath.row] wrapper] getString:@"CertificationPicUrl"]];
    [cell.img requestIcon:[[_dic[indexPath.row] wrapper] getString:@"ResUrl"]];
    cell.label.text = [[_dic[indexPath.row] wrapper] getString:@"ResTitle"];
//    cell.label.text = [[_dic[indexPath.row] wrapper] getString:@"Name"];
//    PSTCommonTableViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PSTCommonTableViewCell" forIndexPath:indexPath];
//    [cell.img requestIcon:[[_dic[indexPath.row] wrapper] getString:@"ExchangePromisePicUrl"]];
//    cell.label.text = [[_dic[indexPath.row] wrapper] getString:@"Name"];
    return cell;
}

- (CGSize)collectionView:(PSTCollectionView *)collectionView layout:(PSTCollectionViewFlowLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return ZiZhiCellSize;
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
//    NSString *url = [[_dic[indexPath.row] wrapper] getString:@"ExchangePromisePicUrl"];
//    url = url?url:@"";
//    p.dataArray = @[@{@"PictureUrl":url}];
//    __block PreviewViewController *weakSelf = p;
//    [self presentViewController:p animated:NO completion:^(void)
//     {
//         weakSelf.pageControl.hidden = YES;
//         weakSelf.xlcycle.scrollView.scrollEnabled = NO;
//     }];
    PreviewViewController *p = WEAK_OBJECT(PreviewViewController, init);
//    p.dataArray = @[@{@"PictureUrl":[[_dic[indexPath.row] wrapper] getString:@"CertificationPicUrl"]}];
    p.dataArray = @[@{@"PictureUrl":[[_dic[indexPath.row] wrapper] getString:@"ResUrl"]}];
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
