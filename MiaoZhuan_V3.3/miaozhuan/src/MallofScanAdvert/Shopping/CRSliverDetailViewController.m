//
//  CRSliverDetailViewController.m
//  miaozhuan
//
//  Created by abyss on 14/12/29.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "CRSliverDetailViewController.h"
#import "ModelSliverDetail.h"
#import "NetImageView.h"
#import "RRLineView.h"
#import "PlaceTableViewCell.h"
#import "CRScrollController.h"
#import "SelectionButton.h"
#import "Redbutton.h"
#import "ShippingConsultViewController.h"
#import "MerchantDetailViewController.h"
#import "ConfirmOrderViewController.h"
#import "MallHistory.h"
#import "PreviewViewController.h"
#import "RRNavBarDrawer.h"
#import "KxMenu.h"
#import "Share_Method.h"
#import "ControlViewController.h"
#import "MallScanAdvertMain.h"
#import "BrowseRecordViewController.h"
#import "CRHolderView.h"
#import "SystemUtil.h"
#import "RealNameAuthenticationViewController.h"

@interface CRSliverDetailViewController ()<UITableViewDataSource,UITableViewDelegate,KxMenuDelegate>
{
    NSArray* _picArray;
    
    BOOL _noTable;
    NSInteger _numOfTable;
    NSInteger _maxNum;
    NSInteger _curNum;
    long      _CustomerSilverBalance;
    long      _price;
    NSInteger _exchangeType;
    NSInteger _enterId;
    
    NSArray* _placeArray;
    
    NSInteger _youjiLeixing;
    
    NSMutableArray*     _extraCell;
    
    CRScrollController* _scrollCon;
    
    NSString *_convertPicUrl;
    
    BOOL _ifReloadData;
}
@property (retain, nonatomic) IBOutlet UILabel *shoucangL;
@property (retain, nonatomic) NSArray *picArray;
@property (retain, nonatomic) IBOutlet UITextField *itemCount;
@property (retain, nonatomic) IBOutlet RRLineView *line;
@property (retain, nonatomic) ModelSliverDetail *dataModel;
@property (retain, nonatomic) IBOutlet UIView *Vxian;
@property (retain, nonatomic) IBOutlet UIView *Vyou;
@property (retain, nonatomic) IBOutlet UILabel *Vtext;
@property (retain, nonatomic) IBOutlet UILabel *mtitle;
@property (retain, nonatomic) IBOutlet UILabel *yinyuan;
@property (retain, nonatomic) IBOutlet UILabel *dingjia;
@property (assign, nonatomic) NSInteger exchangeType;
@property (retain, nonatomic) IBOutlet UILabel *canExchange;
@property (retain, nonatomic) IBOutlet UILabel *willExchange;
@property (retain, nonatomic) IBOutlet UILabel *alreadyExchange;
@property (retain, nonatomic) IBOutlet UILabel *provider;
@property (retain, nonatomic) IBOutlet NetImageView *img;
@property (retain, nonatomic) IBOutlet UILabel *provideName;
@property (retain, nonatomic) IBOutlet UIImageView *pIsVip;
@property (retain, nonatomic) IBOutlet UIImageView *pIsSyin;
@property (retain, nonatomic) IBOutlet UIImageView *pIsJin;
@property (retain, nonatomic) IBOutlet UIImageView *pIsZhi;

@property (retain, nonatomic) IBOutlet HightedButton *shangjiaBt;
@property (retain, nonatomic) IBOutlet HightedButton *zixunBt;
@property (retain, nonatomic) IBOutlet HightedButton *storeBt;
@property (retain, nonatomic) IBOutlet UIView *itemInfo;
@property (retain, nonatomic) IBOutlet UILabel *info;
@property (retain, nonatomic) IBOutlet RRLineView *infoLine;
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) IBOutlet UIView *tableHeader;

@property (retain, nonatomic) UIView *cover;
@property (retain, nonatomic) IBOutlet UIView *popView;
@property (retain, nonatomic) IBOutlet SelectionButton *pYou;
@property (retain, nonatomic) IBOutlet SelectionButton *pXian;
@property (retain, nonatomic) IBOutlet UIButton *pde;
@property (retain, nonatomic) IBOutlet UIButton *pad;
@property (retain, nonatomic) IBOutlet UITextField *pl;
@property (retain, nonatomic) IBOutlet UILabel *pn1;
@property (retain, nonatomic) IBOutlet UILabel *pn2;
@property (retain, nonatomic) IBOutlet Redbutton *psure;

@property (retain, nonatomic) IBOutlet UIView *bottomView;
@property (retain, nonatomic) IBOutlet UIButton *b1;
@property (retain, nonatomic) IBOutlet UIButton *b2;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;

@property (retain, nonatomic) IBOutlet UIView *littleRedLine;

@property (retain, nonatomic) IBOutlet NetImageView *convertPic;

