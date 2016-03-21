//
//  AdsDetailViewController.m
//  miaozhuan
//
//  Created by 孙向前 on 14-10-23.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "AdsDetailViewController.h"
#import "NetImageView.h"
#import "GoodsListViewCell.h"
#import "MerchantDetailViewController.h"
#import "DelegatorManager.h"
#import "BannerDetailViewController.h"
#import "RCScrollView.h"
#import "ConsultViewController.h"
#import "PreviewViewController.h"
#import "Share_Method.h"
#import "VipPriviliegeViewController.h"
#import "Redbutton.h"
#import "ScrollerViewWithTime.h"
#import "PlaySound.h"
#import "CRSliverDetailViewController.h"
#import "VoiceControl.h"
#import "RRLineView.h"
#import "PreviewViewController.h"
#import "KxMenu.h"
#import "UI_CycleScrollView.h"

#import "CRDateCounter.h"
#import "PhoneAuthenticationViewController.h"
#import "RealNameAuthenticationViewController.h"
@interface AdsDetailViewController ()<UITextFieldDelegate, KxMenuDelegate, UI_CycleScrollViewDelegate,UIScrollViewDelegate>{
    UIImageView *moneyImageView;
    ScrollerViewWithTime *_recommandBanner;
    BOOL _isGame;
    BOOL _notOnceADay;
}
@property (retain, nonatomic) IBOutlet UILabel *lblIntergal24;
@property (retain, nonatomic) IBOutlet UILabel *lblIntergal7;
@property (retain, nonatomic) IBOutlet UILabel *normalStr;
@property (retain, nonatomic) IBOutlet UIView *v7View;
@property (retain, nonatomic) IBOutlet UIView *normalView;
@property (retain, nonatomic) IBOutlet UILabel *lblTtName;
@property (retain, nonatomic) IBOutlet RRLineView *line1;
@property (retain, nonatomic) IBOutlet UILabel *lblConsult;

@property (retain, nonatomic) IBOutlet UIView *companyView;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollview;
@property (retain, nonatomic) IBOutlet UIView *contentView;
@property (retain, nonatomic) IBOutlet UIView *phoneAndAddressView;
@property (retain, nonatomic) IBOutlet UIView *mainView;
//ads
@property (retain, nonatomic) IBOutlet UILabel *lblAdsName;
@property (retain, nonatomic) IBOutlet UILabel *lblAdsWord;
//company
@property (retain, nonatomic) IBOutlet NetImageView *imgLogo;
@property (retain, nonatomic) IBOutlet UILabel *lblCompanyName;
@property (retain, nonatomic) IBOutlet UIButton *btnIsVip;
@property (retain, nonatomic) IBOutlet UIButton *btnSliver;
@property (retain, nonatomic) IBOutlet UIButton *btnGold;
@property (retain, nonatomic) IBOutlet UIButton *btnDirect;
//conten
@property (retain, nonatomic) IBOutlet UILabel *lblContent;
@property (retain, nonatomic) IBOutlet UILabel *lblMobile;
@property (retain, nonatomic) IBOutlet UIButton *btnMobile;
@property (retain, nonatomic) IBOutlet UILabel *lblAddress;
//tableview
@property (retain, nonatomic) IBOutlet UITableView *tableview;

@property (retain, nonatomic) IBOutlet UIView *hoverView;
@property (retain, nonatomic) IBOutlet UIView *lookTypeView;
@property (retain, nonatomic) IBOutlet UITextField *txtKeyWord;
@property (retain, nonatomic) IBOutlet UILabel *lblPinYin;
@property (retain, nonatomic) IBOutlet UILabel *lblHanzi;

@property (retain, nonatomic) IBOutlet UIButton *btnCollect;
@property (retain, nonatomic) IBOutlet UILabel *lblIsCollection;
@property (retain, nonatomic) IBOutlet UIView *addressView;
@property (retain, nonatomic) IBOutlet UIImageView *lineAddr;
@property (retain, nonatomic) IBOutlet UIView *phoneView;
@property (retain, nonatomic) IBOutlet Redbutton *btnPickS;
@property (retain, nonatomic) IBOutlet UIScrollView *picScrollView;
@property (retain, nonatomic) IBOutlet UIImageView *imgArrow;

