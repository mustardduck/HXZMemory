//
//  ConsultationDetailViewController.m
//  miaozhuan
//
//  Created by apple on 14/11/6.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "ConsultationDetailViewController.h"
#import "ConsultTationDetailTableViewCell.h"
#import "UIView+expanded.h"
#import "NetImageView.h"
#import "UserInfo.h"
#import "RRAttributedString.h"


#import "OpenRedPacketViewController.h"
#import "AdsDetailViewController.h"
#import "DetailBannerAdvertViewController.h"
#import "CRSliverDetailViewController.h"
#import "Preview_Commodity.h"

@interface ConsultationDetailViewController ()
<UITextViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    BOOL isFirstShowKeyboard;
    
    BOOL isButtonClicked;
    
    BOOL isKeyboardShowing;
    
    BOOL isSystemBoardShow;
    
    DictionaryWrapper* dic;
    
    CGFloat keyboardHeight;
    
    NSMutableArray * contentArray;
    
    ConsultTationDetailTableViewCell *_cell;
    
    BOOL isEmpty;
    
    BOOL IsFavorite;
}

@property (retain, nonatomic) IBOutlet UIView *tooBarView;
@property (retain, nonatomic) IBOutlet UITextView *replyTextView;
@property (retain, nonatomic) IBOutlet UIButton *sendBtn;
@property (retain, nonatomic) IBOutlet UITableView *mainTableVIew;
@property (retain, nonatomic) IBOutlet UIView *lineView;

//初始frame
@property(assign,nonatomic) CGRect originalFrame;

@property (retain, nonatomic) IBOutlet UIButton *tableViewBtn;

@property (retain, nonatomic) IBOutlet UIView *headerView;
@property (retain, nonatomic) IBOutlet NetImageView *touxiangImage;
@property (retain, nonatomic) IBOutlet UILabel *phoneLable;
@property (retain, nonatomic) IBOutlet UIImageView *vipImage;
@property (retain, nonatomic) IBOutlet UILabel *qqLable;
@property (retain, nonatomic) IBOutlet UILabel *otherPhoneLable;
@property (retain, nonatomic) IBOutlet UILabel *emailLable;
@property (retain, nonatomic) IBOutlet UILabel *comeFromLable;
- (IBAction)comefromBtn:(id)sender;
@property (retain, nonatomic) IBOutlet RRLineView *topline;


- (IBAction)touchuUpInsideBtn:(id)sender;

@property (retain, nonatomic) IBOutlet UIButton *comefromBtns;

@end

@implementation ConsultationDetailViewController

@synthesize tooBarView = _tooBarView;
@synthesize replyTextView = _replyTextView;
@synthesize sendBtn = _sendBtn;
@synthesize tableViewBtn = _tableViewBtn;
@synthesize headerView = _headerView;

-(void)viewWillAppear:(BOOL)animated
{
    
}

