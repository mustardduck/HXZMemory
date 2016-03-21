//
//  UserKeyboard.h
//  miaozhuan
//
//  Created by xm01 on 15-1-4.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UserKeyboardDelegate <NSObject>

- (void) numberKeyboardInput:(NSInteger) number;
- (void) numberKeyboardBackspace;
- (void) changeKeyboardType;
@end

@interface UserKeyboard : UIView
{
    NSArray *arrLetter;
}
@property (nonatomic,assign) id<UserKeyboardDelegate> delegate;

@end
