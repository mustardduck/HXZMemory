//
//  SJZZController.m
//  miaozhuan
//
//  Created by momo on 15/6/2.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "SJZZController.h"
#import "PSTCollectionView.h"
#import "PSTCommonTableViewCell.h"
#import "BaserHoverView.h"
#import "PreviewViewController.h"


@interface SJZZController () <PSTCollectionViewDataSource,PSTCollectionViewDelegate>
{
    PSTCollectionView *_tableView;
    
    NSMutableArray *_dic;
    
    NSMutableArray * _zzArr;
    NSMutableArray * _clsArr;
    NSMutableArray * _csArr;
    
    NSMutableArray * _curArr;

}

@property (retain, nonatomic) IBOutlet UIButton *firstBtn;
@property (retain, nonatomic) IBOutlet UIButton *secondBtn;
@property (retain, nonatomic) IBOutlet UIButton *thirdBtn;
@property (nonatomic, retain) UIButton *buttonClick;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *constraintLine;

@end

CGSize ZiZhiCellSize2 = {.height = 130,.width = 80};
UIEdgeInsets ZiZhiCellEdge2 = {.top = 20,.left = 20,.bottom = 0,.right = 20};
@implementation SJZZController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavigateTitle:@"商家资质"];
    [self setupMoveBackButton];
    
    _zzArr = STRONG_OBJECT(NSMutableArray, init);
    _clsArr = STRONG_OBJECT(NSMutableArray, init);
    _csArr = STRONG_OBJECT(NSMutableArray, init);
    _curArr = STRONG_OBJECT(NSMutableArray, init);
    
    [self initCollectionView];
    
    ADAPI_adv3_EnterpriseCustomerGetPicRes([self genDelegatorID:@selector(HandleNotification:)], _enterpId, @[]);
    
}

