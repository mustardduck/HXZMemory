//
//  IndustryCategotiesViewController.m
//  miaozhuan
//
//  Created by Santiago on 14-11-11.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "IndustryCategotiesViewController.h"
#import "NetImageView.h"
@interface IndustryCategotiesViewController ()<GetIndustryInformation> {

    NSArray *_categaryArray;
    NSArray *_categaryDetailArray;
}
@property (retain, nonatomic) IBOutlet UIScrollView *mainScrollerView;

@end

@implementation IndustryCategotiesViewController
@synthesize industryDetail = _industryDetail;
@synthesize detailChoosedStr = _detailChoosedStr;
@synthesize choosedIdArray = _choosedIdArray;
@synthesize parentStr = _parentStr;
MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupMoveBackButton];
    [self setTitle:@"选择行业类别"];
    ADAPI_GetIndustryCategoryList([self genDelegatorID:@selector(handleNotification:)],0);
}

- (void)handleNotification:(DelegatorArguments*)arguments {

    DictionaryWrapper *wrapper = arguments.ret;

    if (wrapper.operationSucceed) {
        
        [_categaryArray release];
        _categaryArray = [wrapper.data retain];
        NSLog(@"%lu",(unsigned long)[_categaryArray count]);
        [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".IndustryCategoryDataSource" value:_categaryArray];
        [self setLayouts];
        [self.mainScrollerView setContentSize:CGSizeMake(self.mainScrollerView.frame.size.width, 90*[_categaryArray count]/4+50)];
    }else{
        [HUDUtil showErrorWithStatus:wrapper.operationMessage];
    }
}

- (void)setLayouts {
    
    for (int i = 0; i < [_categaryArray count]; i++) {
        
        int j = i/4;
        DictionaryWrapper *wrapper = [_categaryArray[i] wrapper];
        
        UIView *backGroundView = WEAK_OBJECT(UIView, initWithFrame:CGRectMake((80)*(i%4), (90)*j, 79.5, 89.5));
        UIButton *lucencyButton = WEAK_OBJECT(UIButton, initWithFrame:CGRectMake(0, 0, 79, 89));
        
        [lucencyButton setImage:[UIImage imageNamed:@"hangyebg"] forState:UIControlStateHighlighted];
        
        NetImageView *image = WEAK_OBJECT(NetImageView, initWithFrame:CGRectMake(25, 20, 30, 30));
        
        UILabel *label = WEAK_OBJECT(UILabel, initWithFrame:CGRectMake(0, 57, 79, 14));
        [label setText:[wrapper getString:@"Name"]];
        [label setFont:[UIFont systemFontOfSize:12]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setTextColor:RGBCOLOR(102, 102, 102)];
        
        image.holderColor = [UIColor clearColor];
        [image requestPicture:[wrapper getString:@"PictureUrl"]];
        
        [backGroundView setBackgroundColor:[UIColor whiteColor]];
        
        [lucencyButton setBackgroundColor:[UIColor clearColor]];

        lucencyButton.tag = [wrapper getInt:@"IndustryId"];
        
        [lucencyButton addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [backGroundView addSubview:lucencyButton];
        [backGroundView addSubview:image];
        [backGroundView addSubview:label];
        
        [self.mainScrollerView addSubview:backGroundView];
    }
}

- (void) btnClicked:(UIButton*)sender {

    NSLog(@"the button %ld been clicked",(long)sender.tag);
    
    for (NSDictionary* dic in _categaryArray) {
        
        if (sender.tag == [[dic wrapper] getInt:@"IndustryId"]) {
         
            self.parentStr = [[dic wrapper] getString:@"Name"];
        }
    }
    
    if(_isCateForYinYuan)
    {
        int cateId = (int)sender.tag;
        
        [_delegate selectProductCategorey:_parentStr withId:[NSString stringWithFormat:@"%d", cateId]];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        ADAPI_GetInformationOfSpecialQualification([self genDelegatorID:@selector(requestDone:)], sender.tag);
        self.industryDetail = WEAK_OBJECT(IndustryDetailViewController, init);
        self.industryDetail.delegate1 = self;
        self.industryDetail.parentId = (int)sender.tag;
        [self.navigationController pushViewController:self.industryDetail animated:YES];
    }
}

- (void)requestDone:(DelegatorArguments*)arguments{

    DictionaryWrapper *wrapper = arguments.ret;
    
    if (wrapper.operationSucceed) {
        
        NSArray *item = wrapper.data;
        [self.delegateForSpecialQualification reloadFrameForSpeciaQualification:item];
    }
}

- (void)getInformation:(int)parentId choosedArray:(NSArray*)array choosedStr:(NSMutableString*)string {

    self.detailChoosedStr = string;
    self.choosedIdArray = array;
    
    self.parentId = parentId;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [_mainScrollerView release];
    [_categaryArray release];
    [_industryDetail release];
    [_parentStr release];
    self.delegate = nil;
    [super dealloc];
}
- (void)viewDidUnload {
    self.delegate = nil;
    [self setMainScrollerView:nil];
    [super viewDidUnload];
}
@end
