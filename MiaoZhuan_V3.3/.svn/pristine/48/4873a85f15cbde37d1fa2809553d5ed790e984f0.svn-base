//
//  HeaderManageCenterViewController.m
//  guanggaoban
//
//  Created by abyss on 14-8-22.
//  Copyright (c) 2014年 Arvin. All rights reserved.
//

#import "HeaderManageCenterViewController.h"
#import "HeaderCollectionCell.h"
#import "AdsViewController.h"
#import "UIView+expanded.h"
#import "NSDictionary+expanded.h"
//#import "GainSilverByAdvertViewController.h"
//#import "LoginManager.h"

@interface HeaderManageCenterViewController ()
{
    FloatCell       *_floatCell;
    CGPoint         _panBeginPoint;
    CGPoint         _point;
    UIView          *_backgourndCoverView;
    NSInteger       _curId;
    UIButton        *_topButton;
}

@property (retain, nonatomic) NSIndexPath *holderPlacePath;
@property (retain, nonatomic) UIView            *SectionFirst;
@property (retain, nonatomic) UIView            *SectionSecond;
@property (retain, nonatomic) NSMutableArray    *dataObject;

@end

typedef NS_OPTIONS(NSInteger, CollectionPositon)
{
    CollectionPositonPanRange      = 1 << 0,
    CollectionPositonSectionFirst  = 1 << 1,
    CollectionPositonSectionSecond = 1 << 2,
};

// ===>
static NSString *UserMarkDefaults = @"UserMarkDefaults";

@implementation HeaderManageCenterViewController

@synthesize dataObject      = _dataObject;              //数据
@synthesize SectionFirst    = _SectionFirst;            //标题一
@synthesize SectionSecond   = _SectionSecond;           //标题二
@synthesize holderPlacePath = _holderPlacePath;         //占位CELL
@synthesize curLineTag      = _curLineTag;              //现在的位置

- (void)viewWillAppear:(BOOL)animated
{
    
}

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initNav];
    [self initData];
    [self initColletionView];
 
}

#pragma mark - Function函数

- (void)initColletionView
{
    [self.collectionView registerClass:[HeaderCollectionCell class] forCellWithReuseIdentifier:@"MyCollectionCELL"];
    [self.collectionView reloadData];
    
    self.collectionView.backgroundColor     = RGBACOLOR(239, 239, 244, 1);
    
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    //创建并且隐藏浮动Cell
    [self initFloatCell];
}


- (void)initFloatCell
{
    //浮动cell
    if (!_floatCell) {
        _floatCell = WEAK_OBJECT(FloatCell, initWithFrame:CGRectMake(0, 0, 90, 40));
        [self.view addSubview:_floatCell];
    }
    
    //隐藏
    [_floatCell stopFloat];
}


- (void)loadSectionTitle
{
    //只创建一次
    if (!_SectionFirst) {
        //第一次，读nib
        _SectionFirst    = [[NSBundle mainBundle] loadNibNamed:@"HeaderManageCenterViewController" owner:self options:nil][0];
        _SectionSecond   = [[NSBundle mainBundle] loadNibNamed:@"HeaderManageCenterViewController" owner:self options:nil][1];
        [self.view insertSubview:_SectionFirst belowSubview:_floatCell];
        [self.collectionView insertSubview:_SectionSecond belowSubview:_floatCell];
        
        _SectionFirst.center = CGPointMake(160.f, 20.f);
    }
    
    //更新位置
    _SectionSecond.center       = CGPointMake(160.f, [self bottomOfSection:0] + 20.f);
    _backgourndCoverView.center = CGPointMake(160.f, [self bottomOfSection:0] + 200.f);
}


- (NSInteger)dataArrayCountInSection:(NSInteger)section
{
    return ((NSArray*)_dataObject[section]).count;
}


- (float)bottomOfSection:(NSInteger)section
{
#warning Section修改
    // 40 navHeight
    NSInteger countInSectionFirst = [self dataArrayCountInSection:0];
    NSInteger rowInSectionFirst = countInSectionFirst/3 +(countInSectionFirst%3 == 0? 0:1);
    
    // 0
#warning lineSpacing
    if (section == 0) return (45.f + (_floatCell.frameHeight + 10) * rowInSectionFirst);
    
    // 1
    else
    {
        NSInteger countInSectionSecond = [self dataArrayCountInSection:1];
        NSInteger rowInSectionSecond = countInSectionSecond/3 +(countInSectionSecond%3 == 0? 0:1) + rowInSectionFirst;
        return (80.f + (_floatCell.frameHeight + 10) * rowInSectionSecond);
    }
}


- (void)initNav
{
    [super setupMoveBackButton];
    [self setNavigateTitle:@"分类查看广告"];
}

