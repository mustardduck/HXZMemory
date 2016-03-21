//
//  UICommon.h
//  miaozhuan
//
//  Created by abyss on 14/10/24.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonTextField.h"
#import <UIKit/UIKit.h>
#import "CSBImagePickerController.h"
//#import "NSDictionary+expanded.h"

//有要用到的慢慢往里面加 O.O～
//快速宏引索 ---------------------------------------------

/** 1.导航栏:InitNav */
//返回按钮 + Navtitle的设置
//回调selecter : - (IBAction)onMoveBack:(UIButton*) sender;
//              - (IBAction)onMoveFoward:(UIButton*) sender;
#define InitNav(title)\
[UICommon initNav:(title) viewCon:self]

/** 2.颜色:AppColor */
//获取常用的颜色

#define AppColorWhite           [UIColor whiteColor]
#define AppColorBackground      RGBACOLOR(239, 239, 244, 1)
#define AppColorRed             RGBACOLOR(240, 5, 0, 1)
#define AppColorBlack43         AppColor(34)
#define AppColorGray153         AppColor(153)
#define AppColorLightGray204    AppColor(204)

#define AppColor(num)\
RGBACOLOR(num, num, num, 1)

/** 3.PUSH_VIEWCONTROLLER */
//viewController的PUSH
#define PUSH_VIEWCONTROLLER(viewController) \
viewController *model = WEAK_OBJECT(viewController, init); \
[CRHttpAddedManager mz_pushViewController:model];

/** 4.高度计算 */
#define AppGetTextHeight(Label) \
([UICommon getHeightFromLabel:(Label)].height + (Label).top)
#define AppGetTextWidth(Label) \
([UICommon getWidthFromLabel:(Label)].width + (Label).left)

//----------------------------------------------------

//ToDo警告
#define STRINGIFY(S) #S
#define DEFER_STRINGIFY(S) STRINGIFY(S)
#define PRAGMA_MESSAGE(MSG) _Pragma(STRINGIFY(message(MSG)))
#define FORMATTED_MESSAGE(MSG) "[TODO-" DEFER_STRINGIFY(__COUNTER__) "] " MSG " \n" \
DEFER_STRINGIFY(__FILE__) " line " DEFER_STRINGIFY(__LINE__)
#define KEYWORDIFY try {} @catch (...) {}
#define TODO(MSG) KEYWORDIFY PRAGMA_MESSAGE(FORMATTED_MESSAGE(MSG))

typedef enum
{
    AllType = 0,
    DraftType,
    ProceedingType,
    AuditFailedType,
    SuccessType    
}QueryType;

typedef enum
{
    DraftADType = 0,
    PlayingADType,
    ReadToPlayADType,
    ProceedingADType,
    AuditFailedADType,
    PlayedADType
    
}QueryADsType;

//入口页面的类型-》设置支付密码
typedef enum
{
    ZhifuPWD_Gold = 1,              //金币流通
    ZhifuPWD_Silver,                //银元流通
    ZhifuPWD_YiHuoMallBuy,          //易货商城购买
    ZhifuPWD_MyOrderShouHuo,        //我的订单-确认收货
    ZhifuPWD_ReturnShouHuo          //退货售后-确认收货
}ZhifuPWD_Type;

//0.发广告消耗的，1.兑换商品消耗的，2.竞价广告消耗的，3.系统赠送的，4.易货商城的货款 5.流通记录 6.其它收入 7.发商家优惠信息消耗的 8.发招聘信息消耗的 9.发招商信息消耗的 10.拓展商家消耗的 11.购买广告金币获得的 12.我的现金其他收支
typedef enum
{
    AdvertConsume = 0,
    DuihuanProdConsume,
    JingjiaADsConsume,
    systemBonus,
    GoldMarketMoney,
    LiutongRecord,
    OtherIncome,
    DiscountGoldConsume,
    RecruitmentGoldConsume,
    InvestmentGoldConsume,
    ExploitGoldConsume,
    GetBuyAdvertGold,
    QT_MONEY
}MyGoldType;

//13.兑换获得的 14.易货消耗的 15.易货商城货款
typedef enum
{
    DHHD_YHM = 13,
    YHXH_YHM,
    YHHK_YHM,
    QT_YHM,
    
}MyYHMType;


typedef void (^keyboardBlock) ();

@interface UICommon : NSObject

+ (id)shareInstance;

+ (void)initNav:(NSString *)title viewCon:(UIViewController *)viewCon;

+ (NSString *)formatUrl:(NSString *)url;

+ (CGFloat)getIos4OffsetY;  //系统高度

+ (CGSize)getSizeFromString:(NSString *)str withSize:(CGSize)cSize withFont:(CGFloat)fontsize;

