//
//  CommonTextField.h
//  miaozhuan
//
//  Created by abyss on 14/10/31.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

extern NSString *RCCOMMON_TEXTLIMIT_NUM;
extern NSString *RCCOMMON_TEXTLIMIT_WORD;

@interface CommonTextField : UITextField
@end

@interface CommonTextField (Blocks)

@property (copy, nonatomic) BOOL (^shouldBegindEditingBlock)(CommonTextField *textField);
@property (copy, nonatomic) BOOL (^shouldEndEditingBlock)(CommonTextField *textField);
@property (copy, nonatomic) void (^didBeginEditingBlock)(CommonTextField *textField);
@property (copy, nonatomic) void (^didEndEditingBlock)(CommonTextField *textField);
@property (copy, nonatomic) BOOL (^shouldChangeCharactersInRangeBlock)(CommonTextField *textField, NSRange range, NSString *replacementString);
@property (copy, nonatomic) BOOL (^shouldReturnBlock)(CommonTextField *textField);
@property (copy, nonatomic) BOOL (^shouldClearBlock)(CommonTextField *textField);

#define CommonTextFieldBlockBOOL ^BOOL(CommonTextField *textField)
#define CommonTextFieldBlockVOID ^void(CommonTextField *textField)
- (void)setShouldBegindEditingBlock:(BOOL (^)(CommonTextField *textField))shouldBegindEditingBlock;
- (void)setShouldEndEditingBlock:(BOOL (^)(CommonTextField *textField))shouldEndEditingBlock;
- (void)setDidBeginEditingBlock:(void (^)(CommonTextField *textField))didBeginEditingBlock;
- (void)setDidEndEditingBlock:(void (^)(CommonTextField *textField))didEndEditingBlock;
#define CommonTextFieldBlockChange ^BOOL(CommonTextField *textField, NSRange range, NSString *string)
- (void)setShouldChangeCharactersInRangeBlock:(BOOL (^)(CommonTextField *textField, NSRange range, NSString *string))shouldChangeCharactersInRangeBlock;
- (void)setShouldClearBlock:(BOOL (^)(CommonTextField *textField))shouldClearBlock;
- (void)setShouldReturnBlock:(BOOL (^)(CommonTextField *textField))shouldReturnBlock;

- (BOOL)limitTextFieldContentToNum:(NSString *)string;
//ShouldChangeCharactersInRangeBlock中调用 限制文本输入语法
- (BOOL)limitTextFieldContent:(NSString *)string type:(NSString *)type;

@end

@interface ltext : CommonTextField
@end
//Useage:
//Just like AdvertCollectionViewController