- (void)initData
{
    NSUserDefaults *UserMark = [NSUserDefaults standardUserDefaults];
    
    [_dataObject release];
    _dataObject = [[NSMutableArray alloc] initWithArray:@[[NSMutableArray array],[NSMutableArray array]]];
    
    [_dataObject[0] addObjectsFromArray:[[UserMark valueForKey:UserMarkDefaults] objectForKey:@"isShow"]];
    [_dataObject[1] addObjectsFromArray:[[UserMark valueForKey:UserMarkDefaults] objectForKey:@"offShow"]];
}

- (void)saveUserMark
{
    
    NSDictionary *dic = [[[NSDictionary alloc] initWithObjects:@[_dataObject[0], _dataObject[1]] forKeys:@[@"isShow",@"offShow"]] autorelease];

    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:UserMarkDefaults];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


- (void)isDragable:(HeaderCollectionCell *)cell
{
    if(cell.dragable)
    {
        UILongPressGestureRecognizer *drag = [[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)] autorelease];
        drag.delegate = self;
        drag.minimumPressDuration = 0.5;
        [cell addGestureRecognizer:drag];
    }
    else cell.dragable = NO;
}


- (void)isCurTag:(HeaderCollectionCell *)cell withIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == _curLineTag)
    {
        cell.curTag = YES;
        _curId = [[cell.data objectForKey:@"Id"] intValue];
    }
}


- (CollectionPositon)judgePosition:(CGPoint)point
{
    NSInteger Position = 0;
    float SectionTitleHeight = 0;
    if (_SectionFirst)
    {
        SectionTitleHeight = _SectionFirst.frameHeight;
    }
    
    if (point.x > 25 && point.y > 25 && point.x < 295 && point.y < [self bottomOfSection:1] + 125)
        Position |= CollectionPositonPanRange;
    
    if (point.y > SectionTitleHeight && point.y < [self bottomOfSection:0] + 20)
        Position |= CollectionPositonSectionFirst;
    else if (point.y > [self bottomOfSection:0] + 20 && point.y < [self bottomOfSection:1] + 40)
        Position |= CollectionPositonSectionSecond;
    
    return Position;
}

#pragma mark - 滑动事件处理


- (void)handlePanGesture:(UIGestureRecognizer*)sender
{
    _point    = [sender locationInView:self.collectionView];
    _point.y -= self.collectionView.contentOffset.y;
    
    
    //滑动开始
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        [self startDraging];
        _floatCell.center = _panBeginPoint;
    }
    
    //滑动中
    else if (sender.state == UIGestureRecognizerStateChanged)
    {
        //滑动有效范围
        if (![_floatCell isFloating] || !([self judgePosition:_point] & CollectionPositonPanRange))
        {
            return;
        }
        
        _floatCell.center = _point;
        
        [self didDraging];
        
    }
    
    //滑动结束
    else if  (sender.state == UIGestureRecognizerStateEnded || sender.state == UIGestureRecognizerStateCancelled)
    {
//        [self didDraging];
        
        [self endDrag];
    }
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    //记录滑动初始点
    _panBeginPoint = [touch locationInView:self.collectionView];
    
    return TRUE;
}


- (void)startDraging
{
    //确定滑动的Cell
    
    PSTCollectionViewLayoutAttributes* beginCell = [self.collectionView layoutAttributesForItemAtPoint:_panBeginPoint];
    if (!beginCell)
    {
        return;
    }
    
    self.holderPlacePath = beginCell.indexPath;
    HeaderCollectionCell* cell = (HeaderCollectionCell *)[self.collectionView cellForItemAtIndexPath:self.holderPlacePath];
    
    //浮动Cell,原cell变为holder状态
    [_floatCell floatWithCell:cell data:cell.data];
    cell.showHolder = YES;
}


- (void)endDrag {
    
    if(![_floatCell isFloating])
    {
        return ;
    }
    
    HeaderCollectionCell *cell = (HeaderCollectionCell *)[self.collectionView cellForItemAtIndexPath:self.holderPlacePath];
    [cell getData:_floatCell.floatData];
    cell.showHolder = NO;
    
    [_floatCell stopFloat];
}