@property (nonatomic, assign) int integralNum;
@property (retain, nonatomic) DictionaryWrapper *dataDic;//所有数据
@property (nonatomic, retain) NSArray *dataArray;//tableview数据源
@property (nonatomic, retain) RCScrollView *bannerView;
@property (nonatomic, retain) RCScrollView *largeBannerView;
@property (nonatomic, retain) UI_CycleScrollView *cycleView;

@property (retain, nonatomic) IBOutlet UIView *btnView;
@property (retain, nonatomic) IBOutlet UIButton *counselBtn;
@end

@implementation AdsDetailViewController

- (void)viewWillAppear:(BOOL)animated
{
    NSDate *date = [[NSUserDefaults standardUserDefaults] objectForKey:@"AdsDetailViewController_date"];
    if (!date) {
        _notOnceADay = NO;
    } else {
        _notOnceADay = [date daysAgoAgainstMidnight] < 1;
    }
    
}

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (_comeformCounsel == 1) {
        //客户咨询跳转过来
        _btnCollect.enabled = NO;
        _btnPickS.userInteractionEnabled = NO;
        _btnPickS.backgroundColor = AppColorLightGray204;
        _counselBtn.enabled = NO;
    }
    
//    _btnPickS.userInteractionEnabled = NO;
//    _btnPickS.backgroundColor = AppColorLightGray204;
    
    [_tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self setupMoveBackButton];
    
    [self setupMoveFowardButtonWithImage:@"more" In:@"morehover"];
    
//    if (!_notShow) {
//        [self setupMoveFowardButtonWithTitle:@"商家详情"];
//    }
    _lblTtName.left = 80;
    _lblTtName.width = 160;
    self.navigationItem.titleView = _lblTtName;
    
    [_lookTypeView setRoundCorner];
//    [self setExtraCellLineHidden:_tableview];
    //数据源
    [self getDataFromRequest];
    
    //注册cell
    [self.tableview registerNib:[UINib nibWithNibName:@"GoodsListViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"GoodsListViewCell"];
}

////只要滚动了就会触发
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
//{
//    NSLog(@"ContentOffset y is %f",scrollView.contentOffset.y + SCREENHEIGHT - 124);
//    
//    NSLog(@"--%f",_phoneAndAddressView.frame.origin.y + _phoneAndAddressView.height);
//    
//    if (scrollView.contentOffset.y + SCREENHEIGHT - 124 >= _phoneAndAddressView.frame.origin.y + _phoneAndAddressView.height)
//    {
//        _btnPickS.userInteractionEnabled = YES;
//        _btnPickS.backgroundColor = AppColorRed;
//    }
//}


#pragma mark - banner
- (void)createBannerViewWithImages:(NSArray *)images{
    
    if (!images.count) {
        return;
    }
    
//    CGSize tempsize = {150,217};
//    if (!_recommandBanner) {
//        _recommandBanner = [[ScrollerViewWithTime controllerFromView:_picScrollView pictureSize:tempsize] retain];
//    }
//    
//    [_recommandBanner addImageItems:images];
//    
//    __block typeof(self) weakself = self;
//    _recommandBanner.TapActionBlock = ^(NSInteger pageIndex){
//        PreviewViewController *model = WEAK_OBJECT(PreviewViewController, init);
//        model.currentPage = pageIndex;
//        NSMutableArray *pics = [NSMutableArray array];
//        for (NSString *url in [weakself.dataDic getArray:@"Pictures"]) {
//            [pics addObject:@{@"PictureUrl" : url}];
//        }
//        model.dataArray = pics;
//        [weakself presentViewController:model animated:NO completion:nil];
//    };
    
    _cycleView = [[UI_CycleScrollView alloc] initWithFrame:_picScrollView.frame];
    _cycleView.delegate = self;
     [_picScrollView addSubview:_cycleView];
    
    [_cycleView setPictureUrls:[NSMutableArray arrayWithArray:images]];
}

-(void)CycleImageTap:(int)page {
    
    PreviewViewController *model = WEAK_OBJECT(PreviewViewController, init);
    model.currentPage = page;
    NSMutableArray *pics = [NSMutableArray array];
    for (NSString *url in [self.dataDic getArray:@"Pictures"]) {
        [pics addObject:@{@"PictureUrl" : url}];
    }
    model.dataArray = pics;
    [self presentViewController:model animated:NO completion:nil];
    
}

#pragma mark - 网络请求
//获取表格数据源
- (void)getDataFromRequest{
    
    ADAPI_adv23_enterprise_advertDetail([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleAdsDetail:)], _adId.length ? _adId : @"");
}

