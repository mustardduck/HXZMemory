//
//  DetailBannerAdvertViewController.m
//  miaozhuan
//
//  Created by apple on 14/11/5.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "DetailBannerAdvertViewController.h"
#import "NetImageView.h"
#import "RRNavBarDrawer.h"
#import "MerchantDetailViewController.h"
#import "ConsultViewController.h"
#import "KxMenu.h"
#import "DotCWebView.h"
#import "BannerDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "UIImage+LK.h"
#import "KZLinkLabel.h"

@interface DetailBannerAdvertViewController ()<RRNavBarDrawerDelegate,KxMenuDelegate, UIActionSheetDelegate>{
    /** 是否已打开抽屉 */
    BOOL _isOpen;
    
    RRNavBarDrawer *navBarDrawer;
    DotCWebView *_webViewController;
    
}

@property (retain, nonatomic) IBOutlet UIScrollView *MainScrollerview;
@property (retain, nonatomic) IBOutlet UILabel *lblTitle;
@property (retain, nonatomic) IBOutlet UIView *headerVIew;
@property (retain, nonatomic) IBOutlet UIView *footerVIew;
@property (retain, nonatomic) IBOutlet UIView *enInfoVIew;
@property (retain, nonatomic) IBOutlet UIView *linkView;
@property (retain, nonatomic) IBOutlet KZLinkLabel *lblPhoneNum;
@property (retain, nonatomic) IBOutlet UILabel *lblAddress;
@property (retain, nonatomic) IBOutlet UILabel *lblLink;
@property (retain, nonatomic) IBOutlet UIView *showVIew;
@property (retain, nonatomic) IBOutlet UILabel *lblContent;
@property (retain, nonatomic) IBOutlet UILabel *lblAddressTitle;

@property (nonatomic, retain) DictionaryWrapper *dataDic;

@end

//图片高度
//CGFloat height = 100;//图片高度

@implementation DetailBannerAdvertViewController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupMoveBackButton];
    
    [self getRequrestData];
    
    if (_comeformCounsel == 1)
    {
        
    }
    else
    {
        [self setupMoveFowardButtonWithImage:@"more.png" In:@"morehover.png"];
    }
    
    //初始化超链接Label
    _lblPhoneNum.automaticLinkDetectionEnabled = YES;
    _lblPhoneNum.lineBreakMode = NSLineBreakByTruncatingTail;
    _lblPhoneNum.linkColor = [UIColor blueColor];
    _lblPhoneNum.linkHighlightColor = [UIColor orangeColor];
}

