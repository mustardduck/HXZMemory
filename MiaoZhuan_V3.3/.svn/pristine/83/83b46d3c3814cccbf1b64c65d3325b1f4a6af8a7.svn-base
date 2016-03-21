//
//  UICommon.m
//  miaozhuan
//
//  Created by abyss on 14/10/24.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "UICommon.h"
#import <objc/runtime.h>
#import "otherButton.h"
#import "des.h"
#import "RedPoint.h"

NSURL *phoneNumberUrl;

@implementation UICommon: NSObject
{
    keyboardBlock _block;
}
static UICommon *_uicommoninstance=nil;
static dispatch_once_t utility;

//陈－－获取sigs
+ (NSString *)doCipher:(NSString *)srcData
{
    const int BUFFER_SIZE = 1024;
    static char s_buffer[BUFFER_SIZE] = {0};
    
    const char* szSrc = [srcData cStringUsingEncoding:NSUTF8StringEncoding];
    NSStringEncoding dstEncode = NSUTF8StringEncoding;
    
    int count = DesEncrypt((const unsigned char*)szSrc, s_buffer);
    assert(count < BUFFER_SIZE);
    s_buffer[count] = 0;
    
    return [NSString stringWithFormat:@"%@%@", @"67", [NSString stringWithCString:s_buffer encoding:dstEncode]];
}


int DesEncrypt(const unsigned char* data, char* returnBuffer)
{
    if(data == NULL)
    {
        return 0;
    }
    int len = strlen((char*)data);
    U8 key[8] = {55,52,53,56,57,54,51,50};
    U8 text[8] = {0};
    U8 mtext[8] = {0};
    int bshu = len/8;
    int i,yshu;
    int totalLen = 0;
    for(i=0;i<=bshu;i++)
    {
        yshu = len - i*8 ;
        int count = 0;
        if(yshu<=0)
        {
            break;
        }
        else if(yshu>=8)
        {
            count = 8;
        }
        else
        {
            count = yshu;
        }
        memset(text,0,sizeof(U8) * 8);//把所有数据清零
        memcpy(text,&data[i*8],count);
        DES(key,text,mtext);
        int j = 0;
        for(j=0;j<sizeof(mtext);j++)
        {
            sprintf((char*)&(returnBuffer[totalLen]),"%.2X",mtext[j]);
            totalLen += 2;
        }
    }
    return totalLen;
}


// 十六进制转换为普通字符串的。
+ (NSString *)stringFromHexString:(NSString *)hexString { //
    
    char *myBuffer = (char *)malloc((int)[hexString length] / 2 + 1);
    bzero(myBuffer, [hexString length] / 2 + 1);
    for (int i = 0; i < [hexString length] - 1; i += 2) {
        unsigned int anInt;
        NSString * hexCharStr = [hexString substringWithRange:NSMakeRange(i, 2)];
        NSScanner * scanner = [[[NSScanner alloc] initWithString:hexCharStr] autorelease];
        [scanner scanHexInt:&anInt];
        myBuffer[i / 2] = (char)anInt;
    }
    NSString *unicodeString = [NSString stringWithCString:myBuffer encoding:4];
    NSLog(@"------字符串=======%@",unicodeString);
    return unicodeString;
}

//16进制数－>Byte数组
+ (NSData *) getByte : (NSString *) hexString
{
    ///// 将16进制数据转化成Byte 数组
    //    hexString = @"3e435fab9c34891f"; //16进制字符串
    int j=0;
    Byte bytes[128];  ///3ds key的Byte 数组， 128位
    for(int i=0;i<[hexString length];i++)
    {
        int int_ch;  /// 两位16进制数转化后的10进制数
        
        unichar hex_char1 = [hexString characterAtIndex:i]; ////两位16进制数中的第一位(高位*16)
        int int_ch1;
        if(hex_char1 >= '0' && hex_char1 <='9')
            int_ch1 = (hex_char1-48)*16;   //// 0 的Ascll - 48
        else if(hex_char1 >= 'A' && hex_char1 <='F')
            int_ch1 = (hex_char1-55)*16; //// A 的Ascll - 65
        else
            int_ch1 = (hex_char1-87)*16; //// a 的Ascll - 97
        i++;
        
        unichar hex_char2 = [hexString characterAtIndex:i]; ///两位16进制数中的第二位(低位)
        int int_ch2;
        if(hex_char2 >= '0' && hex_char2 <='9')
            int_ch2 = (hex_char2-48); //// 0 的Ascll - 48
        else if(hex_char1 >= 'A' && hex_char1 <='F')
            int_ch2 = hex_char2-55; //// A 的Ascll - 65
        else
            int_ch2 = hex_char2-87; //// a 的Ascll - 97
        
        int_ch = int_ch1+int_ch2;
        NSLog(@"int_ch=%d",int_ch);
        bytes[j] = int_ch;  ///将转化后的数放入Byte数组里
        j++;
    }
    NSData *newData = [[NSData alloc] initWithBytes:bytes length:128];
    NSString *string = [[NSString alloc] initWithBytes:bytes  length:8 encoding:NSUTF8StringEncoding];
    NSLog(@"newData=%@",newData);
    
    
    return newData;
}