- (void)refresh:(DictionaryWrapper *)dic{
    
    self.dataArray = [dic get:@"SilverProducts"];
    [self.tableview reloadData];
    
//    _imgArrow.hidden = (![[dic getString:@"Link"] length] || [[dic getString:@"Link"] isKindOfClass:[NSNull class]]);
    
    //创建banner
    [self createBannerViewWithImages:[dic get:@"Pictures"]];
    
    //广告信息
   _lblTtName.text = _lblAdsName.text = [dic getString:@"Title"];
    _lblAdsWord.text = [dic getString:@"Slogan"];
    _lblHanzi.text = [dic getString:@"SloganCoreWord"];
    _lblPinYin.text = [dic getString:@"SloganCoreWordSpell"];
    
    NSArray * spellArray = [_lblPinYin.text componentsSeparatedByString:@" "];
    NSMutableArray * pinArray = [[NSMutableArray alloc] init];
    NSMutableArray * tempArray = [[NSMutableArray alloc] init];
    [tempArray addObjectsFromArray:spellArray];
    for(int i = 0 ; i < [tempArray count]; i ++)
    {
        NSString * str = [tempArray objectAtIndex:i];
        if([str length] > 0)
        {
            NSString *num = [str stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
            char c = [str characterAtIndex:0];
            if((c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') || !num.length) //拼音字符
            {
                [pinArray addObject:str];
            }
        }
        
    }
    NSLog(@"pin yin = %@" , pinArray);
    NSLog(@"count = %d" , [pinArray count]);
    
    NSMutableArray * pinNumArray = [[NSMutableArray alloc] init];  //拼音数组
    for(int i = 0 ; i < [pinArray count]; i ++) //获取每个拼音的长度
    {
        //            NSString * pinStr = (NSString *)[pinArray objectAtIndex:i];
        //   NSNumber * num = [NSNumber numberWithInt:[pinStr length]];
        NSNumber * num = @(66);//[NSNumber numberWithInt:[pinStr sizeWithFont:[UIFont systemFontOfSize:13.0]].width ];
        NSLog(@"pin length = %f" , [num floatValue]);
        [pinNumArray addObject:num];
    }
    
    NSString * hanZiStr = [NSString stringWithFormat:@"%@",[dic getString:@"SloganCoreWord"]];
    hanZiStr = [hanZiStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    //拼音,汉字等距离加入
    float totalLen = 65; //初始横坐标
    int tempNum = 0; //记录汉字截断的位置
    hanZiStr = [hanZiStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    for(int i = 0 ; i <  [pinArray count]; i ++)
    {
        //float width = [[pinNumArray objectAtIndex:i] intValue] * 7.5;
        float width = 35;//[[pinNumArray objectAtIndex:i] floatValue] + 6;
        UILabel * pinYinLabel = [[UILabel alloc] initWithFrame:CGRectMake(totalLen, _lblPinYin.top, width, 21)];
        pinYinLabel.font = [UIFont systemFontOfSize:9];
        pinYinLabel.textAlignment = NSTextAlignmentLeft;
        [pinYinLabel setTextColor:RGBCOLOR(255, 165, 12)];
        pinYinLabel.text = [NSString stringWithFormat:@"%@" , [pinArray objectAtIndex:i]];
        [_lookTypeView addSubview:pinYinLabel];
        [pinYinLabel release];
        
        UILabel * hanZiLabel = [[UILabel alloc] initWithFrame:CGRectMake(totalLen, _lblHanzi.top, width , 21)];
        hanZiLabel.font = [UIFont systemFontOfSize:15];
        hanZiLabel.textAlignment = NSTextAlignmentLeft;
        [hanZiLabel setTextColor:RGBCOLOR(255, 165, 12)];
        // NSMutableString * pinYinStr = [[NSMutableString alloc] init];
        NSMutableString *pinYinStr = [NSMutableString stringWithString:@""];
        for(int i = tempNum ; i < [hanZiStr length]; i ++)
        {
            unichar c = [hanZiStr characterAtIndex:i];
//            if((c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z')) //拼音字符
//            {
//                [pinYinStr appendString:[NSString stringWithFormat:@"%c" , c]];
//            }
//            else    //汉字字符
//            {
                if([pinYinStr length] == 0)
                {
                    [pinYinStr appendString:[hanZiStr substringWithRange:NSMakeRange(i, 1)]]; //获取汉字
                    tempNum = i + 1;
                }
                else
                {
                    tempNum = i;  //下次从这里截取
                }
                break;
//            }
        }
        hanZiLabel.text = pinYinStr;
        [_lookTypeView addSubview:hanZiLabel];
        [hanZiLabel release];
        // [pinYinStr  release];
        
        totalLen += width;
    }
    
    [pinNumArray release];
    [pinArray release];
    [tempArray release];
    
    _lblHanzi.hidden = YES;
    _lblPinYin.hidden = YES;
    
    _lblIntergal7.text = [NSString stringWithFormat:@"+%@", [dic getString:@"NormalEarning"]];
    _lblIntergal24.text = [NSString stringWithFormat:@"+%@", [dic getString:@"GameEarning"]];
    
    //企业信息
    DictionaryWrapper *enInfos = [[dic get:@"EnterpriseInfo"] wrapper];
    _lblCompanyName.text = [enInfos getString:@"Name"];
    [_imgLogo setRoundCorner:11];
    [_imgLogo requestWithRecommandSize:[enInfos getString:@"LogoUrl"]];
    //银、金、直icon位置
    _btnGold.selected = [enInfos getBool:@"IsGold"];
    _btnDirect.selected = [enInfos getBool:@"IsDirect"];
    _btnIsVip.selected = [enInfos getBool:@"IsVip"];
    _btnSliver.selected = [enInfos getBool:@"IsSilver"];
    
    _btnCollect.selected = [dic getBool:@"IsCollect"];
    if (_btnCollect.selected) {
        _lblIsCollection.text = @"已收藏";
        _lblIsCollection.textColor = RGBCOLOR(240, 5, 0);
    } else {
        _lblIsCollection.text = @"收藏";
        _lblIsCollection.textColor = RGBCOLOR(136, 136, 136);
    }
    
    //电话位置、商家地址位置
    [self setMobileButtonPosition:dic];
    //scrollview动态高度
    [self setHeightForScrollView:[dic getString:@"Content"]];
}

- (void)handleAdsDetail:(DelegatorArguments *)arguments{
    DictionaryWrapper* dic = arguments.ret;
    if (dic.operationSucceed)
    {
        if (_isMerchant) {
            _btnPickS.enabled = [dic.data getBool:@"IsAllowEarn"];
            if (!_btnPickS.enabled) {
                _btnPickS.backgroundColor = AppColorLightGray204;
                [HUDUtil showImage:nil status:@"\n您不是该广告的目标人群\n您只能看广告,不能捡银子\n"];
            }
        }
        
        _scrollview.hidden = NO;
        self.dataDic = [dic.data wrapper];
        [self refresh:_dataDic];
    }
    else
    {
        [HUDUtil showErrorWithStatus:dic.operationMessage];
        return;
    }
}

#pragma mark - 高度位置计算

//电话按钮位置和地址高度
- (void)setMobileButtonPosition:(DictionaryWrapper *)dic{
    _phoneAndAddressView.height = 0;
    if ([dic getBool:@"IsShowTel"]) {
        //电话
        CGSize size = [UICommon getSizeFromString:[dic getString:@"Tel"]
                                         withSize:CGSizeMake(MAXFLOAT, 21)
                                         withFont:19];
        _lblMobile.width = size.width;
        _lblMobile.text = [dic getString:@"Tel"];
        _phoneAndAddressView.height += _phoneView.height;
    } else {
        _addressView.top = _phoneView.top;
        _phoneView.hidden = YES;
        _lineAddr.hidden = YES;
    }
    if ([dic getBool:@"IsShowAddress"]) {
        //地址
        CGSize addressSize = [UICommon getSizeFromString:[dic getString:@"Address"]
                                                withSize:CGSizeMake(_lblAddress.width, MAXFLOAT)
                                                withFont:14];
        _lblAddress.height = addressSize.height;
        _lblAddress.text = [dic getString:@"Address"];
        _addressView.height = addressSize.height + 32;//_lblAddress.bottom < 50 ? 50 : _lblAddress.bottom;
        _phoneAndAddressView.height += _addressView.height + 10;
    } else {
        _addressView.hidden = YES;
    }
    
    if ([dic getBool:@"IsShowTel"] && [dic getBool:@"IsShowAddress"]) {
        RRLineView *templine = WEAK_OBJECT(RRLineView, initWithFrame:CGRectMake(15, _phoneView.bottom - 5, SCREENWIDTH, 0.5));
        [_phoneAndAddressView addSubview:templine];
    }
}

//计算scrollview高度并动态改变
- (void)setHeightForScrollView:(NSString *)content{
    
    //contentview height
    CGSize size = [UICommon getSizeFromString:content
                                     withSize:CGSizeMake(_lblContent.width, MAXFLOAT)
                                     withFont:14];
    _lblContent.text = content;
    _lblContent.height = size.height;
    _contentView.height = 50 + size.height;
    _line1.top =_contentView.height;
    
    //company view y
    _companyView.top = _contentView.bottom + 10;
    
    //_phoneAndAddressView y
    _phoneAndAddressView.top = _companyView.bottom;
    
    //mainview height
    _mainView.height = _phoneAndAddressView.bottom;
    
    //tableview y
    _tableview.top = _mainView.bottom + 10;
    
//    _btnView.top = _tableview.bottom +10;
    
    [self setHeightForTableView];
    
    //mainview contentsize height
    RRLineView *line = WEAK_OBJECT(RRLineView, initWithFrame:CGRectMake(0, _phoneAndAddressView.bottom, SCREENWIDTH, 0.5));
    [_mainView addSubview:line];
//    RRLineView *view = WEAK_OBJECT(RRLineView, initWithFrame:CGRectMake(0, _tableview.bottom, SCREENWIDTH, 0.5));
//    [_scrollview addSubview:view];
    
//    _mainView.height = _btnView.bottom + 10.f;
    
//    ------------- mark
    
//    _btnView.top = _tableview.bottom +10;
//    
//    _scrollview.contentSize = CGSizeMake(SCREENWIDTH, _mainView.height);
    
    
    _btnView.top = _tableview.bottom +10;
    
    _mainView.height = _btnView.bottom + 10.f;
    
    _scrollview.contentSize = CGSizeMake(SCREENWIDTH, _mainView.height);
    
    
    
}
//计算表格高度
- (void)setHeightForTableView{
    if (!_dataArray.count) {
        _tableview.height = 0;
        _tableview.tableHeaderView.height = 0;
        return;
    }
    //cell height + header height
    _tableview.height = 30 + [_dataArray count] * 110;
}
- (IBAction)shopdetailClicked:(id)sender {
    
    NSString *enId = [[[_dataDic get:@"EnterpriseInfo"] wrapper] getString:@"Id"];
    if (!enId.length) {
        return;
    }
    PUSH_VIEWCONTROLLER(MerchantDetailViewController);
    model.enId = enId;
    model.comefrom = @"1";
}

#pragma mark - UITableViewDelegate/UITableViewDatasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110.f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"GoodsListViewCell";
    GoodsListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.dataDic = self.dataArray[indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    
    if (indexPath.row == _dataArray.count - 1) {
        cell.lineview.left = 0;
        cell.lineview.top = 109;
    }
    cell.lineview.top = 109.5;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DictionaryWrapper *dic = [self.dataArray[indexPath.row] wrapper];
    PUSH_VIEWCONTROLLER(CRSliverDetailViewController);
    model.advertId = [_adId intValue];
    model.productId = [dic getInt:@"Id"];
}

#pragma mark - uitextfield delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [UIView animateWithDuration:.3 animations:^{
        if ([UICommon getIos4OffsetY]) {
            _lookTypeView.top = -100;
        } else {
            _lookTypeView.top = -180;
        }
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    [UIView animateWithDuration:.3 animations:^{
        if ([UICommon getIos4OffsetY]) {
            _lookTypeView.top = 45;
        } else {
            _lookTypeView.top = 0;
        }
    }];
    return YES;
}

#pragma mark - 事件
//图片动画
-(void)imageAnmation{
    self.view.userInteractionEnabled = NO;
    if (!moneyImageView) {
        moneyImageView = STRONG_OBJECT(UIImageView, initWithFrame:self.view.window.frame);
    }
    moneyImageView.backgroundColor = [UIColor clearColor];
    
    [self.view.window addSubview:moneyImageView];
    NSMutableArray *imageArray = [NSMutableArray new] ;
    for (int i = 1; i < 26; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"合成%d.png",i]];
        [imageArray  addObject:image];
    }
    
    moneyImageView.animationImages = imageArray;
    moneyImageView.animationDuration = 2;
    [moneyImageView startAnimating];
    [imageArray release];
    [self performSelector:@selector(textFieldAnimation:) withObject:nil afterDelay:0.5];
    [self performSelector:@selector(stopAnimationed) withObject:nil afterDelay:1.8];
}
- (void)stopAnimationed{
    [moneyImageView stopAnimating];
    [moneyImageView removeFromSuperview];
}
//文字动画
- (void)textFieldAnimation:(NSString *)text{
    UILabel *lblIntegralNum = WEAK_OBJECT(UILabel, initWithFrame:CGRectMake(0, self.view.window.height / 3 * 2, SCREENWIDTH, 30));
    lblIntegralNum.text = [NSString stringWithFormat:@"+%d银元", self.integralNum];
    lblIntegralNum.font = Font(11);
    lblIntegralNum.textAlignment = UITextAlignmentCenter;
    lblIntegralNum.alpha = 0;
    lblIntegralNum.backgroundColor = [UIColor clearColor];
    lblIntegralNum.textColor = RGBCOLOR(240, 5, 0);
    lblIntegralNum.backgroundColor = [UIColor clearColor];
    [self.view.window addSubview:lblIntegralNum];
    __block typeof(self) weakSelf = self;
    [UIView animateWithDuration:1 animations:^{
        lblIntegralNum.font = Font(35);
        lblIntegralNum.alpha = 1.f;
        lblIntegralNum.top = weakSelf.view.window.height / 3;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.5 animations:^{
            lblIntegralNum.alpha = 0.f;
        } completion:^(BOOL finished) {
            [lblIntegralNum removeFromSuperview];
            if (!_isMerchant) {
                //下一个
                _btnPickS.enabled = YES;
                [weakSelf.navigationController popViewControllerAnimated:YES];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"lookNextAds" object:nil];
            } else {
                _btnPickS.enabled = YES;
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
            weakSelf.view.userInteractionEnabled = YES;
        }];
    }];
}

//跳转到商家官网
- (IBAction)turnToOfficialWebsite:(id)sender {
    
    if (![[_dataDic getString:@"Link"] length]) {
        [HUDUtil showErrorWithStatus:@"此商家没有官网"];
        return;
    }
    
    BannerDetailViewController *banner = WEAK_OBJECT(BannerDetailViewController, init);
    banner.urlStr = [_dataDic getString:@"Link"];
    [self.navigationController pushViewController:banner animated:YES];
}
//拨打电话
- (IBAction)makeCallClicked:(id)sender {
    [[UICommon shareInstance]makeCall:_lblMobile.text];
}
//商家详情
- (IBAction)onMoveFoward:(UIButton*) sender{
    
    // show menu
    if(![KxMenu isOpen])
    {
        NSMutableArray *menuItems = [NSMutableArray arrayWithCapacity:0];
        
        if (!_notShow) {
            [menuItems addObject:[KxMenuItem menuItem:@"商家详情"
                                                image:[UIImage imageNamed:@"ads_detailIconnormal"]
                                            highlight:[UIImage imageNamed:@"ads_detailIconhover"]
                                               target:self
                                               action:@selector(pushMenuItem:)]];
        }
        
        [menuItems addObject:[KxMenuItem menuItem:@"分享给好友"
                                           image:[UIImage imageNamed:@"preview_menu_3_0"]
                                       highlight:[UIImage imageNamed:@"preview_menu_3_1"]
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
    if (_notShow || tag == 1) {
        
        if (_adId.length) {
            [[Share_Method shareInstance] getShareDataWithShareData:@{@"advert_id":_adId, @"Key":@"dad6bfe1c15d4c6483f1b99872239fae"}];
        }
        
    } else {
        NSString *enId = [[[_dataDic get:@"EnterpriseInfo"] wrapper] getString:@"Id"];
        if (!enId.length) {
            return;
        }
        MerchantDetailViewController *merchant = WEAK_OBJECT(MerchantDetailViewController, init);
        merchant.enId = enId;
        merchant.comefrom = @"1";
        [UI_MANAGER.mainNavigationController pushViewController:merchant animated:YES];
    }
}


//继续
- (IBAction)nextAdsClicked:(UIButton *)sender
{
    [self isHiddenHover:YES];
    _isGame = NO;
   
    if (!_adId.length || [_adId isKindOfClass:[NSNull class]]) {
        return;
    }
    ADAPI_adv2_GeneratedIntegral([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleGenerated:)],@{@"Id":_adId, @"IsGame":@"false"});
}
//确定
- (IBAction)sureClciked:(UIButton *)sender {
    [self.view endEditing:YES];
    if (!_adId.length || [_adId isKindOfClass:[NSNull class]]) {
        return;
    }
    
    if (![_txtKeyWord.text isEqualToString:[_dataDic getString:@"SloganCoreWord"]]) {
        [HUDUtil showErrorWithStatus:@"核心记忆词输入错误!"];
        return;
    }
    _isGame = YES;
    [self isHiddenHover:YES];
    ADAPI_adv2_GeneratedIntegral([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleGenerated:)], @{@"Id":_adId, @"IsGame":@"true"});
}
//捡银子接口处理
- (void)handleGenerated:(DelegatorArguments *)arguments{
    
    DictionaryWrapper* dic = arguments.ret;
    int code = [dic getInt:@"Code"];
    if (dic.operationSucceed){
        _btnPickS.enabled = NO;
        self.integralNum = [dic getInt:@"Data"];
        [self imageAnmation];
        if ([VoiceControl isOpen]) {
            if (_isGame) {
                [PlaySound playSound:@"PickSilverV" type:@"mp3"];
            } else {
                [PlaySound playSound:@"pick" type:@"mp3"];
            }
        }
    } else if (code == 31306 || code == 31307) {
        //捡满了
        if ([VoiceControl isOpen]) {
            [PlaySound playSound:@"pickfull" type:@"mp3"];
        }
        DictionaryWrapper *dic =[APP_DELEGATE.runtimeConfig getDictionary:RUNTIME_USER_LOGIN_INFO].wrapper;
        int level = [dic getInt:@"VipLevel"];
        NSString *message = [NSString stringWithFormat:@"您今天已经捡满%d银元，继续看广告将不会获得银元奖励。",500+100*level];
        if (code == 31306) {
            [self vip7Alert:message];
        } else {
            [self notVip7Alert:message];
        }
        _btnPickS.enabled = YES;
    } else if (code == 31303 || code == 31304 || code == 31305){
        _btnPickS.enabled = YES;
        //31303: 你今天已经达到此广告最大播放数,不能获得银元
        //31304: 你已经达到此广告最大播放数,不能获得银元
        //31305: 广告银元已经播放完了,你已经不能获得银元
        [HUDUtil showSuccessWithStatus:dic.operationMessage];
        [UI_MANAGER.mainNavigationController popViewControllerAnimated:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"lookNextAds" object:nil];
    } else {
        _btnPickS.enabled = YES;
        [HUDUtil showErrorWithStatus:dic.operationMessage];
        return;
    }

}

- (void)vip7Alert:(NSString *)message{
    
    if (_notOnceADay){
        //下一个
        [self.navigationController popViewControllerAnimated:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"lookNextAds" object:nil];
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"AdsDetailViewController_date"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        _notOnceADay = YES;
        _hoverView.hidden = _v7View.hidden = NO;
        [_v7View setRoundCorner];
    }
   
}

- (void)notVip7Alert:(NSString *)message
{
    if (_notOnceADay){
        //下一个
        [self.navigationController popViewControllerAnimated:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"lookNextAds" object:nil];
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"AdsDetailViewController_date"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        _notOnceADay = YES;
        _hoverView.hidden = _normalView.hidden = NO;
        [_normalView setRoundCorner];
        _normalStr.text = message;
    }
    
}
//邀请粉丝
- (IBAction)invate:(id)sender{
    _hoverView.hidden = _v7View.hidden = _normalView.hidden = YES;
    [[Share_Method shareInstance] getShareDataWithShareData:@{@"Key":@"39851c48465f6a30877319000ad91470"}];
}
//购买vip
- (IBAction)buyVip:(id)sender {
    _hoverView.hidden = _v7View.hidden = _normalView.hidden = YES;
    PUSH_VIEWCONTROLLER(VipPriviliegeViewController);
}
//取消
- (IBAction)cancel:(id)sender {
    _hoverView.hidden = _v7View.hidden = _normalView.hidden = YES;
}

//收藏
- (IBAction)collectionButtonClicked:(UIButton *)sender {
    if (!sender.selected) {
        ADAPI_adv3_CollectAdvert([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleCollect:)], [_adId intValue], 1);
    } else {
        ADAPI_adv3_RemoveAdvert([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleCollect:)], [_adId intValue], 1);
    }
}
- (IBAction)collectDownClicked:(UIButton *)sender {
    if (sender.selected) {
        _lblIsCollection.textColor = AppColorRed;
    } else {
        _lblIsCollection.textColor = AppColor(189);
    }
    
}
//收藏接口处理
- (void)handleCollect:(DelegatorArguments *)arguments{
    NSLog(@"%@",arguments.ret);
    DictionaryWrapper* dic = arguments.ret;
    
    if (dic.operationSucceed)
    {
        _btnCollect.selected = !_btnCollect.selected;
        if (_btnCollect.selected) {
            [HUDUtil showSuccessWithStatus:@"收藏成功"];
            _lblIsCollection.text = @"已收藏";
            _lblIsCollection.textColor = RGBCOLOR(240, 5, 0);
        } else {
            [HUDUtil showSuccessWithStatus:@"取消收藏"];
            _lblIsCollection.text = @"收藏";
            _lblIsCollection.textColor = RGBCOLOR(136, 136, 136);
        }
    }
    else
    {
        [HUDUtil showErrorWithStatus:dic.operationMessage];
        return;
    }
}