- (void)didDraging
{
    if(![_floatCell isFloating])
    {
        return ;
    }
    
    NSIndexPath*            nowPath = nil;
    HeaderCollectionCell*   nowcell = nil;
    NSInteger               sectionFlag;
    
    //Section 1
    if ([self judgePosition:_point] & CollectionPositonSectionFirst)
    {
        PSTCollectionViewLayoutAttributes* cellAttr = [self.collectionView layoutAttributesForItemAtPoint:_point];
        if(cellAttr.isCell)
        {
            nowPath     = cellAttr.indexPath;
            nowcell     = (HeaderCollectionCell *)[self.collectionView cellForItemAtIndexPath:nowPath];
        }
        
        sectionFlag = 0;
    }
    //Section 2
    else if ([self judgePosition:_point] & CollectionPositonSectionSecond)
    {
        PSTCollectionViewLayoutAttributes* cellAttr = [self.collectionView layoutAttributesForItemAtPoint:_point];
        if(cellAttr.isCell)
        {
            nowPath     = cellAttr.indexPath;
            nowcell     = (HeaderCollectionCell *)[self.collectionView cellForItemAtIndexPath:nowPath];
        }
        
        sectionFlag = 1;
    }
    //不在Section 里面
    else return;
    
    //同一Section
    if (self.holderPlacePath.section == sectionFlag)
    {
        if (self.holderPlacePath.item != nowPath.item && nowcell.dragable)
        {
            [self.dataObject[sectionFlag] removeObjectAtIndex:self.holderPlacePath.item];
            [self.dataObject[sectionFlag] insertObject:_floatCell.floatData atIndex:nowPath.item];
            
            [self.collectionView performBatchUpdates:^{
                [self.collectionView moveItemAtIndexPath:self.holderPlacePath toIndexPath:nowPath];
            }
                                          completion:^(BOOL finished)
             {
                 [self loadSectionTitle];
             }];
            
            self.holderPlacePath = nowPath;
        }
    }
    //不同Section
    else
    {
        if (_floatCell.curTag == YES)
        {
            _floatCell.curTag = NO;
            _curLineTag       = 0;
        }
        //删除holder
        [_dataObject[self.holderPlacePath.section] removeObjectAtIndex:self.holderPlacePath.item];
        //添加末尾
        NSIndexPath*        lastPath;
        lastPath = [NSIndexPath indexPathForItem:((NSArray *)_dataObject[sectionFlag]).count inSection:sectionFlag];
        
#warning 平时也填在最后
        //不可拖动 || 没有收到Path
        if (!nowcell.dragable)
        {
            [_dataObject[sectionFlag] addObject:_floatCell.floatData];
            nowPath = lastPath;
        }
        //有Path
        else
        {
            APP_ASSERT(nowPath != nil);
            [_dataObject[sectionFlag] insertObject:_floatCell.floatData atIndex:nowPath.item];
        }
        
        //执行动画
        [self.collectionView performBatchUpdates:^{
            [self.collectionView moveItemAtIndexPath:self.holderPlacePath toIndexPath:nowPath];
        }completion:^(BOOL finished){
            [self loadSectionTitle];
        }];
        
        //置换holder
        self.holderPlacePath = nowPath;
    }
}


#pragma mark - PSTCollectionViewCell Delegate


-(NSInteger)numberOfSectionsInCollectionView:(PSTCollectionView *)collectionView
{
    return [_dataObject count];
}


- (NSInteger)collectionView:(PSTCollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
    return [self dataArrayCountInSection:section];
}


- (PSTCollectionViewCell *)collectionView:(PSTCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HeaderCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyCollectionCELL" forIndexPath:indexPath];
    //不可移动cell
    cell.dragable = !(indexPath.section == 0 && (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2));
    
    [self isDragable:cell];
    [cell getData:_dataObject[indexPath.section][indexPath.item]];
    [self isCurTag:cell withIndexPath:indexPath];
    
    [self loadSectionTitle];
    
    cell.btnItem.tag = indexPath.section * 10000 + indexPath.row + 1;
    [cell.btnItem addTarget:self action:@selector(btnItemClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    return (PSTCollectionViewCell *)cell;
}

- (void)dealloc
{   [_dataObject release];
    _dataObject = nil;
    [_holderPlacePath release];
    [super dealloc];
}

- (void)btnItemClicked:(UIButton *)button{
    
    NSInteger row = button.tag % 10000;
    NSInteger section = button.tag / 10000;
    if (section) {
        //数据
        [_dataObject[0] addObject:[_dataObject[section] objectAtIndex:row - 1]];
        [_dataObject[section] removeObjectAtIndex:row - 1];
        
        [self.collectionView reloadData];
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:@(row) forKey:@"HeaderManageCenterCurLineTag"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self arrowBt:nil];
    }
    
    
}

- (IBAction)arrowBt:(UIButton *)sender
{
    if (sender) {
        NSInteger CurId = 0;
        for ( NSInteger i = 0; i < ((NSArray *)_dataObject[0]).count; i++)
        {
            if ([[((NSDictionary *)[_dataObject[0] objectAtIndex:i]) objectForKey:@"Id"] intValue] == _curId)
            {
                CurId = i;
                break;
            }
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:@(CurId+1) forKey:@"HeaderManageCenterCurLineTag"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    [self saveUserMark];

    if (sender.tag == 1119)
        [self.navigationController popToRootViewControllerAnimated:YES];
    else {
        [self.navigationController popViewControllerAnimated:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"categories" object:nil];
    }
    


}


- (void)onMoveBack:(UIButton *)sender
{
    UIButton *b = WEAK_OBJECT(UIButton, init);
    b.tag = 1119;
    [self arrowBt:b];
}

@end