+ (BOOL) validDecimalPoint:(UITextField*)textField withRange:(NSRange)range replacementString:(NSString *)string andRemain:(short)remain
{
    NSScanner      *scanner    = [NSScanner scannerWithString:string];
    NSCharacterSet *numbers;
    NSRange         pointRange = [textField.text rangeOfString:@"."];
    
    if ( (pointRange.length > 0) && (pointRange.location < range.location  || pointRange.location > range.location + range.length) )
    {
        numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    }
    else
    {
        numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
    }
    
    if ( [textField.text isEqualToString:@""] && [string isEqualToString:@"."] )
    {
        return NO;
    }
    
    //    short remain = 1; //默认保留1位小数
    
    NSString *tempStr = [textField.text stringByAppendingString:string];
    NSUInteger strlen = [tempStr length];
    if(pointRange.length > 0 && pointRange.location > 0){ //判断输入框内是否含有“.”。
        if([string isEqualToString:@"."]){ //当输入框内已经含有“.”时，如果再输入“.”则被视为无效。
            return NO;
        }
        if(strlen > 0 && (strlen - pointRange.location) > remain+1){ //当输入框内已经含有“.”，当字符串长度减去小数点前面的字符串长度大于需要要保留的小数点位数，则视当次输入无效。
            return NO;
        }
    }
    
    NSRange zeroRange = [textField.text rangeOfString:@"0"];
    if(zeroRange.length == 1 && zeroRange.location == 0){ //判断输入框第一个字符是否为“0”
        if(![string isEqualToString:@"0"] && ![string isEqualToString:@"."] && [textField.text length] == 1){ //当输入框只有一个字符并且字符为“0”时，再输入不为“0”或者“.”的字符时，则将此输入替换输入框的这唯一字符。
            textField.text = string;
            return NO;
        }else{
            if(pointRange.length == 0 && pointRange.location > 0){ //当输入框第一个字符为“0”时，并且没有“.”字符时，如果当此输入的字符为“0”，则视当此输入无效。
                if([string isEqualToString:@"0"]){
                    return NO;
                }
            }
        }
    }
    
    NSString *buffer;
    if ( ![scanner scanCharactersFromSet:numbers intoString:&buffer] && ([string length] != 0) )
    {
        return NO;
    }
    
    return YES;
}

- (void) addDoneToKeyboard:(UIView *)activeView block:(keyboardBlock)block
{
    //定义完成按钮
    UIToolbar * topView = WEAK_OBJECT(UIToolbar, initWithFrame:CGRectMake(0, 0, 320, 30));
    [topView setBarStyle:UIBarStyleBlack];
    
    if ([[[UIDevice currentDevice] systemVersion] intValue] < 7)
    {
        [topView setTintColor:RGBCOLOR(174, 178, 185)];
    }
    else
    {
        [topView setBarTintColor:RGBCOLOR(174, 178, 185)];
    }
    
    UIBarButtonItem * button1 = WEAK_OBJECT(UIBarButtonItem, initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil);
    
    UIBarButtonItem * button2 = WEAK_OBJECT(UIBarButtonItem, initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil);
    
    UIBarButtonItem * doneButton = WEAK_OBJECT(UIBarButtonItem, initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(hiddenKeyboard));
    
    doneButton.tintColor = RGBCOLOR(85, 85, 85);
    
    NSArray * buttonsArray = [NSArray arrayWithObjects:button1,button2,doneButton,nil];
    
    [topView setItems:buttonsArray];
    
    if([activeView isKindOfClass:[UITextField class]])
    {
        UITextField * text = (UITextField *)activeView;
        
        [text setInputAccessoryView:topView];
        
    }
    else
    {
        UITextView * textView = (UITextView *)activeView;
        
        [textView setInputAccessoryView:topView];
    }
    
    _block = nil;
    _block = [block copy];
}

- (void) hiddenKeyboard
{
    _block();
}

+ (id)shareInstance
{
    dispatch_once(&utility, ^ {
        _uicommoninstance = [[UICommon alloc] init];
    });
    return _uicommoninstance;
}

+ (void)initNav:(NSString *)title viewCon:(UIViewController *)viewCon
{
    [viewCon setNavigateTitle:title];
    [viewCon setupMoveBackButton];
}

+ (NSString *)formatUrl:(NSString *)url
{
    if (!url.length) {
        return @"";
    }
    if ([[url lowercaseString] hasPrefix:@"http://"]) {
        return url;
    } else {
        return [NSString stringWithFormat:@"http://%@", url];
    }
}

+ (CGFloat)getIos4OffsetY
{
    
    CGRect apprect = [[UIScreen mainScreen] bounds];
    
    return apprect.size.height - 480;
}

