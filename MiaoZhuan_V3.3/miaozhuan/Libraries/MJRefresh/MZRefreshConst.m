//  代码地址: https://github.com/CoderMZLee/MZRefresh
//  代码地址: http://code4app.com/ios/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E4%B8%8B%E6%8B%89%E4%B8%8A%E6%8B%89%E5%88%B7%E6%96%B0/52326ce26803fabc46000000
#import <UIKit/UIKit.h>

const CGFloat MZRefreshHeaderHeight = 54.0;
const CGFloat MZRefreshFooterHeight = 44.0;
const CGFloat MZRefreshFastAnimationDuration = 0.25;
const CGFloat MZRefreshSlowAnimationDuration = 0.4;

NSString *const MZRefreshHeaderUpdatedTimeKey = @"MZRefreshHeaderUpdatedTimeKey";
NSString *const MZRefreshContentOffset = @"contentOffset";
NSString *const MZRefreshContentSize = @"contentSize";
NSString *const MZRefreshPanState = @"pan.state";

NSString *const MZRefreshHeaderStateIdleText = @"下拉刷新";
NSString *const MZRefreshHeaderStatePullingText = @"释放立即刷新";
NSString *const MZRefreshHeaderStateRefreshingText = @"刷新中...";

NSString *const MZRefreshFooterStateIdleText = @"上拉可以加载更多数据";
NSString *const MZRefreshFooterStateRefreshingText = @"加载中...";
NSString *const MZRefreshFooterStateNoMoreDataText = @"已经全部加载完毕";