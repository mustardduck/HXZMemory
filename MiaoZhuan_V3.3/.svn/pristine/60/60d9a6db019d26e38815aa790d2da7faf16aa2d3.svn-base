//
//  EditImageViewController.m
//  guanggaoban
//
//  Created by 孙向前 on 14-6-12.
//  Copyright (c) 2014年 Arvin. All rights reserved.
//

#import "EditImageViewController.h"
#import "HFImageEditorViewController+SubclassingHooks.h"
#import "SystemUtil.h"

@interface EditImageViewController ()
{
    CGSize  _size;
    CGFloat _width;
}
@property (assign, nonatomic) EditImageType imgType;
@end

@implementation EditImageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil ImgType:(EditImageType)type
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.imgType        = type;
        self.cropSize       = _size;
        self.minimumScale   = 1;
        self.maximumScale   = 3;
        
        self.outputWidth    = _width;
    }
    return self;
}

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //添加导航栏和完成按钮
    UINavigationBar *naviBar = WEAK_OBJECT(UINavigationBar, initWithFrame:CGRectMake(0, 0, 320, [SystemUtil aboveIOS7_0] ? 64 : 44));
    [self.view addSubview:naviBar];
    
    UINavigationItem *naviItem = WEAK_OBJECT(UINavigationItem, initWithTitle:@"图片裁剪");
    [naviBar pushNavigationItem:naviItem animated:YES];
    
    //返回按钮
    UIButton *btnback = [[UIButton alloc] initWithFrame:CGRectMake( - 9, 5, 11, 19)];
    [btnback setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [btnback setImage:[UIImage imageNamed:@"back_hover.png"] forState:UIControlStateHighlighted];
    [btnback addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:btnback];
    naviItem.leftBarButtonItem = left;//左
    [btnback release];
    [left release];
    
    //保存按钮
//    UIBarButtonItem *doneItem = WEAK_OBJECT(UIBarButtonItem, initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(doneAction:));
//    naviItem.rightBarButtonItem = doneItem;
    
    UIButton *btnf = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, 70, 34)];
    
    [btnf setTitle:@"完成" forState:UIControlStateNormal];
    btnf.titleLabel.textColor = AppColorWhite;
    btnf.titleLabel.font = [UIFont systemFontOfSize:18];
    btnf.titleLabel.textAlignment =  NSTextAlignmentCenter;
    
    [btnf addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:btnf];
    naviItem.rightBarButtonItem = right;
    [btnf release];
    [right release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setImgType:(EditImageType)imgType
{
    _maxSize = SCREENHEIGHT > 500 ? 290:260;
    
    switch (imgType)
    {
        case EditImageType200:
        {
            _size   = (CGSize){200,200};
            _width  = 200.f;
            break;
        }
            case EditImageType800:
        {
            _size   = (CGSize){_maxSize, _maxSize};
            _width  = 800.f;
            break;
        }
            case EditImageTypeAdertPic:
        {
            _size   = (CGSize){_maxSize, _maxSize * (1024.f/720.f)};
            _width  = 720.f;
            break;
        }
            case EditImageTypeExchange:
        {
            _size   = (CGSize){_maxSize, _maxSize * (1130.f/800.f)};
            _width  = 800.f;
            break;
        }
            case EditImageTypeIdCard:
        {
            _size   = (CGSize){_maxSize, _maxSize * (508.f/800.f)};
            _width  = 800.f;
            break;
        }
            case EditImageTypeIncHistory:
        {
            _size   = (CGSize){_maxSize, _maxSize * (850.f/1200.f)};
            _width  = 800.f;
            break;
        }
            
        default:
            break;
    }
}

@end