//咨询
- (IBAction)consultButtonClicked:(UIButton *)sender {
  
    //3.3需求
    DictionaryWrapper * dic =[APP_DELEGATE.runtimeConfig getDictionary:RUNTIME_USER_LOGIN_INFO].wrapper;
    
    //判断是否商家
    if ([dic getInt:@"EnterpriseStatus"] == 4)//已激活商家
    {
        _lblConsult.textColor = AppColor(136);
        
        NSString *enId = [[[_dataDic get:@"EnterpriseInfo"] wrapper] getString:@"Id"];
        if (!enId.length) {
            return;
        }
        ConsultViewController *consult = WEAK_OBJECT(ConsultViewController, init);
        NSDictionary *tempDic = @{@"Id":[_dataDic getString:@"Id"],@"Type":@"1"};
        consult.commitDic = [NSMutableDictionary dictionaryWithDictionary:tempDic];
        [UI_MANAGER.mainNavigationController pushViewController:consult animated:YES];
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
- (IBAction)consultDownClicked:(id)sender {
    _lblConsult.textColor = AppColor(189);
}

- (void)isHiddenHover:(BOOL)isHidden{
    _hoverView.hidden = isHidden;
    _lookTypeView.hidden = isHidden;
    if (!isHidden) {
        if (![UICommon getIos4OffsetY]) {
            _lookTypeView.top = 0;
        } else {
            _lookTypeView.top = 45;
        }
    }
}
//捡银子
- (IBAction)pickSliverButtonClicked:(id)sender {
    
    //统计点击
    [APP_MTA MTA_touch_From:MTAEVENT_get_silver];
    
    [self isHiddenHover:NO];
}
//vip
- (IBAction)becomeVipClicked:(id)sender {
    PUSH_VIEWCONTROLLER(VipPriviliegeViewController);
}
//点击覆盖页面
- (IBAction)tapHover:(id)sender {
    [self isHiddenHover:YES];
    [self.view endEditing:YES];
    _v7View.hidden = _normalView.hidden = YES;
}

#pragma mark - 内存管理

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    _cycleView = nil;
    [moneyImageView release];
    [_adId release];
    [_largeBannerView release];
    [_dataArray release];
    [_lblAdsName release];
    [_lblAdsWord release];
    [_imgLogo release];
    [_lblCompanyName release];
    [_btnDirect release];
    [_btnGold release];
    [_btnIsVip release];
    [_btnSliver release];
    [_lblContent release];
    [_lblMobile release];
    [_lblAddress release];
    [_btnMobile release];
    [_tableview release];
    [_mainView release];
    [_phoneAndAddressView release];
    [_contentView release];
    [_scrollview release];
    [_companyView release];
    [_hoverView release];
    [_txtKeyWord release];
    [_lookTypeView release];
    [_lblIsCollection release];
    [_lblPinYin release];
    [_lblHanzi release];
    [_lineAddr release];
    [_addressView release];
    [_phoneView release];
    [_btnCollect release];
    [_btnPickS release];
    [_picScrollView release];
    [_lblTtName release];
    [_imgArrow release];
    [_line1 release];
    [_lblConsult release];
    [_normalView release];
    [_v7View release];
    [_normalStr release];
    [_lblIntergal7 release];
    [_lblIntergal24 release];
    [_counselBtn release];
    [_btnView release];
    [super dealloc];
}

@end
