//
//  IndustryDetailViewController.m
//  miaozhuan
//
//  Created by Santiago on 14-11-13.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "IndustryDetailViewController.h"

@interface IndustryDetailViewController () {

    NSArray *_categaryDetailArray;
}
@property (retain, nonatomic) IBOutlet UIScrollView *mainScrollerView;
@property (strong, nonatomic) NSMutableArray *categaryDetailArrayIDChoosed;
@property (strong, nonatomic) NSMutableString *categaryChoosedStr;
@end

@implementation IndustryDetailViewController
@synthesize mainScrollerView = _mainScrollerView;
@synthesize categaryDetailArrayIDChoosed = _categaryDetailArrayIDChoosed;
@synthesize choosedIdsArray = _choosedIdsArray;
@synthesize parentString = _parentString;
@synthesize categaryChoosedStr = _categaryChoosedStr;
MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {

    [super viewDidLoad];
    [self setupMoveBackButton];
    [self setTitle:@"选择行业细分"];
    [self setupMoveFowardButtonWithTitle:@"确定"];
    self.categaryDetailArrayIDChoosed = WEAK_OBJECT(NSMutableArray, init);
    [self.categaryDetailArrayIDChoosed addObjectsFromArray:_choosedIdsArray];
    
    ADAPI_GetIndustryCategoryList([self genDelegatorID:@selector(handleNotification:)],self.parentId);
}

- (void)handleNotification:(DelegatorArguments*)arguments {
    
    DictionaryWrapper *wrapper = arguments.ret;
    
    if (wrapper.operationSucceed)
    {
        [_categaryDetailArray release];
        _categaryDetailArray = [wrapper.data retain];
        NSLog(@"%lu",(unsigned long)[_categaryDetailArray count]);
        [self setLayouts];
        
        int x = (int)[_categaryDetailArray count]/3;
        if ([_categaryDetailArray count]%3 != 0) {
            
            x++;
        }
        [_mainScrollerView setContentSize:CGSizeMake(_mainScrollerView.frame.size.width, 91*x)];
    }
    else
    {
        [HUDUtil showErrorWithStatus:wrapper.operationMessage];
    }
}

- (void)setLayouts {
    
    for (int i = 0; i<[_categaryDetailArray count]; i++) {
        
        int j = i/3;
        
        DictionaryWrapper *wrapper = [_categaryDetailArray[i] wrapper];
        
        UIView *backGoundView =  WEAK_OBJECT(UIView, initWithFrame:CGRectMake(i%3*108, j*91, 107.5, 90.5));
        
        UILabel *detailLabel = WEAK_OBJECT(UILabel, initWithFrame:CGRectMake(0, 17, 107, 20));
        [detailLabel setFont:[UIFont systemFontOfSize:15]];
        detailLabel.textAlignment = NSTextAlignmentCenter;
        detailLabel.text = [wrapper getString:@"Name"];
        [detailLabel setTextColor:RGBCOLOR(102, 102, 102)];
        
        UIButton *checkBoxButton = WEAK_OBJECT(UIButton, initWithFrame:CGRectMake(0, 0, 108, 91));
        
        checkBoxButton.tag = [wrapper getInt:@"IndustryId"];
        
        [checkBoxButton addTarget:self action:@selector(chooseDetail:) forControlEvents:UIControlEventTouchUpInside];
        [checkBoxButton setImage:[UIImage imageNamed:@"address_single_box.png"] forState:UIControlStateNormal];
        [checkBoxButton setImageEdgeInsets:UIEdgeInsetsMake(45, 38, 20, 42)];
        
        [backGoundView setBackgroundColor:[UIColor whiteColor]];
        [backGoundView addSubview:checkBoxButton];
        [backGoundView addSubview:detailLabel];
        [self.mainScrollerView addSubview: backGoundView];
        
        if ([_categaryDetailArrayIDChoosed containsObject:[NSString stringWithFormat:@"%d",checkBoxButton.tag]]) {
            
            [checkBoxButton setImage:[UIImage imageNamed:@"address_single_boxhover.png"] forState:UIControlStateNormal];
        }else {
            
            [checkBoxButton setImage:[UIImage imageNamed:@"address_single_box.png"] forState:UIControlStateNormal];
        }
    }
}

- (void)chooseDetail:(UIButton*)sender {
    
    int st;
    
    st = (int)sender.tag;
    
    if (![_categaryDetailArrayIDChoosed containsObject:[NSString stringWithFormat:@"%d",st]]) {

        [self.categaryDetailArrayIDChoosed addObject:[NSString stringWithFormat:@"%d",st]];
        [sender setImage:[UIImage imageNamed:@"address_single_boxhover.png"] forState:UIControlStateNormal];
    }else {
    
        [self.categaryDetailArrayIDChoosed removeObject:[NSString stringWithFormat:@"%d",st]];
        [sender setImage:[UIImage imageNamed:@"address_single_box.png"] forState:UIControlStateNormal];
    }
}


//确定
- (IBAction) onMoveFoward:(UIButton*) sender {
    
    [self configString];
    
    if ([_categaryDetailArrayIDChoosed count] > 0 && [self.delegate1 respondsToSelector:@selector(getInformation:choosedArray:choosedStr:)]) {
        
        
        [self.delegate1 getInformation:self.parentId choosedArray:_categaryDetailArrayIDChoosed choosedStr:_categaryChoosedStr];
        
        UINavigationController* navigationController = self.navigationController;
        [navigationController popViewControllerAnimated:FALSE];
        [navigationController popViewControllerAnimated:FALSE];
    }
    
    if (_delegate_add && [_delegate_add respondsToSelector:@selector(getChooseInfo:)]){
        
        WDictionaryWrapper *wrapper = WEAK_OBJECT(WDictionaryWrapper, init);
        [wrapper set:@"parent" string:_parentString];
        [wrapper set:@"child" string:_categaryChoosedStr];
        [wrapper set:@"parentID" string:[NSString stringWithFormat:@"%d", _parentId]];
        [wrapper set:@"childID" value:_categaryDetailArrayIDChoosed];
        [_delegate_add getChooseInfo:wrapper];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

//配置字符串
- (void)configString {

    self.categaryChoosedStr = WEAK_OBJECT(NSMutableString, init);
    
    for (NSDictionary * dic in _categaryDetailArray) {
        
        if ([_categaryDetailArrayIDChoosed containsObject:[NSString stringWithFormat:@"%d",[[dic wrapper] getInt:@"IndustryId"]]]) {
            
            [_categaryChoosedStr appendString:[[dic wrapper] getString:@"Name"]];
            [_categaryChoosedStr appendString:@" "];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    self.delegate1 = nil;
    self.delegate_add = nil;
    [_categaryChoosedStr release];
    [_mainScrollerView release];
    [_categaryDetailArray release];
    [_categaryDetailArrayIDChoosed release];
    [_choosedIdsArray release];
    [super dealloc];
}
@end