@property (retain, nonatomic) IBOutlet UILabel *title1;
@property (retain, nonatomic) IBOutlet UILabel *title2;
@property (retain, nonatomic) IBOutlet UIView *UILineVIew1;
@property (retain, nonatomic) IBOutlet UIView *UILineView2;
@property (retain, nonatomic) IBOutlet UIView *UILineView3;

@property (strong, nonatomic) NSArray *convertPromiseArray;
@property (retain, nonatomic) IBOutlet Redbutton *lijiduihuanBtn;

@property (retain, nonatomic) IBOutlet UIView *viewOne;
@property (retain, nonatomic) IBOutlet UIView *viewTwo;
@property (retain, nonatomic) IBOutlet UIView *viewThree;

@property (nonatomic, retain) IBOutlet UIButton *btn_ShowImage;



@end

@implementation CRSliverDetailViewController
@synthesize littleRedLine = _littleRedLine;
@synthesize convertPic = _convertPic;
@synthesize title1 = _title1;
@synthesize title2 = _title2;
@synthesize UILineVIew1 = _UILineVIew1;
@synthesize UILineView2 = _UILineView2;
@synthesize UILineView3 = _UILineView3;
@synthesize convertPromiseArray = _convertPromiseArray;

- (void)viewWillAppear:(BOOL)animated {
    
    if (_ifReloadData) {
    
        ADAPI_adv3_CustomerGetProductDetail([self genDelegatorID:@selector(handle:)], _productId, _advertId);
    }
}

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad{
    [super viewDidLoad];

    if (_comeformCounsel == 1)
    {
        _shangjiaBt.enabled = NO;
        _zixunBt.enabled = NO;
        _storeBt.enabled = NO;
        _lijiduihuanBtn.userInteractionEnabled = NO;
        _lijiduihuanBtn.backgroundColor = AppColorLightGray204;
        _b1.enabled = NO;
        _b2.enabled = NO;
    }
    else
    {
        [self setupMoveFowardButtonWithImage:@"more" In:@"morehover"];
        _bottomView.bottom = SCREENHEIGHT;
    }
    
    InitNav(@"");
    
    
    _scrollCon = [CRScrollController controllerFromView:_scrollView];
    _scrollCon.positon = CRSC_PCPMiddle;
    _scrollCon.key     = @"PictureUrl";
    
    __block CRSliverDetailViewController *weakself = self;
    
    _scrollCon.tapBlock = ^(NSInteger pageIndex)
    {
        //预览
        PreviewViewController *preview = WEAK_OBJECT(PreviewViewController, init);
        preview.dataArray = weakself.picArray;
        preview.currentPage = pageIndex;
        [weakself presentViewController:preview animated:NO completion:^{}];
    };
    
    [self layoutWithoutData];
    [_UILineVIew1 setFrame:CGRectMake(0, 39, 320, 1)];
    [_UILineView3 setFrame:CGRectMake(0, 0, 320, 1)];
    _ifReloadData = YES;
    
    _btn_ShowImage.hidden = YES;
}


- (IBAction)productStatement:(id)sender {
    
    _btn_ShowImage.hidden = YES;
    
    for (NetImageView * obj in [_itemInfo subviews]) {
        
        if([obj isKindOfClass:[NetImageView class]])
            if(obj.tag >= 1000)
                obj.hidden = YES;
    }
    
    for (UIButton * obj in [_itemInfo subviews]) {
        
        if([obj isKindOfClass:[UIButton class]])
            if(obj.tag >= 1000)
                obj.hidden = YES;
    }

    [UIView animateWithDuration:0.3 animations:^{
       
        [_littleRedLine setOrigin:CGPointMake(35, 37)];
    }];
    
    _convertPic.hidden = YES;
    _info.hidden = NO;
    
    [_title1 setTextColor:RGBCOLOR(240, 5, 0)];
    [_title2 setTextColor:RGBCOLOR(34, 34, 34)];
    
    [_title1 setFont:[UIFont systemFontOfSize:17]];
    [_title2 setFont:[UIFont systemFontOfSize:14]];
    
    _itemInfo.height = _info.height + 80;
    if(_convertPromiseArray && _convertPromiseArray != nil)
        ((UIScrollView  *)self.view).contentSize = (CGSize){SCREENWIDTH,_itemInfo.height + 765 + _tableView.height +30};
    else
        ((UIScrollView  *)self.view).contentSize = (CGSize){SCREENWIDTH,_itemInfo.height + 765 + _tableView.height +50};
    
    [self.view bringSubviewToFront:_cover];
    [self.view bringSubviewToFront:_popView];
    
    [_UILineView2 setFrame:CGRectMake(0, _itemInfo.height - 0.5, 320, 1)];
    
//    _tableView.top = _itemInfo.height + 11 + 60 + 606 ;
    _tableView.top = _itemInfo.frame.origin.y + _itemInfo.frame.size.height + 10;
    
    if (_noTable)
    {
        _tableView.hidden = YES;
        ((UIScrollView  *)self.view).contentSize = (CGSize){SCREENWIDTH,751 + _itemInfo.height +10};
        return;
    }
    
    [_tableView reloadData];
}

