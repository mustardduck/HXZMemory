//
//  CycleView.m
//  UIAnimation
//
//  Created by apple on 14/12/28.
//
//

#import "CycleView.h"
#import "iCarousel.h"
#import "NetImageView.h"

@interface CycleView ()<iCarouselDataSource,iCarouselDelegate>

@property (nonatomic, retain) UIPageControl *pageControl;

@property (retain, nonatomic) IBOutlet iCarousel *carousel;

@property(nonatomic, assign) BOOL               wrap;

@property(nonatomic, assign) CGRect             viewFrame;

@property(nonatomic, assign) CGRect             pageControlFrame;

@property(nonatomic, assign) int                imgSpace;

@property(nonatomic, assign) int                imgWidth;

@property(nonatomic, retain) NSMutableArray     *imgDataArray;

@property(nonatomic, assign) int                pageCtrolNum;

@end

@implementation CycleView

@synthesize carousel;
@synthesize pageControl;
@synthesize wrap;
@synthesize viewFrame;
@synthesize pageControlFrame;
@synthesize imgSpace;
@synthesize imgWidth;
@synthesize imgDataArray;
@synthesize pageCtrolNum;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder]))
    {
        wrap = YES;
    }
    
    return self;
}

- (id)initWithParameter:(int)space imgWidth:(int)width imageData:(NSArray *)data
{
    self = [super initWithNibName:@"CycleView" bundle:nil];
    if (self) {
        
        imgSpace = space;
        imgWidth = width;
        
        imgDataArray = [[[NSMutableArray alloc] init] autorelease];
        
        pageCtrolNum = [data count];
        
        if(data && [data count] != 0)
        {
            int circleNum = 1;
            
            if([data count] == 2)
                circleNum = 3;                          //循环3次
            else if([data count] == 3)                  //循环2次
                circleNum = 2;
            
                for(int i = 0; i < circleNum; i++)
                {
                    
                    for (NSDictionary *dic in data) {
                        [imgDataArray addObject:[dic.wrapper getString:@"PictureUrl"]];
                    }
                }
        }
        else
        {
            [imgDataArray addObject:@""];
        }
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if([imgDataArray count] == 1 )
        carousel.scrollEnabled = NO;
    wrap = YES;
    carousel.delegate = self;
    carousel.dataSource = self;
    carousel.type = iCarouselTypeLinear;
    [self.view addSubview:carousel];
    
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(120, 200, 76, 72)];
    pageControl.numberOfPages = pageCtrolNum;
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    [self.view addSubview:pageControl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [carousel release];
    [pageControl release];
    [imgDataArray release];
    
    [super dealloc];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.carousel = nil;
    self.pageControl = nil;
    self.imgDataArray = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (IBAction)toggleWrap
{
    wrap = !wrap;
    [carousel reloadData];
}

#pragma mark -

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return [imgDataArray count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index
{
    //在此更改图片
    NetImageView *view = [[[NetImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)] autorelease];
    if(imgDataArray && [imgDataArray count] > 0)
        [view requestPic:[imgDataArray objectAtIndex:index] placeHolder:YES];
    else
        [view requestPic:@"" placeHolder:YES];
    
    return view;
}

-(void)ActionImageSelected:(id)sender
{
    UITapGestureRecognizer *singleTap = (UITapGestureRecognizer *)sender;
}

- (NSUInteger)numberOfPlaceholdersInCarousel:(iCarousel *)carousel
{
    return 0;
}

- (NSUInteger)numberOfVisibleItemsInCarousel:(iCarousel *)carousel
{
    return 30;
}

- (CGFloat)carouselItemWidth:(iCarousel *)carousel
{
    return imgSpace + imgWidth;
}

- (BOOL)carouselShouldWrap:(iCarousel *)carousel
{
    return wrap;
}

-(void)carouselDidEndDecelerating:(iCarousel *)carousels
{
    int currentNum = 0;
    
    if((carousels.currentItemIndex+1) > pageCtrolNum)
    {
        if(pageCtrolNum != 0)
        currentNum = (carousels.currentItemIndex) % pageCtrolNum;
    }
    else
        currentNum = carousels.currentItemIndex;
    
    pageControl.currentPage = currentNum;
}


@end
