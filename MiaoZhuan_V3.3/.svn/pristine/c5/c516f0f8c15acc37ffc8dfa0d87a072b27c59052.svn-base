//
//  RequestFailed.m
//  miaozhuan
//
//  Created by xm01 on 15-1-27.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "RequestFailed.h"
#import "NOInternetConnectionViewController.h"
@interface RequestFailed ()
{

}

@end

@implementation RequestFailed

+ (instancetype)getInstance
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
//        sharedInstance = [[self alloc] init];
        sharedInstance = [[self alloc] initWithNibName:@"RequestFailed" bundle:nil];
    });
    return sharedInstance;
}

-(void)viewDidUnload
{
    [super viewDidUnload];
    self.viewIndex = nil;
    self.viewNoNet = nil;
    self.viewWeb = nil;
}

-(void)dealloc
{
    [_viewIndex release];
    [_viewNoNet release];
    [_viewWeb release];
    [super dealloc];
}
MTA_viewDidAppear()
MTA_viewDidDisappear(
                     self.isShow = NO;
                     [super viewDidDisappear:animated];
                     )
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.isShow = YES;
}

- (void)didReceiveMemoryWarning {
    
    self.isShow = NO;
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.isShow = NO;
    [super viewWillDisappear:animated];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(IBAction)dicClickedRefresh:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(didClickedRefresh)]) {
        [_delegate didClickedRefresh];
    }
}

-(IBAction)forwardSetting:(id)sender
{
    PUSH_VIEWCONTROLLER(NOInternetConnectionViewController);
}

@end