//点击 --- 关闭
- (void)onMoveFoward:(UIButton *)sender
{
    // show menu
    if(![KxMenu isOpen])
    {
        NSArray *menuItems =
        @[
          
          [KxMenuItem menuItem:@"商家详情"
                         image:[UIImage imageNamed:@"021"] highlight:nil
                        target:self
                        action:@selector(pushMenuItem:)],
          
          [KxMenuItem menuItem:@"咨询"
                         image:[UIImage imageNamed:@"zixun"] highlight:nil
                        target:self
                        action:@selector(pushMenuItem:)],
          ];
        
        
        CGRect rect = sender.frame;
        rect.origin.y = self.navigationController.navigationBar.frame.size.height;
        
        [KxMenu showMenuInView:self.navigationController.view
                      fromRect:rect
                     menuItems:menuItems itemWidth:125.0f] ;
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
    NSLog(@"%@", sender);
}

-(void)which_tag_clicked:(int)tag
{
    NSLog(@"shit :%d", tag);
    
    //商家详情
    if(tag == 0)
    {
        PUSH_VIEWCONTROLLER(MerchantDetailViewController);
        model.enId = [_dataDic getString:@"EnterpriseId"];
        model.comefrom = @"6";
        
    }
    //咨询
    else if(tag == 1)
    {
        PUSH_VIEWCONTROLLER(ConsultViewController);
        NSDictionary *tempDic = @{@"Id":_advertId.length ? _advertId : @"",@"Type":@"3"};
        model.commitDic = [NSMutableDictionary dictionaryWithDictionary:tempDic];
    }
}

- (void)getRequrestData{
    ADAPI_BannerAdvert_Detail([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleBannerDetail:)], _adId);
}
#pragma mark - 获取数据后刷新页面
- (void)refresh:(DictionaryWrapper *)dic{
    if (!dic.dictionary.count) {
        return;
    }
    
    NSString *title = [dic getString:@"Title"];
    NSArray *headerPicUrls = [dic get:@"HeadPictures"];
    NSString *content = [dic getString:@"Content"];
    
    //计算title高度
    if (title.length && ![title isKindOfClass:[NSNull class]]) {
        CGSize size = [UICommon getSizeFromString:title withSize:CGSizeMake(SCREENWIDTH - 30, MAXFLOAT) withFont:19];
        _lblTitle.height = size.height;
        self.navigationItem.title = _lblTitle.text = title;
        
        _headerVIew.top = _lblTitle.bottom + 10;
        
    } else {
        _lblTitle.hidden = YES;
        _lblTitle.height = 0;
        _headerVIew.top = _lblTitle.bottom;
    }
    
    
    //heder view 的高度和位置
    if (headerPicUrls.count) {
        
        float allheight = [self createInView:_headerVIew pictures:headerPicUrls];
        _headerVIew.height = allheight + (headerPicUrls.count - 1) * 10;
        
        _lblContent.top = _headerVIew.bottom + 10;
    } else {
        _headerVIew.hidden = YES;
        _headerVIew.height = 0;
        _lblContent.top = _headerVIew.bottom;
    }
    
    [self countHeight];
    
}
//动态创建header 或者 footer image
- (float)createInView:(UIView *)view pictures:(NSArray *)pictures{
    
    int count = 0;
    int allheight = 0;
    CGFloat lastHeight = .0f;
    for (NSDictionary *picDic in pictures) {
        
        NetImageView *imageview = WEAK_OBJECT(NetImageView, init);
        [imageview requestWithRecommandSize:[[picDic wrapper] getString:@"PictureUrl"] placeHolder:@""];
        
        NSString *urlStr = [[picDic wrapper] getString:@"PictureUrl"];
        CGSize size = [UIImage downloadImageSizeWithURL:[NSURL URLWithString:urlStr]];
        if(size.width == 0 && size.height == 0)
        {
            size.width = imageview.width;
            size.height = 185;
        }
        
        CGFloat roate = size.width / view.width;
        int height = size.height / roate;
        
        //        frame.size.height = height;
        //        iv.frame = frame;
        
        //        imageview.frame = CGRectMake(0, (size.height + 10) * count , view.width, size.height);

        
        
//        allheight += height;
      
        if(count <= 0)
            imageview.frame = CGRectMake(0, (size.height + 10) * count , view.width, height);
        else
        {
            imageview.frame = CGRectMake(0, lastHeight + 10 , view.width, height);
        }
        
        [view addSubview:imageview];
        count++;
        allheight += height;
        
        lastHeight = imageview.frame.origin.y + imageview.frame.size.height;
    }
    return allheight;
}

- (void)handleBannerDetail:(DelegatorArguments*)arguments
{
    DictionaryWrapper* dic = arguments.ret;
    if (dic.operationSucceed)
    {
        _showVIew.hidden = YES;
        self.dataDic = dic.data;
        [self refresh:dic.data];
    }
    else
    {
        [HUDUtil showErrorWithStatus:dic.operationMessage];
        return;
    }
}

- (IBAction)makeCallClicked:(id)sender {
    NSString *phone = _lblPhoneNum.text;
    [[UICommon shareInstance] makeCall:phone];
}

#pragma mark - rrnavbardrawer delegate
- (void)didClickItem:(RRNavBarDrawer *)drawer atIndex:(NSInteger)index{
    if (index) {//咨询
        PUSH_VIEWCONTROLLER(ConsultViewController);
        NSDictionary *tempDic = @{@"Id":_adId.length ? _adId : @"",@"Type":@"3"};
        model.commitDic = [NSMutableDictionary dictionaryWithDictionary:tempDic];
    } else {//商家详情
        PUSH_VIEWCONTROLLER(MerchantDetailViewController);
        model.enId = [_dataDic getString:@"EnterpriseId"];
        model.comefrom = @"6";
    }
}