- (void)HandleNotification:(DelegatorArguments *)arguments
{
    if ([arguments isEqualToOperation:ADOP_adv3_ReadCounsel])
    {
        [arguments logError];
        
        DictionaryWrapper *wrapper = arguments.ret;
        
        if (wrapper.operationSucceed)
        {
            dic = [wrapper.data retain];
            
            _tooBarView.hidden = NO;
            
            if ([wrapper.data getBool:@"IsFavorite"])
            {
                [self setupMoveFowardButtonWithImage:@"collectionFavtior" In:@"ads_collectionedhover"];
                IsFavorite = YES;
            }
            else
            {
                IsFavorite = NO;
                [self setupMoveFowardButtonWithImage:@"weishoucang" In:@"weishoucangHover"];
            }

//            NSLog(@"---isfavorite-%d",[wrapper.data getBool:@"IsFavorite"]);
            
            if (!contentArray)
            {
                contentArray = [NSMutableArray new];
            }
            [contentArray addObjectsFromArray:[dic getArray:@"ContentList"]];
            
//            NSLog(@"--content-%@",contentArray);
            
            [self setRoudLoad:dic];
            [_mainTableVIew reloadData];
        }
        else if (wrapper.operationPromptCode || wrapper.operationErrorCode)
        {
            [HUDUtil showErrorWithStatus:wrapper.operationMessage];
        }
    }
    else if ([arguments isEqualToOperation:ADOP_adv3_ReplyCounsel])
    {
        [arguments logError];
        
        DictionaryWrapper *wrapper = arguments.ret;
        
        if (wrapper.operationSucceed)
        {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
            [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            
            NSString *time = [dateFormatter stringFromDate:[NSDate date]];
            [dateFormatter release];
            
            NSLog(@"----%@",time);
            
            NSDictionary * dic_m = @{@"Content":_replyTextView.text,@"CounselTime":time,@"Type":@"1"};
            
            [contentArray addObject:dic_m];
            
            _replyTextView.text = @"";
            [_mainTableVIew reloadData];
            
            NSIndexPath *path = [NSIndexPath indexPathForRow:contentArray.count-1 inSection:0];
            
            [_mainTableVIew scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            
            [_replyTextView resignFirstResponder];
            
            _tooBarView.frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - 115, 320, 51);
            
            _sendBtn.frame = CGRectMake(268, 0, 54,50);
            
            _lineView.frame = CGRectMake(0, 0, 320, 0.5);
            
            if ([_replyTextView.text isEqualToString:@""])
            {
                _sendBtn.enabled = NO;
            }
        }
        else if (wrapper.operationPromptCode || wrapper.operationErrorCode)
        {
            [_replyTextView resignFirstResponder];
            
            _tooBarView.frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - 115, 320, 51);
            
            _sendBtn.frame = CGRectMake(268, 0, 54,50);
            
            _lineView.frame = CGRectMake(0, 0, 320, 0.5);
            
            if ([_replyTextView.text isEqualToString:@""])
            {
                _sendBtn.enabled = NO;
            }

            [HUDUtil showErrorWithStatus:wrapper.operationMessage];
        }
    }
    else if ([arguments isEqualToOperation:ADOP_adv3_AddFavorite])
    {
        [arguments logError];
        
        DictionaryWrapper *wrapper = arguments.ret;
        
        if (wrapper.operationSucceed)
        {
            IsFavorite = YES;
            [HUDUtil showSuccessWithStatus:@"已收藏"];
            [self setupMoveFowardButtonWithImage:@"collectionFavtior" In:@"ads_collectionedhover"];
        }
        else if(wrapper.operationPromptCode || wrapper.operationErrorCode)
        {
            [AlertUtil showAlert:@"" message:wrapper.operationMessage buttons:@[@"好的"]];
        }
    }
    else if ([arguments isEqualToOperation:ADOP_adv3_CancelFavorite])
    {
        [arguments logError];
        
        DictionaryWrapper *wrapper = arguments.ret;
        
        if (wrapper.operationSucceed)
        {
            [HUDUtil showSuccessWithStatus:@"取消收藏"];
            IsFavorite = NO;
            [self setupMoveFowardButtonWithImage:@"weishoucang" In:@"weishoucangHover"];
        }
        else if(wrapper.operationPromptCode || wrapper.operationErrorCode)
        {
            [AlertUtil showAlert:@"" message:wrapper.operationMessage buttons:@[@"好的"]];
        }
    }
}

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    InitNav(@"咨询详情");
    
    ADAPI_adv3_ReadCounsel([self genDelegatorID:@selector(HandleNotification:)], _consultId);
    
    _mainTableVIew.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _replyTextView.text = @"回复该条咨询信息";
    
    _lineView.frame = CGRectMake(0, 0, 320, 0.5);
    
    _replyTextView.textColor = RGBCOLOR(204, 204, 204);
    
    isEmpty = YES;
    
    [self setNotificationCenter];
    
    _tooBarView.hidden = YES;
}

- (IBAction) onMoveFoward:(UIButton*) sender
{
    if (IsFavorite == YES)
    {
        NSMutableArray * arr = [NSMutableArray new];
        
        [arr addObject:_consultId];
        
        ADAPI_adv3_CancelFavorite([self genDelegatorID:@selector(HandleNotification:)], arr);
        
        [arr release];
    }
    else
    {
        ADAPI_adv3_AddFavorite([self genDelegatorID:@selector(HandleNotification:)], _consultId);
    }
}


