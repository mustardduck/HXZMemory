//  代码地址: https://github.com/CoderMZLee/MZRefresh
//  代码地址: http://code4app.com/ios/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E4%B8%8B%E6%8B%89%E4%B8%8A%E6%8B%89%E5%88%B7%E6%96%B0/52326ce26803fabc46000000
#import <UIKit/UIKit.h>

// 日志输出
#ifdef DEBUG
#define MZLog(...) NSLog(__VA_ARGS__)
#else
#define MZLog(...)
#endif

// 过期提醒
#define MZDeprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)

// 运行时objc_msgSend
#define msgSend(...) ((void (*)(void *, SEL, UIView *))objc_msgSend)(__VA_ARGS__)
#define msgTarget(target) (__bridge void *)(target)

// RGB颜色
#define MZColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 文字颜色
#define MZRefreshHeaderLabelTextColor MZColor(43, 43, 43)
#define MZRefreshFooterLabelTextColor MZColor(150, 150, 150)

// 字体大小
#define MZRefreshHeaderLabelFont [UIFont systemFontOfSize:14]
#define MZRefreshFooterLabelFont [UIFont systemFontOfSize:13]

// 图片路径
#define MZRefreshSrcName(file) [@"MZRefresh.bundle" stringByAppendingPathComponent:file]

// 常量
UIKIT_EXTERN const CGFloat MZRefreshHeaderHeight;
UIKIT_EXTERN const CGFloat MZRefreshFooterHeight;
UIKIT_EXTERN const CGFloat MZRefreshFastAnimationDuration;
UIKIT_EXTERN const CGFloat MZRefreshSlowAnimationDuration;

UIKIT_EXTERN NSString *const MZRefreshHeaderUpdatedTimeKey;
UIKIT_EXTERN NSString *const MZRefreshContentOffset;
UIKIT_EXTERN NSString *const MZRefreshContentSize;
UIKIT_EXTERN NSString *const MZRefreshPanState;

UIKIT_EXTERN NSString *const MZRefreshHeaderStateIdleText;
UIKIT_EXTERN NSString *const MZRefreshHeaderStatePullingText;
UIKIT_EXTERN NSString *const MZRefreshHeaderStateRefreshingText;

UIKIT_EXTERN NSString *const MZRefreshFooterStateIdleText;
UIKIT_EXTERN NSString *const MZRefreshFooterStateRefreshingText;
UIKIT_EXTERN NSString *const MZRefreshFooterStateNoMoreDataText;