+ (CGSize) getSizeFromString:(NSString *)str withSize:(CGSize)cSize withFont:(CGFloat)fontsize
{
    CGSize size = CGSizeZero;
    
    if([UICommon getSystemVersion] >= 7.0)
    {
        NSMutableParagraphStyle *paragraphStyle = WEAK_OBJECT(NSMutableParagraphStyle, init);
        
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        
        NSDictionary *attributes = [[NSDictionary alloc] initWithObjectsAndKeys:Font(fontsize),NSFontAttributeName,[NSParagraphStyle defaultParagraphStyle],NSParagraphStyleAttributeName, nil];
        
        size = [str boundingRectWithSize:cSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        
        
        [attributes release];
        
        size.height = ceil(size.height);
        
        size.width = ceil(size.width);
    }
    else
    {
        size = [str sizeWithFont:Font(fontsize) constrainedToSize:cSize lineBreakMode:NSLineBreakByWordWrapping];
    }
    
    return size;
}

+ (CGSize)getHeightFromLabel:(UILabel *)label
{
    NSDictionary *attribute = @{NSFontAttributeName: label.font};
    
    CGSize retSize = CGSizeZero;

    if([UICommon getSystemVersion] >= 7.0)
    {
        retSize = [label.text boundingRectWithSize:CGSizeMake(label.width, MAXFLOAT)
                   
                                                  options:\
                          
                          NSStringDrawingTruncatesLastVisibleLine |
                          
                          NSStringDrawingUsesLineFragmentOrigin |
                          
                          NSStringDrawingUsesFontLeading
                          
                                               attributes:attribute
                          
                                                  context:nil].size;
    }
    else
        retSize = [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(label.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    
    
    CGFloat ret = (label.height - retSize.height)/2;
    retSize.height += ret;
    return retSize;
}

+ (CGSize)getWidthFromLabel:(UILabel *)label
{
    CGSize size = [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(MAXFLOAT, label.height)];
    if (size.width > 320) size.width -= 320;
    return size;
}

+ (CGSize)getWidthFromLabel:(UILabel *)label withMaxWidth:(CGFloat)maxWidth
{
    CGSize size = [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(maxWidth, label.height)];
    
    return size;
}

+ (UIViewController *)getOldViewController:(Class)viewCon
{
    id ret = nil;
    NSArray *array = UI_MANAGER.mainNavigationController.viewControllers;
    
    if (!array && array.count == 0) return nil;
    
    for (id object in array)
    {
        if ([object isKindOfClass:[viewCon class]])
        {
            ret = object;
        }
    }
    UIViewController *popTarget = ret;
    return popTarget;
}

+ (void)popOldViewController:(Class)viewCon
{
    UIViewController *model =  [self getOldViewController:viewCon];
    if (model && [model isKindOfClass:[UIViewController class]])
        [UI_MANAGER.mainNavigationController popToViewController:model animated:YES];
}

+(float)getSystemVersion
{
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}

#pragma mark makeCall
- (NSString*) cleanPhoneNumber:(NSString*)phoneNumber
{
    return [[[[phoneNumber stringByReplacingOccurrencesOfString:@" " withString:@""]
              stringByReplacingOccurrencesOfString:@"-" withString:@""]
             stringByReplacingOccurrencesOfString:@"(" withString:@""]
            stringByReplacingOccurrencesOfString:@")" withString:@""];
}

- (void) makeCall:(NSString *)phoneNumber
{
    if (!phoneNumber||[phoneNumber isEqualToString:@""]) {
        
        UIAlertView *alert = WEAK_OBJECT(UIAlertView, initWithTitle:@"错误"
                                                            message:@"号码有误"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil);
        [alert show];
        return;
    }
    NSString* numberAfterClear = [self cleanPhoneNumber:phoneNumber];
    
   phoneNumberUrl = [[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", numberAfterClear]] retain];
    NSString *message = [NSString stringWithFormat:@"呼叫 %@" , phoneNumber];
    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@""
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:@"取消"
                                          otherButtonTitles:@"拨打",nil] autorelease];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
#if (TARGET_IPHONE_SIMULATOR)
    
    // 在模拟器的情况下
    
#else
    // 在真机情况下
    if (buttonIndex == 1) {
        if ([[UIApplication sharedApplication] canOpenURL:phoneNumberUrl]) {
            [[UIApplication sharedApplication] openURL:phoneNumberUrl];
        }
    }
    
#endif

}

+ (NSString *)hidePhoneText:(NSString *)text
{
    if(text.length >= 11)
    {
        text = [text stringByReplacingCharactersInRange:(NSMakeRange(3, text.length - 7)) withString:@"****"];
    }
    return text;
}

+ (void)makePhoneCall:(NSString *)phoneNum
{
    NSString *deviceType = [UIDevice currentDevice].model;
    
    if([deviceType  isEqualToString:@"iPod touch"]||[deviceType  isEqualToString:@"iPad"]||[deviceType  isEqualToString:@"iPhone Simulator"])
    {
        [HUDUtil showErrorWithStatus:@"此设备没有打电话功能"];
    }
    else
    {
        if(phoneNum.length == 0)
        {
            [HUDUtil showErrorWithStatus:@"该联系人号码为空"];
        }
        else
        {
            NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phoneNum]];
            UIWebView *phoneCallWebView = [[[UIWebView alloc] initWithFrame:CGRectZero] autorelease];
            [phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
        }
    }
}

+ (void) showImagePicker:(id)delegate view:(UIViewController*)controller
{
    UIImagePickerController *picker = [CSBImagePickerController controllerFrom:delegate csbStyle:UIStatusBarStyleLightContent];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [controller presentModalViewController:picker animated:YES];
}

+ (void) showCamera:(id)delegate view:(UIViewController*) controller allowsEditing:(BOOL)allow
{
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
    }
    UIImagePickerController *picker = [CSBImagePickerController controllerFrom:delegate csbStyle:UIStatusBarStyleLightContent];
    picker.allowsEditing = allow;
    picker.sourceType = sourceType;
    
    [controller presentModalViewController:picker animated:YES];
}

+ (NSDate *)dateShortFromString:(NSString *)dateString
{
    
    NSDateFormatter *dateFormatter = WEAK_OBJECT(NSDateFormatter, init);
    
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    NSDate *destDate= [dateFormatter dateFromString:dateString];
        
    return destDate;
}

+ (NSDate *)dateFromString:(NSString *)dateString
{
    
    NSDateFormatter *dateFormatter = WEAK_OBJECT(NSDateFormatter, init);
    
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    
    return destDate;
}

+ (NSString*) format19Time:(NSString*)input{
    
    if ([input length] == 0) {
        
        return @"";
    }
    
    NSString *text = [input stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    
    if ([text length] > 19) {
        
        text = [text substringToIndex:19];
    }
    
    return text;
}

+ (NSString*) formatTime:(NSString*)input{
    
    if ([input length] == 0) {
        
        return @"";
    }
    
    NSString *text = [input stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    
    if ([text length] > 16) {
        
        text = [text substringToIndex:16];
    }
    
    return text;
}

+ (NSString*) formatDate:(NSString*)input withRange:(NSRange)range
{
    if ([input length] == 0) {
        
        return @"";
    }
    
    NSString *text = [input stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    
    if ([text length] > range.length) {
        
        text = [text substringWithRange:range];
    }
    
    return text;
}

+ (NSString*) formatDate:(NSString*)input
{
    if ([input length] == 0) {
        
        return @"";
    }
    
    NSString *text = [input stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    
    if ([text length] > 10) {
        
        text = [text substringToIndex:10];
    }
    
    return text;
}

+ (NSString *) usaulFormatTime:(NSDate *)date formatStyle:(NSString *)format{
    NSDateFormatter *formatter = WEAK_OBJECT(NSDateFormatter, init);
    [formatter setDateFormat:format];
    return [formatter stringFromDate:date];
}

+ (NSDate *) usaulFormatDate:(NSString *) text formatStyle:(NSString *) format
{
    NSDateFormatter *formatter = WEAK_OBJECT(NSDateFormatter, init);
    [formatter setDateFormat:format];
    return [formatter dateFromString:text];
}

+ (NSString *)countWithFromDate:(NSString *)fromDate toDate:(NSString *)toDate
{
    if ([fromDate rangeOfString:@"T"].length) {
        fromDate = [self format19Time:fromDate];
    }
    if ([toDate rangeOfString:@"T"].length) {
        toDate = [self format19Time:toDate];
    }
    
    NSDateFormatter *date = WEAK_OBJECT(NSDateFormatter, init);
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *d1=[NSDate date];//[date dateFromString:fromDate];
    
    NSDate *d2=[date dateFromString:toDate];

    unsigned int unitFlag = NSDayCalendarUnit | NSHourCalendarUnit |NSMinuteCalendarUnit ;
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *gap = [cal components:unitFlag fromDate:d1 toDate:d2 options:0];//计算时间差
    
    return [NSString stringWithFormat:@"%ld天%ld小时%ld分", (long)[gap day],(long)[gap hour], (long)[gap minute]];
}

+ (NSUInteger)unicodeLengthOfString:(NSString *) text {
    NSUInteger asciiLength = 0;
    
    for (NSUInteger i = 0; i < text.length; i++) {
        
        
        unichar uc = [text characterAtIndex: i];
        
        asciiLength += isascii(uc) ? 1 : 2;
    }
    
    NSUInteger unicodeLength = asciiLength / 2;
    
    if(asciiLength % 2) {
        unicodeLength++;
    }
    
    return unicodeLength;
}

+ (UIImage*)OriginImage:(UIImage *)image size:(CGSize)size;
{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(CGSizeMake(size.width, size.height));
    // 绘制改变大小的图片
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}

+ (UIImage *)imageByApplyingAlpha:(CGFloat)alpha  image:(UIImage*)image

{
    
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
    
    
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGRect area = CGRectMake(0, 0, image.size.width, image.size.height);
    
    
    
    CGContextScaleCTM(ctx, 1, -1);
    
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    
    
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    
    
    
    CGContextSetAlpha(ctx, alpha);
    
    
    
    CGContextDrawImage(ctx, area, image.CGImage);
    
    
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    
    UIGraphicsEndImageContext();
    
    
    
    return newImage;
    
}


+ (NSString *)getStringToTwoDigitsAfterDecimalPlacesPoint:(NSString *)numStr withAppendStr:(NSString *)appendStr{
    if (!numStr.length) {
        return @"";
    }
    if (!appendStr.length) {
        appendStr = @"";
    }
    NSRange range = [numStr rangeOfString:@"."];
    if (range.length) {
        NSString *str = [numStr substringFromIndex:range.location];
        if (str.length > 2) {
            return [[numStr substringToIndex:range.location + 3] stringByAppendingString:appendStr];
        }
        return [NSString stringWithFormat:@"%@%@%@",[numStr substringToIndex:range.location + 2], @"0", appendStr];
    } else {
        return [NSString stringWithFormat:@"%@%@%@", numStr, @".00", appendStr];
    }
}

+ (NSString *)getStringToTwoDigitsAfterDecimalPointPlaces:(double)num
                                            withAppendStr:(NSString *)appendStr{
    NSString *numStr = [NSString stringWithFormat:@"%lf",num];
    return [UICommon getStringToTwoDigitsAfterDecimalPlacesPoint:numStr withAppendStr:appendStr];
}

+ (NSString *)getStringFromDecimalPlacesPoint:(NSString *)num withAppendStr:(NSString *)appendStr{
    
    //1. intvalue
    
    //2.
    if (!num.length) {
        return @"";
    }
    if (!appendStr.length) {
        appendStr = @"";
    }
    NSRange range = [num rangeOfString:@"."];
    if (range.length) {
        return [[num substringToIndex:range.location] stringByAppendingString:appendStr];
    }
    return [num stringByAppendingString:appendStr];
}


@end

@implementation DelegatorArguments (Addition)

- (NSString *)operation
{
    return [self getArgument:NET_ARGUMENT_OPERATION];
}

- (NSString *)error
{
    return [self getArgument:NET_ARGUMENT_ERROR];
}

- (DictionaryWrapper *)ret
{
    return [self getArgument:NET_ARGUMENT_RETOBJECT];
}

- (BOOL)isEqualToOperation:(NSString *)operation
{
    return [self.operation isEqualToString:operation];
}

- (void)logError
{
    if (self.error == nil)
    {
        NSLog(@"<No Error>");
        NSLog(@"<Result>\n%@",self.ret.dictionary);
    }
    else NSLog(@"<ERROR LOG>-------------\n%@\n--------------<END>",self.error);
}

@end


#pragma mark - UILabel

@implementation UILabel(expanded)

- (void)setupLabelFrameWithString:(NSString *)string andFont:(float)fontSize andWidth:(float)width {

    CGSize size = [string sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    [self setSize:size];
}
@end

#pragma mark - UIVIewController

enum
{   UTILTAG_BEGIN           = -10000,
    
    // Navigate button ids
    UTILTAG_BTN_MOVEBACK    = UTILTAG_BEGIN,
    UTILTAG_BTN_MOVEFOWARD
    
};

@implementation UIViewController (expanded)

- (void) setupMoveBackButton
{
    UIButton* btn = WEAK_OBJECT(UIButton, initWithFrame:CGRectMake( - 9, 5, 25, 34));
    btn.tag = UTILTAG_BTN_MOVEBACK;
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, - 15, 0, 0);
    [btn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"back_hover.png"] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(onMoveBack:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = WEAK_OBJECT(UIBarButtonItem, initWithCustomView:btn);
}

- (void) setupMoveBackButtonWithTitle:(NSString *)str
{
    UIButton* btn = WEAK_OBJECT(UIButton, initWithFrame:CGRectMake( 0, 5, 35, 18));
    btn.tag = UTILTAG_BTN_MOVEBACK;
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, - 15, 0, 0);
    [btn setTitle:str forState:UIControlStateNormal];
    btn.titleLabel.textAlignment =  NSTextAlignmentRight;
    btn.titleLabel.font = Font(16);
    [btn addTarget:self action:@selector(onMoveBack:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = WEAK_OBJECT(UIBarButtonItem, initWithCustomView:btn);
}

- (void)setupMoveBackButtonWithTitles:(NSArray *)titles
{
    int count = 1;
    NSMutableArray *items = WEAK_OBJECT(NSMutableArray, init);
    for (NSString *str in titles) {
        UIButton* btn = WEAK_OBJECT(UIButton, initWithFrame:CGRectMake( -9, 5, 48, 18));
        if ((count - 1)) {
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, -25, 0, 0);
        }
        btn.tag = count;
        [btn setTitle:str forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(onClicked:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *barButton = WEAK_OBJECT(UIBarButtonItem, initWithCustomView:btn);
        
        [items addObject:barButton];
        count ++;
    }
    self.navigationItem.leftBarButtonItems = items;
}

- (void)onClicked:(UIButton *)sender{

}

- (void) setupMoveFowardButtonWithTitle:(NSString*) title
{
    UIButton* btn;
    
    if([title isEqualToString:@" "])
    {
        btn = WEAK_OBJECT(UIButton, initWithFrame:CGRectMake( 0, 0, 100, 34));
    }
    else if([title length] > 2)
    {
        btn = WEAK_OBJECT(UIButton, initWithFrame:CGRectMake(0, 0, 70, 34));
        
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        btn.titleLabel.textAlignment =  NSTextAlignmentLeft;
    }
    else
    {
        btn = WEAK_OBJECT(UIButton, initWithFrame:CGRectMake(100, 0, 48, 34));
    }
    
    btn.tag = UTILTAG_BTN_MOVEFOWARD;
    btn.titleLabel.font = Font(16);
    [btn setTitle:title forState:UIControlStateNormal];
    
    [btn setTitleColor:AppColorWhite forState:UIControlStateNormal];
    [btn setTitleColor:RGBACOLOR(255, 255, 255, 0.5) forState:UIControlStateHighlighted];
    
    [btn addTarget:self action:@selector(onMoveFoward:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -10;
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, button];
    [negativeSpacer release];
    [button release];
}

- (void) hiddenKeyboard{}
- (void) addDoneToKeyboard:(UIView *)activeView
{
    //定义完成按钮
    UIToolbar * topView = WEAK_OBJECT(UIToolbar, initWithFrame:CGRectMake(0, 0, 320, 30));
    [topView setBarStyle:UIBarStyleBlack];
    if ([[[UIDevice currentDevice] systemVersion] intValue] < 7)
    {
        [topView setTintColor:RGBCOLOR(174, 178, 185)];
    }
    else
    {
        [topView setBarTintColor:RGBCOLOR(174, 178, 185)];
    }
    
    UIBarButtonItem * button1 = WEAK_OBJECT(UIBarButtonItem, initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil);
    
    UIBarButtonItem * button2 = WEAK_OBJECT(UIBarButtonItem, initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil);
    
    UIBarButtonItem * doneButton = WEAK_OBJECT(UIBarButtonItem, initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(hiddenKeyboard));
    
    doneButton.tintColor = RGBCOLOR(85, 85, 85);
    
    NSArray * buttonsArray = [NSArray arrayWithObjects:button1,button2,doneButton,nil];
    
    [topView setItems:buttonsArray];
    
    if([activeView isKindOfClass:[UITextField class]])
    {
        UITextField * text = (UITextField *)activeView;
        
        [text setInputAccessoryView:topView];
        
    }
    else
    {
        UITextView * textView = (UITextView *)activeView;
        
        [textView setInputAccessoryView:topView];
    }
}

- (void) setupMoveFowardButtonWithImage:(NSString *)imageName In : (NSString *)imageIn
{
    UIImage *image_1 = nil;
    UIImage *image_2 = nil;
    if (imageName && imageName.length > 1)
    {
        image_1 = [UIImage imageNamed:imageName];
    }
    if (imageIn && imageIn.length > 1)
    {
        image_2 = [UIImage imageNamed:imageIn];
    }
    if (!image_2 || [imageIn isEqualToString:imageName])
    {
        image_2 = [UICommon imageByApplyingAlpha:0.5 image:image_2];
    }
    
    CGSize size;
    if (image_1)
    {
        size.width = image_1.size.width;
        size.height = image_1.size.height;
        if (size.width > 35) size.width /= 2.f;
        if (size.height > 35) size.height /= 2.f;
    }
    else
    {
        size = CGSizeMake(24, 24);
    }
    UIButton* btn = WEAK_OBJECT(UIButton, initWithFrame:CGRectMake(0, 5, size.width, size.height));
    btn.tag = UTILTAG_BTN_MOVEFOWARD;
    [btn setImage:image_1 forState:UIControlStateNormal];
    [btn setImage:image_2 forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(onMoveFoward:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = WEAK_OBJECT(UIBarButtonItem, initWithCustomView:btn);
}

- (void)setupMoveForwardButtonWithImage:(NSString*)imageName In: (NSString *)imageIn andUnreadCount:(int)count{


    UIButton* btn = WEAK_OBJECT(UIButton, initWithFrame:CGRectMake(0, 5, 24, 24));
    btn.tag = UTILTAG_BTN_MOVEFOWARD;
    RedPoint *unReadMessage = STRONG_OBJECT(RedPoint, initWithFrame:CGRectMake(14, -5, 18, 18));
    [btn addSubview:unReadMessage];
    
    unReadMessage.otherImg = [UIImage imageNamed:@"littleYellowPoint.png"];
    unReadMessage.num = count;
    unReadMessage.bt.titleLabel.font = [UIFont systemFontOfSize:9];
    unReadMessage.bt.titleEdgeInsets = UIEdgeInsetsMake(1, 1, 0, 0);
    [unReadMessage.bt setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    if (count > 0) {
        
        unReadMessage.hidden = NO;
    }else {
    
        unReadMessage.hidden = YES;
    }
    

    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:imageIn] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(onMoveFoward:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = WEAK_OBJECT(UIBarButtonItem, initWithCustomView:btn);
}

- (void) setNavigateTitle:(NSString*) title
{
    self.navigationItem.title = title;
}

- (IBAction) onMoveBack:(UIButton*) sender
{
//    assert(sender.tag == UTILTAG_BTN_MOVEBACK);
    
    [self.navigationController popViewControllerAnimated:TRUE];
}

- (IBAction) onMoveFoward:(UIButton*) sender
{
//    assert(sender.tag == UTILTAG_BTN_MOVEFOWARD);
    
    assert(false && "Please re-write the method");
}




@end

#define SCREEN_SCALE ([[UIScreen mainScreen] scale])
#define PIXEL_INTEGRAL(pointValue) (round(pointValue * SCREEN_SCALE) / SCREEN_SCALE)

static char kRCActionHandlerTapBlockKey;
static char kRCActionHandlerTapGestureKey;
static char kRCActionHandlerLongPressBlockKey;
static char kRCActionHandlerLongPressGestureKey;
#pragma mark - UIView

CGPoint CGRectGetCenter(CGRect rect)
{
    CGPoint pt;
    pt.x = CGRectGetMidX(rect);
    pt.y = CGRectGetMidY(rect);
    return pt;
}

CGRect CGRectMoveToCenter(CGRect rect, CGPoint center)
{
    CGRect newrect = CGRectZero;
    newrect.origin.x = center.x-CGRectGetMidX(rect);
    newrect.origin.y = center.y-CGRectGetMidY(rect);
    newrect.size = rect.size;
    return newrect;
}

@implementation UIView (RCMethod)

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setOrigin: (CGPoint) aPoint
{
    CGRect newframe = self.frame;
    newframe.origin = aPoint;
    self.frame = newframe;
}


- (CGSize)size
{
    return self.frame.size;
}

- (void)setSize: (CGSize) aSize
{
    CGRect newframe = self.frame;
    newframe.size = aSize;
    self.frame = newframe;
}

- (CGPoint)bottomRight
{
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

- (CGPoint)bottomLeft
{
    CGFloat x = self.frame.origin.x;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

- (CGPoint)topRight
{
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y;
    return CGPointMake(x, y);
}


- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setHeight: (CGFloat) newheight
{
    CGRect newframe = self.frame;
    newframe.size.height = newheight;
    self.frame = newframe;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setWidth: (CGFloat) newwidth
{
    CGRect newframe = self.frame;
    newframe.size.width = newwidth;
    self.frame = newframe;
}

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)newtop
{
    CGRect newframe = self.frame;
    newframe.origin.y = newtop;
    self.frame = newframe;
}

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (void)setLeft: (CGFloat) newleft
{
    CGRect newframe = self.frame;
    newframe.origin.x = newleft;
    self.frame = newframe;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom: (CGFloat) newbottom
{
    CGRect newframe = self.frame;
    newframe.origin.y = newbottom - self.frame.size.height;
    self.frame = newframe;
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight: (CGFloat) newright
{
    CGFloat delta = newright - (self.frame.origin.x + self.frame.size.width);
    CGRect newframe = self.frame;
    newframe.origin.x += delta ;
    self.frame = newframe;
}

- (void)moveBy: (CGPoint) delta
{
    CGPoint newcenter = self.center;
    newcenter.x += delta.x;
    newcenter.y += delta.y;
    self.center = newcenter;
}

- (void)scaleBy: (CGFloat) scaleFactor
{
    CGRect newframe = self.frame;
    newframe.size.width *= scaleFactor;
    newframe.size.height *= scaleFactor;
    self.frame = newframe;
}

- (void)fitInSize: (CGSize) aSize
{
    CGFloat scale;
    CGRect newframe = self.frame;
    
    if (newframe.size.height && (newframe.size.height > aSize.height))
    {
        scale = aSize.height / newframe.size.height;
        newframe.size.width *= scale;
        newframe.size.height *= scale;
    }
    
    if (newframe.size.width && (newframe.size.width >= aSize.width))
    {
        scale = aSize.width / newframe.size.width;
        newframe.size.width *= scale;
        newframe.size.height *= scale;
    }
    
    self.frame = newframe;
}

- (void)centerToParent
{
    if(self.superview)
    {
        switch ([UIApplication sharedApplication].statusBarOrientation)
        {
            case UIInterfaceOrientationUnknown:
            {
                NSLog(@"UIInterfaceOrientationUnknown");
                break;
            }
            case UIInterfaceOrientationLandscapeLeft:
            case UIInterfaceOrientationLandscapeRight:
            {
                self.left = PIXEL_INTEGRAL((self.superview.height / 2.0) - (self.width / 2.0));
                self.top = PIXEL_INTEGRAL((self.superview.width / 2.0) - (self.height / 2.0));
                break;
            }
            case UIInterfaceOrientationPortrait:
            case UIInterfaceOrientationPortraitUpsideDown:
            {
                self.left = PIXEL_INTEGRAL((self.superview.width / 2.0) - (self.width / 2.0));
                self.top = PIXEL_INTEGRAL((self.superview.height / 2.0) - (self.height / 2.0));
                break;
            }
        }
    }
}

- (void)addSubviews:(UIView *)view,...
{
    [self addSubview:view];
    va_list ap;
    va_start(ap, view);
    UIView *akey=va_arg(ap,id);
    while (akey) {
        [self addSubview:akey];
        akey=va_arg(ap,id);
    }
    va_end(ap);
}

- (void)removeAllSubviews
{
    while (self.subviews.count)
    {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}

- (void)setRoundCorner
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5.f;
}

- (void)setRoundCorner:(float)cornerRadius
{
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 0.5f;
    self.layer.borderColor = AppColor(197).CGColor;
    self.layer.cornerRadius = cornerRadius;
}

- (void)setRoundCorner:(float)cornerRadius withBorderColor:(UIColor *) color
{
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 0.5f;
    self.layer.borderColor = color.CGColor;
    self.layer.cornerRadius = cornerRadius;
}

- (void)setRoundCornerAll
{
    self.layer.cornerRadius = self.width/2.0;
    self.layer.masksToBounds = YES;
}

- (void)setAnimateRotation
{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 * 2 ];
    rotationAnimation.duration = 2;
    //rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 0;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [self.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
    //        [self.layer removeAllAnimations];
}

- (void)setBorderWithColor:(UIColor *)color
{
    self.layer.borderWidth = 0.5f;
    self.layer.borderColor = color.CGColor;
}

-(BOOL) containsSubView:(UIView *)subView
{
    for (UIView *view in [self subviews]) {
        if ([view isEqual:subView]) {
            return YES;
        }
    }
    return NO;
}
//-(BOOL) isKindOfClass: classObj 判断是否是这个类，包括这个类的子类和父类的实例；
//-(BOOL) isMemberOfClass: classObj 判断是否是这个类的实例,不包括子类或者父类；
-(BOOL) containsSubViewOfClassType:(Class)pClass {
    for (UIView *view in [self subviews]) {
        if ([view isMemberOfClass:pClass]) {
            return YES;
        }
    }
    return NO;
}

- (void)setTapActionWithBlock:(void (^)(void))block
{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &kRCActionHandlerTapGestureKey);
    if (!gesture)
    {
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(__handleActionForTapGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kRCActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &kRCActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);
}
- (void)__handleActionForTapGesture:(UITapGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized)
    {
        void(^action)(void) = objc_getAssociatedObject(self, &kRCActionHandlerTapBlockKey);
        if (action)
        {
            action();
        }
    }
}
- (void)setLongPressActionWithBlock:(void (^)(void))block
{
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *gesture = objc_getAssociatedObject(self, &kRCActionHandlerLongPressGestureKey);
    if (!gesture)
    {
        gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(__handleActionForLongPressGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kRCActionHandlerLongPressGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &kRCActionHandlerLongPressBlockKey, block, OBJC_ASSOCIATION_COPY);
}
- (void)__handleActionForLongPressGesture:(UITapGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan)
    {
        void(^action)(void) = objc_getAssociatedObject(self, &kRCActionHandlerLongPressBlockKey);
        if (action) action();
    }
}

@end

@implementation NSTimer (RCMethod)

-(void)pauseTimer
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate distantFuture]];
}


-(void)resumeTimer
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate date]];
}

- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:interval]];
}

@end

@implementation NSString (Addition)

+ (NSString *)getFromInteger:(NSInteger)num
{
    return [NSString stringWithFormat:@"%d",num];
}

@end

@implementation UIButton (Addition)

- (void)addTimer:(NSInteger)secounds
{
    self.titleLabel.font = Font(16);
    [self setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self setTitleColor:AppColorGray153 forState:UIControlStateNormal];
//    [self addTarget:self action:@selector(timer:) forControlEvents:UIControlEventTouchUpInside];
    self.tag = secounds;
}

#pragma 响应

- (void)timer:(otherButton *)sender
{
    __block int timeout = (int)sender.tag; //倒计时时间
    __block UILabel *timeLabel = nil;
    __block UILabel *textLabel = nil;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);
    
    dispatch_source_set_event_handler(_timer, ^{
        if (timeout <= 0)
        {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [sender setTitle:@"重获验证码" forState:UIControlStateNormal];
                [timeLabel removeFromSuperview];
                [textLabel removeFromSuperview];
                [timeLabel release];
                [textLabel release];
                sender.userInteractionEnabled = YES;
            });
        }
        else
        {
            int seconds = timeout;
            NSString *strS = [NSString stringWithFormat:@"%.2d", seconds];
//            NSLog(@"%@",strS);
            dispatch_async(dispatch_get_main_queue(),^{
                sender.userInteractionEnabled = NO;
                [sender setTitle:@"" forState:UIControlStateNormal];
                CGFloat left  = 11.5f;
                if (!timeLabel)
                {
//                    CGFloat width = [@"00秒后重发" sizeWithFont:Font(16) constrainedToSize:CGSizeMake(MAXFLOAT, 20)].width;
//                    CGFloat left  = (sender.width - width)/2;
                    CGRect frame = CGRectMake(left, 0, 20, sender.height);
                    timeLabel = [[UILabel alloc] initWithFrame:frame];
                    timeLabel.font = Font(16);
                    [timeLabel setTextColor:AppColorRed];
                    
                    textLabel = [[UILabel alloc] initWithFrame:CGRectMake(timeLabel.right, timeLabel.top, sender.width - textLabel.width, sender.height)];
                    textLabel.font = Font(16);
                    [textLabel setTextColor:AppColorLightGray204];
                    [textLabel setText:@"秒后重发"];
                    [sender addSubview:timeLabel];
                    [sender addSubview:textLabel];
                }
                [timeLabel setText:[NSString stringWithFormat:@"%@",strS]];
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

- (void)startTimer
{
    [self timer:self];
}



- (void)addBorder
{
    self.backgroundColor       = AppColorWhite;
    self.layer.masksToBounds   = YES;
    self.layer.borderColor     = AppColorLightGray204.CGColor;
    self.layer.borderWidth     = 1.f;
    [self setRoundCorner];
}

@end

@implementation UIColor (Addition)

+ (UIColor *) titleRedColor
{
    return RGBCOLOR(240, 5, 0);
}

+ (UIColor *) titleBlackColor
{
    return RGBCOLOR(34, 34, 34);
}

+ (UIColor *) borderPicGreyColor
{
    return AppColor(197);
}

@end

@implementation UIImage (compress)

-(UIImage *)compressedImage
{
    const float MAX_IMAGEPIX = 640.0f;
    
    CGSize imageSize = self.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    if (width <= MAX_IMAGEPIX && height <= MAX_IMAGEPIX) {
        // no need to compress.
        return self;
    }
    if (width == 0 || height == 0) {
        // void zero exception
        return self;
    }
    UIImage *newImage = nil;
    CGFloat widthFactor = MAX_IMAGEPIX / width;
    CGFloat heightFactor = MAX_IMAGEPIX / height;
    CGFloat scaleFactor = 0.0;
    if (widthFactor > heightFactor)
        scaleFactor = heightFactor; // scale to fit height
    else
        scaleFactor = widthFactor; // scale to fit width
    CGFloat scaledWidth  = width * scaleFactor;
    CGFloat scaledHeight = height * scaleFactor;
    CGSize targetSize = CGSizeMake(scaledWidth, scaledHeight);
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [self drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

//图片缩放到指定大小尺寸
- (UIImage *)scaleToSize:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

@end

@implementation ServerRequestOption (Addition)

- (void)description
{
    NSLog(@"***************************<Option : %@>\n",1==self.requestType?@"GET":@"POST");
    NSLog(@"headParams: %@",self.headParams);
    NSLog(@"server: %@",self.server);
    NSLog(@"service: %@",self.service);
    NSLog(@"timeoutInterval: %f",self.timeoutInterval);
    NSLog(@"==============\n");
    NSLog(@"URL: %@",self.url);
    NSLog(@"==============\n");
    NSLog(@"****************************************\n");
}

@end