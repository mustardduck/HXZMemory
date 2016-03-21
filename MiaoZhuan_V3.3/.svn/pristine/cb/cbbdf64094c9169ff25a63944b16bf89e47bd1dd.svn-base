//
//  IWSearchTableViewCell.h
//  miaozhuan
//
//  Created by luo on 15/4/24.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^IWSearchTableViewCellDeleteBlock)(int index);

@interface IWSearchTableViewCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UILabel *lableTitle;
@property (retain, nonatomic) IBOutlet UIButton *buttonDelete;

@property (copy,nonatomic) IWSearchTableViewCellDeleteBlock deleteItem;

-(void) setupContent:(BOOL) isShowDelete title:(NSString *) title ;


@end