- (void)countHeight{
    
    NSString *content = [_dataDic getString:@"Content"];
    NSArray *footerPicUrls = [_dataDic get:@"EndPictures"];
    
    if (content.length) {
        
        CGSize size = [UICommon getSizeFromString:content withSize:CGSizeMake(290, MAXFLOAT) withFont:15];
        _lblContent.height = size.height;
        _lblContent.text = content;
        //计算content高度
        _footerVIew.top = _lblContent.bottom + 10;
    } else {
        _lblContent.hidden = YES;
        _lblContent.height = 0;
        _footerVIew.top = _lblContent.bottom;
    }
    
    //footer view 的高度和位置
    if (footerPicUrls.count) {
        
        float imgheight = [self createInView:_footerVIew pictures:footerPicUrls];
        _footerVIew.height = imgheight + (footerPicUrls.count - 1) * 10;
        
        _enInfoVIew.top = _footerVIew.bottom + 10;
    } else {
        _footerVIew.hidden = YES;
        _footerVIew.height = 0;
        _enInfoVIew.top = _footerVIew.bottom;
    }
    
    
    //设置eninfoview的位置
    NSString *address = [_dataDic getString:@"Address"];
    NSString *phone = [_dataDic getString:@"Phone"];
    NSString *link = [_dataDic getString:@"LinkUrl"];
    
    address = [address isKindOfClass:[NSNull class]] ? @"" : address;
    phone = [phone isKindOfClass:[NSNull class]] ? @"" : phone;
    link = [link isKindOfClass:[NSNull class]] ? @"" : link;
    
    if (!address.length && !phone.length && !link.length) {
        _enInfoVIew.hidden = YES;
        _enInfoVIew.height = 0;
    } else {
        
        CGSize address_size = [UICommon getSizeFromString:address withSize:CGSizeMake(SCREENWIDTH - 30, MAXFLOAT) withFont:14];
        _lblAddress.height = address_size.height;
        //linview 链接
        _linkView.top = _lblAddress.bottom + 10;
        
        _lblAddress.text = address;
        _lblAddressTitle.hidden = !address.length;
        
        
        NSDictionary *attributes = @{NSFontAttributeName: [_lblPhoneNum font]};
        NSAttributedString *attributedString = [NSAttributedString emotionAttributedStringFrom:phone attributes:attributes];
        _lblPhoneNum.attributedText = attributedString;
//        _lblPhoneNum.text = phone;
        
        //单击
        _lblPhoneNum.linkTapHandler = ^(KZLinkType linkType, NSString *string, NSRange range){
                [self openTel:string];
        };
        
        //长按
        _lblPhoneNum.linkLongPressHandler = ^(KZLinkType linkType, NSString *string, NSRange range){
            
            UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil
                                                               delegate:self
                                                      cancelButtonTitle:@"取消"
                                                 destructiveButtonTitle:nil
                                                      otherButtonTitles:@"拷贝",@"直接拨打", nil];
            [sheet showInView:self.view];
        };
        
        if (!link.length) {
            _linkView.hidden = YES;
            _linkView.height = 0;
            _enInfoVIew.height = _linkView.bottom;
            
        } else {
            _enInfoVIew.height = _linkView.bottom + 10;
            _lblLink.text = link;
        }
        _lblLink.textColor = [UIColor blueColor];
    }
    
    //设置scrollview的contentsize
    _MainScrollerview.contentSize = CGSizeMake(SCREENWIDTH, _enInfoVIew.bottom);
}
//跳转商家
- (IBAction)turnToShop:(id)sender {
    
    NSString *str = _lblLink.text;
    if (str.length) {
        PUSH_VIEWCONTROLLER(BannerDetailViewController);
        
        model.urlStr = str;
    }
    
}

//打开电话
- (BOOL)openTel:(NSString *)tel
{
    NSString *telString = [NSString stringWithFormat:@"tel://%@",tel];
    return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telString]];
}

#pragma mark - Action Sheet Delegate

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:
        {
            [UIPasteboard generalPasteboard].string = _lblPhoneNum.text;
            break;
        }
        case 1:
        {
            [self openTel:_lblPhoneNum.text];
            break;
        }
    }
}

#pragma mark - 内存管理
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
- (void)dealloc
{
    [_adId release];
    [_advertId release];
    [_dataDic retainCount];
    [_MainScrollerview release];
    [_lblTitle release];
    [_headerVIew release];
    [_footerVIew release];
    [_enInfoVIew release];
    [_linkView release];
    [_lblPhoneNum release];
    [_lblAddress release];
    [_lblLink release];
    [_showVIew release];
    [_lblContent release];
    [_lblAddressTitle release];
    [super dealloc];
}

- (void)viewDidUnload
{
    [self setDataDic:nil];
    [self setMainScrollerview:nil];
    [self setLblTitle:nil];
    [self setHeaderVIew:nil];
    [self setFooterVIew:nil];
    [self setEnInfoVIew:nil];
    [self setLinkView:nil];
    [self setLblPhoneNum:nil];
    [self setLblAddress:nil];
    [self setLblLink:nil];
    [self setShowVIew:nil];
    [super viewDidUnload];
}
@end