-(void) setRoudLoad:(DictionaryWrapper*) result
{
    [_touxiangImage roundCornerRadiusBorder];
    
    [_touxiangImage requestPic:[dic getString:@"PhotoUrl"] placeHolder:NO];
    
    _phoneLable.text = [result getString:@"CustomerName"];
    
#define CTJ_ISNIL_DIC(_key) [result getString:_key]? [result getString:_key]:@""
    
    NSString * qq = CTJ_ISNIL_DIC(@"QQ");
    
    NSString * email = CTJ_ISNIL_DIC(@"Email");
    
    NSString * otherPhone = CTJ_ISNIL_DIC(@"Phone");
    
    int VipLevel = [result getInt:@"VipLevel"];
    
     _vipImage.image = [USER_MANAGER getVipPic:VipLevel];
    
    _comeFromLable.text = [NSString stringWithFormat:@"来自 %@",[result getString:@"RelatedTitle"]];
    
    if ([qq isEqualToString:@""] && [otherPhone isEqualToString:@""])
    {
        _qqLable.hidden = YES;
        _otherPhoneLable.hidden = YES;
        _emailLable.frame = CGRectMake(90, 39, 190, 21);
        _emailLable.text = [NSString stringWithFormat:@"邮箱：%@",email];
        
        _comeFromLable.frame = CGRectMake(15, 95, 290, 15);
        _comefromBtns.frame = CGRectMake(15, 85, 290, 30);
        _headerView.frame = CGRectMake(0, 0, 320, 126);
        _topline.frame = CGRectMake(0, 126, 320, 0.5);
    }
    else if ([qq isEqualToString:@""] && [email isEqualToString:@""])
    {
        _qqLable.hidden = YES;
        _emailLable.hidden = YES;
        _otherPhoneLable.frame = CGRectMake(90, 39, 170, 21);
        _otherPhoneLable.text = [NSString stringWithFormat:@"电话：%@",otherPhone];
        
        _comeFromLable.frame = CGRectMake(15, 95, 290, 15);
        _comefromBtns.frame = CGRectMake(15, 85, 290, 30);
        _headerView.frame = CGRectMake(0, 0, 320, 126);
        _topline.frame = CGRectMake(0, 126, 320, 0.5);
        
    }
    else if ([otherPhone isEqualToString:@""] && [email isEqualToString:@""])
    {
        _otherPhoneLable.hidden = YES;
        _emailLable.hidden = YES;
        _qqLable.frame = CGRectMake(90, 39, 190, 21);
        _qqLable.text = [NSString stringWithFormat:@"  QQ：%@",qq];
        
        _comeFromLable.frame = CGRectMake(15, 95, 290, 15);
        _comefromBtns.frame = CGRectMake(15, 85, 290, 30);
        _headerView.frame = CGRectMake(0, 0, 320, 126);
        _topline.frame = CGRectMake(0, 126, 320, 0.5);
        
    }
    else if ([qq isEqualToString:@""])
    {
        _qqLable.hidden = YES;
        _otherPhoneLable.frame = CGRectMake(90, 39, 150, 21);
        _emailLable.frame = CGRectMake(90, 59, 190, 21);
        
        _emailLable.text = [NSString stringWithFormat:@"邮箱：%@",email];
        _otherPhoneLable.text = [NSString stringWithFormat:@"电话：%@",otherPhone];
        
        _comeFromLable.frame = CGRectMake(15, 95, 290, 15);
        _comefromBtns.frame = CGRectMake(15, 85, 290, 30);
        _headerView.frame = CGRectMake(0, 0, 320, 126);
        _topline.frame = CGRectMake(0, 126, 320, 0.5);
    }
    else if ([otherPhone isEqualToString:@""])
    {
        _otherPhoneLable.hidden = YES;
        _qqLable.frame = CGRectMake(90, 39, 150, 21);
        _emailLable.frame = CGRectMake(90, 59, 190, 21);
        _qqLable.text = [NSString stringWithFormat:@"  QQ：%@",qq];
        _emailLable.text = [NSString stringWithFormat:@"邮箱：%@",email];
        
        _comeFromLable.frame = CGRectMake(15, 95, 290, 15);
        _comefromBtns.frame = CGRectMake(15, 85, 290, 30);
        _headerView.frame = CGRectMake(0, 0, 320, 126);
        _topline.frame = CGRectMake(0, 126, 320, 0.5);
    }
    else if ([email isEqualToString:@""])
    {
        _emailLable.hidden = YES;
        _qqLable.frame = CGRectMake(90, 39, 150, 21);
        _otherPhoneLable.frame = CGRectMake(90, 59, 170, 21);
        _qqLable.text = [NSString stringWithFormat:@"  QQ：%@",qq];
        _otherPhoneLable.text = [NSString stringWithFormat:@"电话：%@",otherPhone];
        
        _comeFromLable.frame = CGRectMake(15, 95, 290, 15);
        _comefromBtns.frame = CGRectMake(15, 85, 290, 30);
        _headerView.frame = CGRectMake(0, 0, 320, 126);
        _topline.frame = CGRectMake(0, 126, 320, 0.5);
    }
    else
    {
        _qqLable.text = [NSString stringWithFormat:@"  QQ：%@",qq];
        _emailLable.text = [NSString stringWithFormat:@"邮箱：%@",email];
        _otherPhoneLable.text = [NSString stringWithFormat:@"电话：%@",otherPhone];
        
        _comeFromLable.frame = CGRectMake(15, 113, 290, 15);
        _comefromBtns.frame = CGRectMake(15, 103, 290, 30);
        _headerView.frame = CGRectMake(0, 0, 320, 141);
        _topline.frame = CGRectMake(0, 141, 320, 0.5);
    }
    
    NSAttributedString * attributedStringorderNumPrice = [RRAttributedString setText:_comeFromLable.text color:RGBCOLOR(153, 153, 153) range:NSMakeRange(0, 3)];
    
    _comeFromLable.attributedText = attributedStringorderNumPrice;
    
    _mainTableVIew.tableHeaderView = _headerView;
    
    [self.view bringSubviewToFront:_tooBarView];
    
    if ([_replyTextView.text isEqualToString:@""])
    {
        _sendBtn.enabled = NO;
    }
    
    _mainTableVIew.frame = CGRectMake(0, 0, 320, [[UIScreen mainScreen] bounds].size.height - 115);
    
    _tableViewBtn.frame = _mainTableVIew.frame;
    
    _tableViewBtn.hidden = YES;
    
    _tooBarView.frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - 115, 320, 51);
    
    [_replyTextView roundCornerBorder];
    
    _replyTextView.delegate = self;
    
    isFirstShowKeyboard = YES;
}