- (void)dealloc
{
    CRDEBUG_DEALLOC();
    [_dic release];
    
    [_zzArr release];
    [_clsArr release];
    [_csArr release];
    [_curArr release];
    
    [_firstBtn release];
    [_secondBtn release];
    [_thirdBtn release];
    [_constraintLine release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidAppear:(BOOL)animated
{
}

- (IBAction)touchUpInsideOn:(UIButton *)sender {
    
    [UIView animateWithDuration:0.3f animations:^{
        self.constraintLine.constant = sender.frame.origin.x;
    }];
     
     if(sender.tag == 0 && (self.buttonClick == nil)) {
         self.buttonClick = sender; return;
     }else if ( (self.buttonClick == nil ) && sender.tag != 0){
         [self.firstBtn setTitleColor:[UIColor titleBlackColor] forState:UIControlStateNormal];
         self.firstBtn.titleLabel.font = [UIFont systemFontOfSize:14];
         
     }
     if (sender == self.buttonClick) return;
    
    [self.buttonClick setTitleColor:[UIColor titleBlackColor] forState:UIControlStateNormal];
    self.buttonClick.titleLabel.font = [UIFont systemFontOfSize:14];
    
    self.buttonClick = sender;
    
    [self.buttonClick setTitleColor:[UIColor titleRedColor] forState:UIControlStateNormal];
    self.buttonClick.titleLabel.font = [UIFont systemFontOfSize:17];
    
    [_curArr removeAllObjects];

    if(sender.tag == 0)
    {
        if(_zzArr.count)
        {
            [_curArr addObjectsFromArray:_zzArr];
        }
    }
    else if (sender.tag == 1)
    {
        if(_clsArr.count)
        {
            [_curArr addObjectsFromArray:_clsArr];
        }
    }
    else if (sender.tag == 2)
    {
        if(_csArr.count)
        {
            [_curArr addObjectsFromArray:_csArr];
        }
    }
    
    if(_curArr.count)
    {
        _tableView.hidden = NO;
        
        [_tableView reloadData];
    }
    else
    {
        _tableView.hidden = YES;

        [self createHoverViewWhenNoData:sender.tag];
    }
    
}


- (void)initCollectionView
{
    PSTCollectionViewFlowLayout *layout = WEAK_OBJECT(PSTCollectionViewFlowLayout, init);
    layout.sectionInset = ZiZhiCellEdge2;
    layout.minimumInteritemSpacing = 10.f;
    layout.minimumLineSpacing = 10.f;
    //    [layout setFooterReferenceSize:nil];
    
    CGRect frame = self.view.bounds;
    frame.origin.y = 40;
    frame.size.height -= (frame.size.height >= 568 ? 104 : 0);
    _tableView = WEAK_OBJECT(PSTCollectionView, initWithFrame:frame collectionViewLayout:layout);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _tableView.allowsMultipleSelection = NO;
    _tableView.backgroundColor = [UIColor whiteColor];
    
    [_tableView registerClass:[PSTCommonTableViewCell class] forCellWithReuseIdentifier:@"PSTCommonTableViewCell"];
    
    [self.view addSubview:_tableView];
}

- (void)HandleNotification:(DelegatorArguments *)arg
{
    DictionaryWrapper *wrapper = arg.ret;
    [arg logError];
    if (wrapper.operationSucceed)
    {
        _dic = wrapper.data;
        
        for(NSDictionary * dic in _dic)
        {
            int resType = [dic.wrapper getInt:@"BusinessResType"];
            if(resType == 1101 || resType == 1102 || resType == 1103)
            {
                [_zzArr addObject:dic];
            }
            else if (resType == 1106)//营业场所
            {
                [_csArr addObject:dic];
            }
            else if (resType == 4001)//兑换承诺书
            {
                [_clsArr addObject:dic];
            }
        }
        
        if(_zzArr.count > 0)
        {
            [_curArr addObjectsFromArray:_zzArr];
        }
        
        if(_curArr.count)
        {
            _tableView.hidden = NO;
        }
        else
        {
            [self createHoverViewWhenNoData:0];
        }
        
        [_dic retain];
        [_tableView reloadData];
    }
    else
    {
        [HUDUtil showErrorWithStatus:wrapper.operationMessage];
    }
}

- (void) createHoverViewWhenNoData:(int)tag
{
    
    BaserHoverView * hover = (BaserHoverView *)[self.view viewWithTag:1111];
    
    NSString * titleName = @"";
    
    switch (tag) {
        case 0:
            titleName = @"该商家暂时没有上传商家资质，请查看其他图片";
            break;
        case 1:
            titleName = @"该商家暂时没有上传兑换承诺书，请查看其他图片";
            break;
        case 2:
            titleName = @"该商家暂时没有上传经营场所，请查看其他图片";
            break;
        default:
            break;
    }
    
    if(!hover)
    {
        hover = WEAK_OBJECT(BaserHoverView, initWithTitle:@"抱歉" message:titleName);
        
        hover.frame = _tableView.frame;
        
        hover.tag = 1111;
        
        [self.view addSubview:hover];
        
        [self.view sendSubviewToBack:hover];
        
    }
    else
    {
        hover.lblTitle.text = @"抱歉";
        hover.lblMessage.text = titleName;
    }
}

#pragma mark -
- (PSTCollectionViewCell *)collectionView:(PSTCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    PSTCommonTableViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PSTCommonTableViewCell" forIndexPath:indexPath];
    [cell.img requestIcon:[[_curArr[indexPath.row] wrapper] getString:@"ResUrl"]];
    cell.label.text = [[_curArr[indexPath.row] wrapper] getString:@"ResTitle"];

    return cell;
}

- (CGSize)collectionView:(PSTCollectionView *)collectionView layout:(PSTCollectionViewFlowLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return ZiZhiCellSize2;
}


- (NSInteger)collectionView:(PSTCollectionView *)view numberOfItemsInSection:(NSInteger)section
{
    return ((NSArray *)_curArr).count;
}

#pragma mark - 选中样式

- (void)collectionView:(PSTCollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    PreviewViewController *p = WEAK_OBJECT(PreviewViewController, init);
    
    int curIndex = 0;
    
    for (int i = 0; i < _dic.count; i ++)
    {
        DictionaryWrapper * wrapp = [_dic[i] wrapper];
        
        if([[wrapp getString:@"Id"] isEqualToString:[[_curArr[indexPath.row] wrapper] getString:@"Id"]])
        {
            curIndex = i;
        }
    }
    
    NSMutableArray * arr = WEAK_OBJECT(NSMutableArray, init);
    
    for(NSDictionary * dic in _dic)
    {
        NSMutableDictionary * rDic = WEAK_OBJECT(NSMutableDictionary, init);
        
        int type = [dic.wrapper getInt:@"BusinessResType"];

        NSString * typeName = @"";
        
        if(type == 1101 || type == 1102 || type == 1103)
        {
            typeName = @"商家资质";
        }
        else if (type == 1106)
        {
            typeName = @"营业场所";
        }
        else if (type == 4001)
        {
            typeName = @"兑换承诺书";
        }
        
        [rDic setObject:[dic.wrapper getString:@"ResUrl"] forKey:@"PictureUrl"];
//        [rDic setObject:typeName forKey:@"TypeName"];  //加类型
        
        [arr addObject:rDic];
    }
    
    p.dataArray = arr;
        
    p.currentPage = curIndex;
    
//    p.isShowLogo = YES; //加水印
    
    __block PreviewViewController *weakSelf = p;
    [self presentViewController:p animated:NO completion:^(void)
     {
         weakSelf.pageControl.hidden = NO;
     }];

}

@end