//兑换承诺书
- (IBAction)convertPic:(id)sender {
    
    _btn_ShowImage.hidden = NO;
    
    int countOfPic = [_convertPromiseArray count] - 1;
    
    if (countOfPic < 0) {
        return;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [_littleRedLine setOrigin:CGPointMake(195, 37)];
    }];
    
    _convertPic.hidden = NO;
    _info.hidden = YES;
    
    [_title1 setTextColor:RGBCOLOR(34, 34, 34)];
    [_title2 setTextColor:RGBCOLOR(240, 5, 0)];
    
    [_title1 setFont:[UIFont systemFontOfSize:14]];
    [_title2 setFont:[UIFont systemFontOfSize:17]];

    
//    if(_convertPromiseArray && _convertPromiseArray != nil)
    
//        countOfPic = [_convertPromiseArray count] - 1;
    
//    int countOfPic = [_convertPromiseArray count] - 1;
    float y = _convertPic.origin.y;
    
    _itemInfo.height = countOfPic*(_convertPic.height + 20) + 356;
    
    if(_convertPromiseArray && _convertPromiseArray != nil)
    for (int i = 0; i < [_convertPromiseArray count] - 1; i++) {
        
        NetImageView *image = WEAK_OBJECT(NetImageView, init);
        DictionaryWrapper *wrapper = [_convertPromiseArray[i+1] wrapper];
        [image requestPicture:[wrapper getString:@"PictureUrl"]];
        [_itemInfo addSubview:image];
        image.tag = 1000 + i;
        [image setFrame:CGRectMake(_convertPic.origin.x, y + _convertPic.size.height + 20, _convertPic.size.width, _convertPic.size.height)];

        y = image.origin.y;
        
        UIButton *btn = WEAK_OBJECT(UIButton, initWithFrame:image.frame);
        [btn addTarget:self action:@selector(previewMerchantConvertPic:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 1000 + i;
        [_itemInfo addSubview:btn];
    }
    if(_convertPromiseArray && _convertPromiseArray != nil)
        ((UIScrollView  *)self.view).contentSize = (CGSize){SCREENWIDTH,_itemInfo.height + 765 + _tableView.height +30};
    else
        ((UIScrollView  *)self.view).contentSize = (CGSize){SCREENWIDTH,_itemInfo.height + 765 + _tableView.height + 50};
    
    [self.view bringSubviewToFront:_cover];
    [self.view bringSubviewToFront:_popView];
    
    [_UILineView2 setFrame:CGRectMake(0, _itemInfo.height - 0.5, 320, 1)];
    
//    _tableView.top = _itemInfo.height + 11 + 60 + 606;
    _tableView.top = _itemInfo.frame.origin.y + _itemInfo.frame.size.height + 10;
    
    if (_noTable)
    {
        _tableView.hidden = YES;
        ((UIScrollView  *)self.view).contentSize = (CGSize){SCREENWIDTH,751 + _itemInfo.height + 10};
        return;
    }
    
    [_tableView reloadData];
}

//点击 --- 关闭
- (void)onMoveFoward:(UIButton *)sender
{
    if(_isPreview)
    {
        return;
    }
    // show menu
    if(![KxMenu isOpen])
    {
        NSArray *menuItems =
        @[
          
          [KxMenuItem menuItem:@"秒赚首页"
                         image:[UIImage imageNamed:@"preview_menu_0_0"]
                     highlight:[UIImage imageNamed:@"preview_menu_0_1"]
                        target:self
                        action:@selector(pushMenuItem:)],
          
          [KxMenuItem menuItem:@"商城首页"
                         image:[UIImage imageNamed:@"preview_menu_1_0"]
                     highlight:[UIImage imageNamed:@"preview_menu_1_1"]
                        target:self
                        action:@selector(pushMenuItem:)],
          
          [KxMenuItem menuItem:@"浏览记录"
                         image:[UIImage imageNamed:@"preview_menu_2_0"]
                     highlight:[UIImage imageNamed:@"preview_menu_2_1"]
                        target:self
                        action:@selector(pushMenuItem:)],
          
          [KxMenuItem menuItem:@"分享给朋友"
                         image:[UIImage imageNamed:@"preview_menu_3_0"]
                     highlight:[UIImage imageNamed:@"preview_menu_3_1"]
                        target:self
                        action:@selector(pushMenuItem:)],
          ];
        
        
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
//    NSLog(@"shit :%d", tag);
    
    //秒赚首页
    if(tag == 0)
    {
        [[DotCUIManager instance] startWithClass:[ControlViewController class] animated:YES];
    }
    
    //商城首页
    else if(tag == 1)
    {
        if (!_comeFromOtherPlace)
        {
             [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(MallScanAdvertMain, init) animated:YES];
            _ifReloadData = YES;
        }
        else
        {
             [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
    //浏览记录
    else if(tag == 2)
    {
        [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(BrowseRecordViewController, init) animated:YES];
        _ifReloadData = YES;
    }
    
    //分享给朋友
    else if(tag == 3)
    {
        Share_Method *share = [Share_Method shareInstance];
        
        WDictionaryWrapper *dic = WEAK_OBJECT(WDictionaryWrapper, init);
        
        [dic set:@"product_name" string:_mtitle.text];
        
        NSString *image = @"";
        if(_picArray && [_picArray count] > 0)
        {
            NSDictionary *dic = [_picArray objectAtIndex:0];
            
            image = [dic.wrapper getString:@"PictureUrl"];
        }
        
        [share getShareDataWithShareData:@{@"Key":@"18ea86162430fe32164c92e93e60843a", @"product_id":[NSString stringWithFormat:@"%d",(int)_productId], @"advert_id":[NSString stringWithFormat:@"%d",(int)_advertId]}];
    }
}



- (void)viewDidLayoutSubviews
{
    _bottomView.bottom = SCREENHEIGHT + ((UIScrollView *)self.view).contentOffset.y - 64;
    
    if (_popView.hidden == NO)
    {
        if (_curNum == 1) _pde.enabled = NO;
        else _pde.enabled = YES;
        if (_curNum == _maxNum && _maxNum != 0) _pad.enabled = NO;
        else _pad.enabled = YES;
        _pl.text = [NSString stringWithFormat:@"%d",(int)_curNum];
        
        _pn1.text = [NSString stringWithFormat:@"%ld", _price * _curNum];
        _pn2.text = [NSString stringWithFormat:@"%ld", _CustomerSilverBalance];;
    }
}

- (void)handle:(DelegatorArguments *)arg
{
    [arg logError];
    if (arg.ret.operationSucceed)
    {
        DictionaryWrapper *wrapper = arg.ret.data;
        self.convertPromiseArray = [wrapper getArray:@"ExchangePromisePictures"];
        
        DictionaryWrapper* merchantPromiseInfo = [_convertPromiseArray[0] wrapper];
        
        [_convertPic requestPicture:[merchantPromiseInfo getString:@"PictureUrl"]];
        
        _convertPicUrl = [[merchantPromiseInfo getString:@"PictureUrl"] copy];
        
        _dataModel = [[ModelSliverDetail alloc] initWith:wrapper];
        
        [MallHistory_Manager newRecord:wrapper isYin:YES];
        [self layout:_dataModel inPageChengnuoshu:NO];
        
        if(_isPreview)
        {
            [self fixView];
        }
    }
    else
    {
        [self showHolderWithImg:nil text2:@"找不到该商品"];
//        [HUDUtil showErrorWithStatus:arg.ret.operationMessage];
    }
}


//预览兑换承诺书
- (IBAction)previewMerchantConvertPic:(id)sender {
    
    NSMutableArray *tempArray = WEAK_OBJECT(NSMutableArray, init);
    
    if([_convertPromiseArray count] <= 0){
        return;
    }
    
    
    for (int i = 0; i < [_convertPromiseArray count]; i++) {
        
        DictionaryWrapper *wrapper = [_convertPromiseArray[i] wrapper];
        
        _convertPicUrl = [[wrapper getString:@"PictureUrl"] copy];
        
        if (!_convertPicUrl.length || [_convertPicUrl isKindOfClass:[NSNull class]]) {
            
            [HUDUtil showErrorWithStatus:@"获取图片URL失败"];
            return;
        }
        
        NSDictionary *url1 = [[NSDictionary alloc]initWithObjectsAndKeys:_convertPicUrl,@"PictureUrl",nil];
        [tempArray addObject:url1];
    }
    
    PreviewViewController *temp = WEAK_OBJECT(PreviewViewController, init);
    temp.dataArray = [NSArray arrayWithArray:tempArray];
    [self presentViewController:temp animated:YES completion:^{
        _ifReloadData = NO;
    }];
    
}

- (void) fixView
{
    _bottomView.hidden = YES;
    
    _zixunBt.enabled = NO;
    
    _storeBt.enabled = NO;
    
    _shangjiaBt.hidden = YES;
}

- (void)layout:(ModelSliverDetail *)data inPageChengnuoshu:(BOOL)flag
{
    InitNav(data.sdName);
    _mtitle.text = data.sdName;
    _yinyuan.text = [NSString stringWithFormat:@"%ld",data.sdUnitIntegral];
    _dingjia.text = [NSString stringWithFormat:@"￥%.2f",data.sdUnitPrice];
    
    _CustomerSilverBalance  = data.sdCustomerSilverBalance;
    _price                  = data.sdUnitIntegral;
    _enterId                = data.sdEnterpriseId;
    
        
    [_littleRedLine setOrigin:CGPointMake(35, 37)];
    
    _convertPic.hidden = YES;
    _info.hidden = NO;
    
    [_title1 setTextColor:RGBCOLOR(240, 5, 0)];
    [_title2 setTextColor:RGBCOLOR(34, 34, 34)];
    
    [_title1 setFont:[UIFont systemFontOfSize:17]];
    [_title2 setFont:[UIFont systemFontOfSize:14]];
    
    {
        _exchangeType = 2;
        _pYou.selected = YES;
        _pXian.selected = NO;
//        _youjiLeixing = data.sdExchangeType;
        if (data.sdExchangeType == 1)
        {
            _exchangeType = 1;
            _pYou.enabled = NO;
            _Vyou.hidden = YES;
            _pYou.selected = NO;
            _pXian.selected = YES;
            _viewOne.height = 141;
        }
        else if (data.sdExchangeType == 2)
        {
            _pXian.enabled = NO;
            _Vxian.hidden = YES;
            _noTable      = YES;
            _exchangeType = 2;
            _Vyou.top = _Vxian.top;
            
            _viewOne.height = 171;
            
//            _youjiLeixing = 2;
        }
    }
    
    _viewTwo.top = _viewOne.top + _viewOne.frame.size.height;
    _viewThree.top = _viewTwo.top + _viewTwo.frame.size.height;
    
    _shangjiaBt.hidden = YES;
    if (data.sdExchangeableCount == 0) _shangjiaBt.hidden = NO;
    _canExchange.text = [NSString stringWithFormat:@"%d",data.sdExchangeableCount];
    _willExchange.text = [NSString stringWithFormat:@"%d",data.sdRemainExchangeCount];
    _alreadyExchange.text = [NSString stringWithFormat:@"%d",data.sdExchangedCount];
    
    DictionaryWrapper *providerInfo = data.sdEnterpriseInfo.wrapper;
    {
        _provider.text = [NSString stringWithFormat:@"本商品提供商 %@",[providerInfo getString:@"Name"]?[providerInfo getString:@"Name"]:@""];
        _provideName.text = [providerInfo getString:@"Name"];
        [_img requestPic:[providerInfo getString:@"LogoUrl"] placeHolder:YES];
        
        _pIsVip.image     = [UIImage imageNamed:![providerInfo getBool:@"IsVip"]?@"fatopvip.png":@"fatopviphover.png"];
        _pIsSyin.image   = [UIImage imageNamed:![providerInfo getBool:@"IsSilver"]?@"fatopyin.png":@"fatopyinhover.png"];
        _pIsJin.image    = [UIImage imageNamed:![providerInfo getBool:@"IsGold"]?@"fatopjin.png":@"fatopjinhover.png"];
        _pIsZhi.image    = [UIImage imageNamed:![providerInfo getBool:@"IsDirect"]?@"fatopzhi.png":@"fatopzhihover.png"];
    }
    
    CGFloat startTop = _viewThree.top + _viewThree.frame.size.height ;
    [self.view addSubview:_itemInfo];
    
    if (!flag)
    {
        _itemInfo.top = startTop +10;
        
        if (data.sdDescribe && data.sdDescribe.length > 0)
        {
            _info.text = data.sdDescribe;
        }
        else _info.text = @"暂无";
        
        NSDictionary *attribute = @{NSFontAttributeName: _info.font};
        
        CGSize retSize = CGSizeZero;
        
        if([UICommon getSystemVersion] >= 7.0)
        {
            retSize = [_info.text boundingRectWithSize:CGSizeMake(_info.width, MAXFLOAT)
                       
                                               options:\
                       
                       NSStringDrawingTruncatesLastVisibleLine |
                       
                       NSStringDrawingUsesLineFragmentOrigin |
                       
                       NSStringDrawingUsesFontLeading
                       
                                            attributes:attribute
                       
                                               context:nil].size;
        }
        else
            retSize = [_info.text sizeWithFont:_info.font constrainedToSize:CGSizeMake(_info.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        
        _info.height = retSize.height;
        
        _itemInfo.height = _info.height + 70;
        
        _infoLine.bottom = _itemInfo.height;
        
        startTop += _itemInfo.height + 11;
    }
    else
    {
        //兑换承诺书
        float ChengnuoshuHeight = 40.f;
        
        _itemInfo.top = startTop +10;
        
        _info.height = ChengnuoshuHeight;
        
        _itemInfo.height = _info.height + 70;
        
        UIView *view1 = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(0 , _itemInfo.height - 0.5, 320, 1));
        view1.backgroundColor = AppColor(204);
        
        [_itemInfo addSubview:view1];
        
        _infoLine.bottom = _itemInfo.height;
        
        startTop += _itemInfo.height + 11;
    }
    
    [self.view bringSubviewToFront:_cover];
    [self.view bringSubviewToFront:_popView];
    
    [_UILineView2 setFrame:CGRectMake(0, _itemInfo.height - 0.5, 320, 1)];
    
    _tableView.top = startTop +10;
    _tableView.scrollEnabled = NO;
    
    {
        _picArray = data.sdPictures;
        [_picArray retain];
        _scrollCon.picArray = data.sdPictures;
    }
    
    {
        //IsCollect 	bool 	否 	是否收藏
        
        if (data.sdIsCollect)
        {
            _b1.hidden = YES;
            _b2.hidden = NO;
            
            _shoucangL.text = @"已收藏";
            _shoucangL.textColor = AppColorRed;
        }
        else
        {
            _shoucangL.text = @"收藏";
            _shoucangL.textColor = AppColor(85);
            
            _b2.hidden = YES;
            _b1.hidden = NO;
        }
        
        [_b1 addTarget:self action:@selector(collect:) forControlEvents:UIControlEventTouchUpInside];
        [_b2 addTarget:self action:@selector(collect:) forControlEvents:UIControlEventTouchUpInside];
    
        _maxNum = MIN(data.sdExchangeableCount, MIN(data.sdPerPersonNumber, data.sdPerPersonPerDayNumber));
        _itemCount.text = @"1";
        _itemCount.userInteractionEnabled = NO;
        _Vtext.text = [NSString stringWithFormat:@"每名用户最多兑换%d个,每天可兑换%d个",data.sdPerPersonNumber,data.sdPerPersonPerDayNumber];
        
        if ([_Vtext.text sizeWithFont:_Vtext.font].width > 250)
        {
            _Vtext.height *= 2;
        }
        
    }
    
    [self.view addSubview:_bottomView];
    
    if (_noTable)
    {
        _tableView.hidden = YES;
        ((UIScrollView  *)self.view).contentSize = (CGSize){SCREENWIDTH,startTop + 90};
        return;
    }
    
    _placeArray = data.sdProductExchangeAddress;
    [_placeArray retain];
    
    _tableView.backgroundColor = AppColorBackground;
    _tableView.height          = 90;
    if (_placeArray && _placeArray.count > 0)
    {
        {
            UIView *view = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(0 , 0, 320, 0.5));
            view.backgroundColor = AppColor(204);
            
            [_tableHeader addSubview:view];
        }
        [_tableView setTableHeaderView:_tableHeader];
        
        _tableView.height = _placeArray.count*210 + _tableHeader.height - 20 + 0.5;
        _numOfTable = _placeArray.count;
        startTop += _tableView.height;
        
        
        _tableView.dataSource = self;
        _tableView.delegate   = self;
    }
    startTop += 65;
    
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    ((UIScrollView  *)self.view).contentSize = (CGSize){SCREENWIDTH,startTop +10};
    [_tableView reloadData];
}

- (void)collect:(UIButton *)sender
{
    if (sender == _b1)
    {
        ADAPI_FavoriteCommodity_new([self genDelegatorID:@selector(collectReponse:)],(int)_productId,(int)_advertId,1);
    }
    else
    {
        ADAPI_UnFavoriteCommodity_new([self genDelegatorID:@selector(collectReponse:)],(int)_productId,(int)_advertId,1);
    }
}

- (void)collectReponse:(DelegatorArguments *)arg
{
    if (arg.ret.operationSucceed)
    {
        _b1.hidden = !_b1.hidden;
        _b2.hidden = !_b2.hidden;
        
        if (_b1.hidden)
        {
            _shoucangL.text = @"已收藏";
            _shoucangL.textColor = AppColorRed;
        }
        else
        {
            _shoucangL.text = @"收藏";
            _shoucangL.textColor = AppColor(85);
        }
        
        [HUDUtil showSuccessWithStatus:arg.ret.operationMessage];
    }
    else
    {
        [HUDUtil showErrorWithStatus:arg.ret.operationMessage];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _numOfTable;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PlaceTableViewCell *cell = (PlaceTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    CGFloat f = cell.add;
    
    if (f > 1)
    {
        if (!_extraCell)
        {
            _extraCell = [NSMutableArray new];
        }
        
        if (![_extraCell containsObject:indexPath])
        {
            [_extraCell addObject:indexPath];
            tableView.height += f;
            
            ((UIScrollView  *)self.view).contentSize = (CGSize){SCREENWIDTH,((UIScrollView  *)self.view).contentSize.height + f +10};
        }
    }
    
    if (_numOfTable == indexPath.row + 1)
    {
        return 190 + f;
    }
    else
    {
        return 210 + f;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PlaceTableViewCell";
    PlaceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"PlaceTableViewCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.layer.masksToBounds = YES;
    }
    
    DictionaryWrapper *wrapper = [_placeArray[indexPath.row] wrapper];
    
    
    cell.t3.text = [wrapper getString:@"ExchangeTime"];
    cell.place = [wrapper getString:@"DetailedAddress"];
    cell.t2.text = [wrapper getString:@"ContactNumber"];
    cell.phone   = [wrapper getString:@"ContactNumber"];
    
    cell.l1 = [wrapper getDouble:@"Lat"];
    cell.l2 = [wrapper getDouble:@"Lng"];
    cell.lt = [wrapper getInt:@"LocationType"];
    
    cell.isDisable = _isPreview;
    
    if (_comeformCounsel == 1) {
        cell.phoneBtns.enabled = NO;
    }
    return cell;
}

- (void)layoutWithoutData
{
    [_shangjiaBt setBorderWithColor:AppColor(204)];
    [_zixunBt    setBorderWithColor:AppColor(204)];
    [_storeBt    setBorderWithColor:AppColor(204)];
    [_img        setBorderWithColor:AppColor(197)];
    
    [_img        setRoundCorner:11.f];
    [_shangjiaBt setRoundCorner];
    [_zixunBt    setRoundCorner];
    [_storeBt    setRoundCorner];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    CRDEBUG_DEALLOC();
    
    [_extraCell release];
    [_placeArray release];
    [_picArray release];
    
    [_shoucangL release];
    [_itemCount release];
    [_line release];
    [_dataModel release];
    [_Vyou release];
    [_Vxian release];
    [_Vtext release];
    [_mtitle release];
    [_yinyuan release];
    [_dingjia release];
    [_canExchange release];
    [_willExchange release];
    [_alreadyExchange release];
    [_provider release];
    [_img release];
    [_provideName release];
    [_pIsVip release];
    [_pIsSyin release];
    [_pIsJin release];
    [_pIsZhi release];

    [_shangjiaBt release];
    [_zixunBt release];
    [_storeBt release];
    [_itemInfo release];
    [_info release];
    [_infoLine release];
    [_tableView release];
    [_tableHeader release];

//    [_cover release];             //weak
    [_popView release];
    
    [_pYou release];
    [_pXian release];
    [_pde release];
    [_pad release];
    [_pl release];
    [_pn1 release];
    [_pn2 release];
    [_psure release];
    [_bottomView release];
    [_b1 release];
    [_b2 release];
    
    [_scrollCon remove];
    [_scrollView release];
    
    [_littleRedLine release];
    [_convertPic release];
    [_title1 release];
    [_title2 release];
    [_UILineVIew1 release];
    [_UILineView2 release];
    [_UILineView3 release];
    [_lijiduihuanBtn release];
    [_viewOne release];
    [_viewTwo release];
    [_viewThree release];
    [_btn_ShowImage release];
    [super dealloc];
}

- (void)viewDidUnload
{
    [self setMtitle:nil];
    [self setYinyuan:nil];
    [self setDingjia:nil];
    [self setCanExchange:nil];
    [self setWillExchange:nil];
    [self setAlreadyExchange:nil];
    [self setShangjiaBt:nil];
    [self setProvider:nil];
    [self setImg:nil];
    [self setProvideName:nil];
    [self setPIsVip:nil];
    [self setPIsSyin:nil];
    [self setPIsJin:nil];
    [self setPIsZhi:nil];
    [self setZixunBt:nil];
    [self setStoreBt:nil];
    [self setTableView:nil];
    [self setItemInfo:nil];
    [self setInfo:nil];
    [self setScrollView:nil];
    [self setBtn_ShowImage:nil];
    [super viewDidUnload];
}

- (IBAction)bottomDuihuan:(id)sender
{
    if ([_canExchange.text isEqualToString:@"0"])
    {
        [HUDUtil showErrorWithStatus:@"抱歉请先等待该商品上架"];
        return;
    }
    
    __block CRSliverDetailViewController *weakself = self;
    if (!_cover)
    {
        _cover = WEAK_OBJECT(UIView, init);
        _cover.backgroundColor = AppColor(0);
        _cover.alpha  = 0.5;
        [_cover setTapActionWithBlock:^{
            weakself.cover.hidden = YES;
            weakself.popView.hidden = YES;
            ((UIScrollView *)weakself.view).scrollEnabled = YES;
        }];
        [self.view addSubview:_cover];
        [self.view addSubview:_popView];
        
        {
            UIView* v = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(66, 150, 59, 0.5));
            v.backgroundColor = AppColor(204);
            [_popView addSubview:v];
            
            UIView* v1 = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(66, 150 + 35 - 0.5, 59, 0.5));
            v1.backgroundColor = AppColor(204);
            [_popView addSubview:v1];
        }
        [_popView setRoundCorner];
    }
    
    _cover.frame = CGRectMake(0, ((UIScrollView *)self.view).contentOffset.y - 64, SCREENWIDTH, SCREENHEIGHT);
    _cover.hidden = NO;
    
    _popView.hidden = NO;
    _popView.frame  = CGRectMake(15, ((UIScrollView *)self.view).contentOffset.y - 64 + (SCREENHEIGHT - _popView.height)/2, _popView.width, _popView.height);
    _curNum = 1;
    ((UIScrollView *)self.view).scrollEnabled = NO;
}

- (IBAction)pEvent:(id)sender
{
    if (sender == _pYou)
    {
        _exchangeType = 2;
        _pYou.selected = YES;
        _pXian.selected = NO;
    }
    else if (sender == _pXian)
    {
        _exchangeType = 1;
        _pXian.selected = YES;
        _pYou.selected = NO;
    }
    else if (sender == _pde)
    {
        if (_curNum > 1) _curNum --;
    }
    else if (sender == _pad)
    {
        if (_curNum < _maxNum) _curNum ++;
    }
    else if (sender == _psure)
    {
        [APP_MTA MTA_touch_From:MTAEVENT_mall_exchange];
        {
            _cover.hidden = YES;
            _popView.hidden = YES;
            ((UIScrollView *)self.view).scrollEnabled = YES;
        }
        NSString* ret = nil;
        if (_exchangeType == 1) ret = @"1";
        else if (_exchangeType == 2) ret = @"0";
        NSDictionary *dic = @{@"OrderType":@"8",
                              @"ItemCount":@(_curNum),
                              @"OrderSerialNo":@"",
                              @"AdvertId":@(_advertId),
                              @"ProductId":@(_productId),
                              @"ExchangeType":ret,
                              };
        ADAPI_Payment_GoCommonOrderShow([self genDelegatorID:@selector(pay:)], dic);
    }
    
    [self viewDidLayoutSubviews];
}

- (void)pay:(DelegatorArguments *)arg
{
    if (arg.ret.operationSucceed)
    {
        NSString* ret = nil;
        if (_exchangeType == 1) ret = @"1";
        else if (_exchangeType == 2) ret = @"0";
        NSDictionary *dic = @{@"OrderType":@"8",@"ItemCount":@(_curNum),@"OrderSerialNo":@"",@"AdvertId":@(_advertId),@"ProductId":@(_productId),@"ExchangeType":ret};
        PUSH_VIEWCONTROLLER(ConfirmOrderViewController);
        model.type = 1;
        model.payDic = dic;
        model.orderInfoDic = arg.ret.data;
        model.goodsInfo = @[@{@"name": _mtitle.text,@"num":[NSString stringWithFormat:@"%ld",(long)_curNum]}];
        _ifReloadData = YES;
    }
    else
    {
        [HUDUtil showErrorWithStatus:arg.ret.operationMessage];
    }
}

- (IBAction)event:(id)sender
{
    if (sender == _shangjiaBt)
    {
        ADAPI_adv3_RecordProductReminder([self genDelegatorID:@selector(shangjia:)], _productId, _advertId);
    }
    else if (sender == _zixunBt)
    {
        //3.3需求
        DictionaryWrapper * dic =[APP_DELEGATE.runtimeConfig getDictionary:RUNTIME_USER_LOGIN_INFO].wrapper;
        
        //判断是否商家
        if ([dic getInt:@"EnterpriseStatus"] == 4)//已激活商家
        {
            PUSH_VIEWCONTROLLER(ShippingConsultViewController);
            model.type = [NSString stringWithFormat:@"%d",4];
            model.proterId = [NSString stringWithFormat:@"%d",(int)_productId];
            model.enterName = _provideName.text;
            _ifReloadData = YES;
        }
        else
        {
            //实名认证非认证成功
            if ([dic getInt:@"IdentityStatus"] == 0 || [dic getInt:@"IdentityStatus"] == 2)
            {
                __block typeof(self) weakself = self;
                [AlertUtil showAlert:@"实名认证" message:@"通过实名认证才能咨询商家" buttons:@[@"确定",@{
                                                                                   @"title":@"去认证",
                                                                                   @"delegator":ALERT_VIEW_DELEGATOR_BLOCK
                                                                                   ({
                    [weakself.navigationController pushViewController:WEAK_OBJECT(RealNameAuthenticationViewController, init) animated:YES];
                })
                                                                                   }]];
            }
            else if ([dic getInt:@"IdentityStatus"] == 3)
            {
                [HUDUtil showErrorWithStatus:@"你的实名认证还在审核中！"];
            }
        }
    }
    else
    {
        {
            __block CRSliverDetailViewController* weakself = self;
            weakself.cover.hidden = YES;
            weakself.popView.hidden = YES;
            ((UIScrollView *)weakself.view).scrollEnabled = YES;
        }
        
        PUSH_VIEWCONTROLLER(MerchantDetailViewController)
        model.comefrom = @"3";
        model.enId = [NSString stringWithFormat:@"%d",(int)_enterId];
        _ifReloadData = YES;
    }
}

- (void)shangjia:(DelegatorArguments *)arg
{
    if (arg.ret.operationSucceed)
    {
        [HUDUtil showSuccessWithStatus:@"商家上架后将通过消息提醒您"];
    }
    else
    {
        [HUDUtil showErrorWithStatus:@"上架提醒失败"];
    }
}

@end