+ (CGSize)getHeightFromLabel:(UILabel *)label;
+ (CGSize)getWidthFromLabel:(UILabel *)label;
+ (CGSize)getWidthFromLabel:(UILabel *)label withMaxWidth:(CGFloat)maxWidth;

//+ (CGSize)getSizeFromString:(NSString *)str withWidth:(CGFloat)width withFont:(CGFloat)fontsize;//高度计算

- (void)makeCall:(NSString *)phoneNumber;//拨打电话

+ (NSString *)hidePhoneText:(NSString *)text;

+ (void)makePhoneCall:(NSString *)phoneNum;

+ (NSString *)doCipher:(NSString *)sTextIn;

+ (void) showImagePicker:(id)delegate view:(UIViewController*)controller;

+ (void) showCamera:(id)delegate view:(UIViewController*) controller allowsEditing:(BOOL)allow;

+ (NSDate *)dateFromString:(NSString *)dateString;
+ (NSDate *)dateShortFromString:(NSString *)dateString;
+ (NSString*) format19Time:(NSString*)input;
+ (NSString*) formatTime:(NSString*)input;
+ (NSString*) formatDate:(NSString*)input withRange:(NSRange)range;
+ (NSString*) formatDate:(NSString*)input;

+ (NSString *) usaulFormatTime:(NSDate *)date formatStyle:(NSString *)format;
+ (NSDate *) usaulFormatDate:(NSString *) text formatStyle:(NSString *) format;
+ (NSString *)countWithFromDate:(NSString *)fromDate toDate:(NSString *)toDate;
+ (NSUInteger)unicodeLengthOfString:(NSString *)text;
- (void)addDoneToKeyboard:(UIView *)activeView block:(keyboardBlock)block;
+ (UIImage *)imageByApplyingAlpha:(CGFloat)alpha  image:(UIImage*)image;

/**
 * 保留后小数点后两位小数
 *
 * numStr 需要处理的字符串
 * appendStr 处理后需要追加的字符串，可为nil
 */
+ (NSString *)getStringToTwoDigitsAfterDecimalPlacesPoint:(NSString *)numStr
                                            withAppendStr:(NSString *)appendStr;

+ (NSString *)getStringToTwoDigitsAfterDecimalPointPlaces:(double)num
                                            withAppendStr:(NSString *)appendStr;

/**
 * 取整
 *
 * numStr 需要处理的字符串
 * appendStr 处理后需要追加的字符串，可为nil
 */

+ (NSString *)getStringFromDecimalPlacesPoint:(NSString *)num
                                withAppendStr:(NSString *)appendStr;
//限制textfield小数点后面位数
//remain 位数
+ (BOOL) validDecimalPoint:(UITextField*)textField withRange:(NSRange)range replacementString:(NSString *)string andRemain:(short)remain;


//16进制数－>Byte数组
+ (NSData *) getByte : (NSString *) hexString;

+ (UIImage*)OriginImage:(UIImage *)image size:(CGSize)size;

+ (UIViewController *)getOldViewController:(Class)viewCon;
+ (void)popOldViewController:(Class)viewCon;

//获取系统设备号
+(float)getSystemVersion;

@end

@interface DelegatorArguments (Addition)

@property (retain, nonatomic , readonly) NSString *operation;
@property (retain, nonatomic , readonly) NSString *error;
@property (retain, nonatomic , readonly) DictionaryWrapper *ret;

//操作码比较
- (BOOL)isEqualToOperation:(NSString *)operation;
//打印http错误信息
- (void)logError;

@end

//@interface DictionaryWrapper (Addition)
////DictionaryWrapper+Net
//@end


#pragma mark - UILabel
@interface UILabel (expanded)

- (void)setupLabelFrameWithString:(NSString*)string andFont:(float)fontSize andWidth:(float)width;
@end

#pragma mark - UIViewController 

@interface UIViewController (expanded)

//NavUI
- (void)setupMoveBackButton;
- (void)setupMoveBackButtonWithTitle:(NSString *)str;
- (void)setupMoveFowardButtonWithTitle:(NSString*) title;
- (void)setupMoveBackButtonWithTitles:(NSArray *)titles;
- (void)setNavigateTitle:(NSString*) title;
- (void)setupMoveFowardButtonWithImage:(NSString *)imageName In : (NSString *)imageIn;
- (void)setupMoveForwardButtonWithImage:(NSString*)imageName In: (NSString *)imageIn andUnreadCount:(int)count;

//NavAction
- (IBAction)onClicked:(UIButton *)sender;
- (IBAction)onMoveBack:(UIButton*) sender;
- (IBAction)onMoveFoward:(UIButton*) sender;

//KeyboardUI
- (void)addDoneToKeyboard:(UIView *)activeView;//对键盘添加“完成”按钮
- (void)hiddenKeyboard;
@end





