//
//  MainSupportor.m
//
//  Created by abyss on 14/12/22.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "MainSupportor.h"
#import "MallScanAdvertMain.h"

@interface MainSupportor () <UISearchBarDelegate>
@property (retain) UIViewController*    father;
@end
@implementation MainSupportor

- (void)dealloc
{
    CRDEBUG_DEALLOC();
//    _search.delegate = nil;
    
    [_bar release];
    [_search release];
    [_navTitle release];
    [_viewConArray release];
    
    [super dealloc];
}
- (instancetype)initWith:(UIViewController *)con;
{
    self = [super init];
    if (self)
    {
        CRGetValue(_type, 1);
        CRGetValue(_father,con);
        
        [self initBar];
    }
    return self;
}

- (void)initBar
{
    _bar = STRONG_OBJECT(UIView, initWithFrame:CGRectMake(0, 7, 300, 30));
    _bar.backgroundColor = [UIColor clearColor];
    
    //导航条的搜索条
    _search = nil;
    {
        _search = STRONG_OBJECT(UIImageView, initWithFrame:CGRectMake(0, 7, 300, 30));
        _search.backgroundColor = [UIColor clearColor];
        
        _search.image = [UIImage imageNamed:@"mainaDD.png"];
        _search.frame = CGRectMake(0, 0, _search.image.size.width/2, _search.image.size.height/2);
        
        __block MainSupportor* weakself = self;
        [_search setTapActionWithBlock:^{
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = 2;
            [((MallScanAdvertMain *)weakself.father) swapPage:button];
        }];
    }
    
    _navTitle = nil;
    
    {
        _navTitle = STRONG_OBJECT(UILabel, initWithFrame:CGRectMake(25, 0, 180, 30));
        
        _navTitle.font          = BoldFont(18);
        _navTitle.textColor     = [UIColor whiteColor];
        _navTitle.textAlignment = NSTextAlignmentCenter;
    }
    
    [_bar addSubview:_navTitle];
    [_bar addSubview:_search];
//
//    __block MainSupportor *weakself = self;
//    [[UICommon shareInstance] addDoneToKeyboard:_search block:^(){ [weakself hiddenKeyboard];}];
}

#pragma mark - delegate

- (void)hiddenKeyboard
{
    [_search resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self hiddenKeyboard];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = 2;
    [((MallScanAdvertMain *)_father) swapPage:button];
}

//- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
//{
//    _search.text = [_search.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//    
//    if(_search.text.length == 0) return;
//    
//    {
//        _searchKey = _search.text;
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        button.tag = 2;
//        [((MallScanAdvertMain *)_father) swapPage:button];
//    }
//    
//    [self hiddenKeyboard];
//}
@end
