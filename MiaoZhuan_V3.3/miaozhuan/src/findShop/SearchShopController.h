//
//  SearchShopController.h
//  miaozhuan
//
//  Created by momo on 14-10-22.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchShopController : DotCViewController<UISearchBarDelegate>
{
    UISearchBar * _searchBar;
    
    NSMutableDictionary * _searchDic;
    
    NSMutableArray * _hotSearchArr;
}
@property (retain, nonatomic) IBOutlet UITableView *searchTableView;
@property (retain, nonatomic) IBOutlet UITableView *hotSearchTableView;

@end
