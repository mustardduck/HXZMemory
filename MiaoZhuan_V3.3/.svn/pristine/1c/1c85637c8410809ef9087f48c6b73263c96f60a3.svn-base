//
//  PreviewPicViewController.m
//  miaozhuan
//
//  Created by Santiago on 14-11-11.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "PreviewPicViewController.h"

@interface PreviewPicViewController ()

@end

@implementation PreviewPicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupMoveBackButton];
    [self setTitle:@"图片预览"];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc {
    [_mainImage release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setMainImage:nil];
    [super viewDidUnload];
}
@end