#pragma mark - UIView

CGPoint CGRectGetCenter(CGRect rect);
CGRect  CGRectMoveToCenter(CGRect rect, CGPoint center);

@interface UIView (RCMethod)

@property CGPoint origin;
@property CGSize size;

@property (readonly) CGPoint bottomLeft;
@property (readonly) CGPoint bottomRight;
@property (readonly) CGPoint topRight;

@property CGFloat height;
@property CGFloat width;

@property CGFloat top;
@property CGFloat left;

@property CGFloat bottom;
@property CGFloat right;

/** 轻微圆角 */
- (void)setRoundCorner;

- (void)setRoundCorner:(float)cornerRadius;

- (void)setRoundCorner:(float)cornerRadius withBorderColor:(UIColor *) color;


/** 圆 */
- (void)setRoundCornerAll;
/** 旋转 */
- (void)setAnimateRotation;
/** 边界 */
- (void)setBorderWithColor:(UIColor *)color;

/** 移动 */
- (void)moveBy: (CGPoint) delta;
/** 缩小 */
- (void)scaleBy: (CGFloat) scaleFactor;
/** 适应缩小 */
- (void)fitInSize: (CGSize) aSize;
/** 居中 */
- (void)centerToParent;

- (void)addSubviews:(UIView *)view,...NS_REQUIRES_NIL_TERMINATION;
- (void)removeAllSubviews;

-(BOOL)containsSubView:(UIView *)subView;
-(BOOL)containsSubViewOfClassType:(Class)pClass;

//块
- (void)setTapActionWithBlock:(void (^)(void))block;
- (void)setLongPressActionWithBlock:(void (^)(void))block;


@end

@interface NSTimer (Addition)

- (void)pauseTimer;
- (void)resumeTimer;
- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval;

@end

@interface NSString (Addition)

+ (NSString *)getFromInteger:(NSInteger)num;

@end

typedef void (^whileTimerBlock) (int sec,UIButton *button);
typedef void (^doneTimerBlock) (int sec,UIButton *button);

@interface UIButton (Addition)

//直接用tag作为传递参数了...请不要设置button.tag!
- (void)addTimer:(NSInteger)secounds;
- (void)startTimer;
- (void)addBorder;
//需要么？
- (void)addTimerWithTitle:(NSInteger)secounds title:(NSString *)title endTitle:(NSString *)endTitle;
- (void)addTimerWithBlock:(NSInteger)secounds whileBlock:(whileTimerBlock)whileBlock doneBlock:(doneTimerBlock)doneTimerBlock;

@end

@interface UIColor (Addition)

//红色字

+ (UIColor *) titleRedColor;
+ (UIColor *) titleBlackColor;

//图片灰色边框
+ (UIColor *) borderPicGreyColor;

@end

@interface UIImage (Addition)

- (UIImage *)compressedImage;  //压缩图片大小,图片上传大小限制
- (UIImage *)scaleToSize:(CGSize)size;  //图片缩放到指定大小尺寸

@end

@interface ServerRequestOption (Addition)
- (void)description;
@end


//
#define CRDEBUG_DEALLOC() NSLog(@"%@ delloc",[self class])
#define BOOLREAL(_bool) ((_bool)?@"true":@"false")

#define CRMJRefreshFast_Done(_block) \
{\
MJRefreshOnRequestDone block = MJREFRESH_ON_REQUEST_DONE\
{\
NSLog(@"%@",netData);\
_block\
};\
[_MJRefreshCon setOnRequestDone:block];\
[_MJRefreshCon setPageSize:50];\
[_MJRefreshCon retain];\
}\

#define CRMJRefreshFast_Init(_refreshName,_inController)\
NSString * refreshName = _refreshName;\
_MJRefreshCon = [MJRefreshController controllerFrom:_tableView name:refreshName];\
__block _inController *weakself = self

#define CRMJRefreshFast_Request(_dosomething)\
[_MJRefreshCon setURLGenerator:MJREFRESH_URL_GENERATOR_BLOCK\
{\
_dosomething\
}]

#define CRMJRefreshFastViewControllerImplementation(_className, _cellName)\
@implementation _className\
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section\
{\
return _MJRefreshCon.refreshCount;\
}\
\
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath\
{\
return _cellHeight;\
}\
\
- (void)refreshTableView { [_MJRefreshCon refreshWithLoading];}\
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath\
{\
NSString *CellIdentifier = NSStringFromClass([_cellName class]);\
_cellName *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];\
if (cell == nil)\
{\
cell = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:nil options:nil].lastObject;\
cell.selectionStyle = UITableViewCellSelectionStyleNone;\
}\
[self layoutCell:cell at:indexPath];\
return cell;\
}\