-(void) setNotificationCenter
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];

}

#pragma mark keyboardNotification
- (void)keyboardWillShow:(NSNotification *)notification
{
    isKeyboardShowing = YES;
    
    _tableViewBtn.hidden = NO;
    
    NSDictionary *userInfo = [notification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardRect = [aValue CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    [UIView animateWithDuration:animationDuration
                     animations:^{
                         CGRect frame = CGRectMake(0, 0, 320, [[UIScreen mainScreen] bounds].size.height - 51);
                         frame.size.height += keyboardHeight;
                         frame = _tooBarView.frame;
                         frame.origin.y += keyboardHeight;
                         frame.origin.y -= keyboardRect.size.height;
                         _tooBarView.frame = frame;
                         _mainTableVIew.bottom = _tooBarView.top;
                         _tableViewBtn.bottom = _tooBarView.top;
                         
                         keyboardHeight = keyboardRect.size.height;
                     }];
    
    if ( isFirstShowKeyboard )
    {
        isFirstShowKeyboard = NO;
        
        isSystemBoardShow = !isButtonClicked;
    }
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    [UIView animateWithDuration:animationDuration
                     animations:^{
                         CGRect frame = CGRectMake(0, 0, 320, [[UIScreen mainScreen] bounds].size.height - 51);
                         frame.size.height += keyboardHeight;
                         
                         frame = _tooBarView.frame;
                         frame.origin.y += keyboardHeight;
                         _tooBarView.frame = frame;
                         _mainTableVIew.bottom = SCREENHEIGHT - 115;
                         _tableViewBtn.bottom = SCREENHEIGHT - 115;
                         
                         keyboardHeight = 0;
                     }];
}

- (void)keyboardDidHide:(NSNotification *)notification
{
    isKeyboardShowing = NO;
    
    if ( isButtonClicked )
    {
        
        isButtonClicked = NO;
        
        isSystemBoardShow = YES;
        
        _replyTextView.inputView = nil;
        
        [_replyTextView becomeFirstResponder];
    }
}


#pragma mark TextViewDelegate

-(void)textViewDidEndEditing:(UITextView *)textView
{
    if(_replyTextView.text.length == 0){
        
        _replyTextView.textColor =  RGBCOLOR(204, 204, 204);;
        
        _replyTextView.text = @"回复该条咨询信息";
        
        isEmpty = YES;
        
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView*)textView
{
    if (isEmpty)
    {
        _replyTextView.text = @"";
        
        _replyTextView.textColor =  RGBCOLOR(34, 34, 34);;
        
        isEmpty = NO;
        
    }
    
    return YES;
}


- (void)textViewDidChange:(UITextView *)_textView
{
    _sendBtn.enabled = YES;
    
    CGSize size = _replyTextView.contentSize;
    
    size.height -= 2;
    
    if ( size.height >= 60 )
    {
        size.height = 60;
    }
    else if ( size.height <= 30 )
    {
        size.height = 30;
    }
    
    [_replyTextView scrollRangeToVisible:NSMakeRange(_replyTextView.text.length - 1, 1)];
    
    if ( size.height != _replyTextView.frame.size.height )
    {
        CGFloat span = size.height - _replyTextView.frame.size.height;
        
        CGRect frame = _tooBarView.frame;
        frame.origin.y -= span;
        frame.size.height += span;
        _tooBarView.frame = frame;
        
        CGFloat centerY = frame.size.height / 2;
        
        frame = _replyTextView.frame;
        frame.size = size;
        _replyTextView.frame = frame;
        
        CGPoint center = _replyTextView.center;
        center.y = centerY;
        _replyTextView.center = center;
        
        center = _sendBtn.center;
        center.y = centerY;
        _sendBtn.center = center;
        
        _lineView.frame = CGRectMake(0, 0, 320, 0.5);
    }
}


#pragma mark TableView

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!_cell) _cell = STRONG_OBJECT(ConsultTationDetailTableViewCell, init);
    
    NSString * content = [[contentArray[indexPath.row] wrapper]getString:@"Content"];
    
    return [_cell getCellHeight:content];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [contentArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ConsultTationDetailTableViewCell";
    
    ConsultTationDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ConsultTationDetailTableViewCell" owner:nil options:nil].lastObject;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.layer.masksToBounds = YES;
    }
    
    cell.textLabel.text = [[contentArray[indexPath.row] wrapper]getString:@"Content"];
    
    //获取时间
    NSString * time = [[contentArray[indexPath.row] wrapper]getString:@"CounselTime"];
    
    NSDate *today = [NSDate date];
    
    NSDate *yesterday =[NSDate dateWithTimeIntervalSinceNow:-(24*60*60)];
    
    NSDateFormatter *formatter = [[NSDateFormatter  alloc]  init];
    
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *todayTime = [formatter stringFromDate:today];
    
    NSString *yesterdayTime = [formatter stringFromDate:yesterday];
    
    NSString * celldodaytime = [UICommon formatDate:time];
    
    if ([celldodaytime isEqualToString:todayTime])
    {
        time = [NSString stringWithFormat:@"今天%@",[UICommon formatDate:time withRange:NSMakeRange(11, 5)]];
    }
    else if ([celldodaytime isEqualToString:yesterdayTime])
    {
        time = [NSString stringWithFormat:@"昨天%@",[UICommon formatDate:time withRange:NSMakeRange(11, 5)]];
    }
    else
    {
        time = [UICommon formatTime:time];
    }
    [formatter release];
    
    cell.textLabel.hidden = YES;
    
    //判断左右
    BubbleCellType s;
    
    if ([[[contentArray[indexPath.row] wrapper]getString:@"Type"] isEqualToString:@"0"])
    {
        s = BubbleCellTypeLeft;
        
        [cell layoutTheViewBubbleWithImage:[UIImage imageNamed:@"qipaoleft.png"] type:s time:time];
    }
    else
    {
        s = BubbleCellTypeRight;
        
        [cell layoutTheViewBubbleWithImage:[UIImage imageNamed:@"qipaoright.png"] type:s time:time];
    }
         
    
    return cell;
}

- (IBAction)comefromBtn:(id)sender
{
    NSLog(@"----dic----%@",dic);

    if ([dic getInt:@"Type"] == 1)
    {
        //银元广告
        if ([dic getInt:@"AdvertId"] != 0)
        {
            PUSH_VIEWCONTROLLER(AdsDetailViewController);
            model.adId = [NSString stringWithFormat:@"%d",[dic getInt:@"AdvertId"]];
            model.comeformCounsel = 1;
            model.notShow = NO;
            model.isMerchant = YES;
        }
    }
    else if ([dic getInt:@"Type"] == 2)
    {
        //直投广告
        if ([dic getInt:@"AdvertId"] != 0)
        {
            PUSH_VIEWCONTROLLER(OpenRedPacketViewController);
            model.adsId = [dic getInt:@"AdvertId"];
            model.comeformCounsel = 1;
        }
    }
    else if ([dic getInt:@"Type"] == 3)
    {
        //竞价Banner广告
        if ([dic getInt:@"AdvertId"] != 0 && [dic getInt:@"BiddingId"] != 0)
        {
            PUSH_VIEWCONTROLLER(DetailBannerAdvertViewController);
            model.adId = [NSString stringWithFormat:@"%d",[dic getInt:@"BiddingId"]];
            model.comeformCounsel = 1;
        }
    }
    else if ([dic getInt:@"Type"] == 4)
    {
        //银元商品
        if ([dic getInt:@"ProductId"] != 0)
        {
            PUSH_VIEWCONTROLLER(CRSliverDetailViewController);
            model.advertId = [dic getInt:@"AdvertId"];
            model.productId = [dic getInt:@"ProductId"];
            model.comeformCounsel = 1;
        }
    }
    else if ([dic getInt:@"Type"] == 5)
    {
        //金币商品
        if ([dic getInt:@"ProductId"] != 0)
        {
            PUSH_VIEWCONTROLLER(Preview_Commodity);
            model.whereFrom = 0;
            model.productId = [dic getInt:@"ProductId"];
            model.comeformCounsel = 1;
        }
    }
    else if ([dic getInt:@"Type"] == 6)
    {
        //直购商品
    }
}

- (IBAction)touchuUpInsideBtn:(id)sender
{
    if (sender == _sendBtn)
    {
        if ([_replyTextView.text isEqualToString:@""] || [_replyTextView.text isEqualToString:@"回复该条咨询信息"])
        {
            [HUDUtil showErrorWithStatus:@"请输入回复咨询内容"];
            return;
        }
        else
        {
            ADAPI_adv3_ReplyCounsel([self genDelegatorID:@selector(HandleNotification:)], _consultId, _replyTextView.text);
        }
    }
    else if (sender == _tableViewBtn)
    {
        [_replyTextView resignFirstResponder];
        
        _tableViewBtn.hidden = YES;
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_replyTextView resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)dealloc
{
    [dic release];
    
    dic = nil;
    
    [contentArray release];
    
    contentArray = nil;
    
    [_cell release];
    [_tooBarView release];
    [_replyTextView release];
    [_sendBtn release];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    
    [_mainTableVIew release];
    [_tableViewBtn release];
    [_headerView release];
    [_touxiangImage release];
    [_phoneLable release];
    [_vipImage release];
    [_qqLable release];
    [_otherPhoneLable release];
    [_emailLable release];
    [_lineView release];
    [_comeFromLable release];
    [_comefromBtns release];
    [_topline release];
    [super dealloc];
}

- (void)viewDidUnload
{
    [self setTooBarView:nil];
    [self setReplyTextView:nil];
    [self setSendBtn:nil];
    [self setMainTableVIew:nil];
    [self setTableViewBtn:nil];
    [self setHeaderView:nil];
    [self setTouxiangImage:nil];
    [self setPhoneLable:nil];
    [self setVipImage:nil];
    [self setQqLable:nil];
    [self setOtherPhoneLable:nil];
    [self setEmailLable:nil];
    [super viewDidUnload];
}

@end
