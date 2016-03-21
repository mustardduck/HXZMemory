//
//  CommonTextField.m
//  miaozhuan
//
//  Created by abyss on 14/10/31.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "CommonTextField.h"

@interface CommonTextField ()
{
    UIView *_holderView;
}
@end
@implementation CommonTextField

- (void)dealloc
{
    [_holderView release];
    
    [super dealloc];
}

- (void)setup
{
    _holderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 5)];
    self.leftViewMode = UITextFieldViewModeAlways;
    self.leftView = _holderView;
    self.rightView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 5)] autorelease];
    self.layer.borderWidth = .5f;
    self.layer.borderColor = AppColorLightGray204.CGColor;
    self.layer.masksToBounds = YES;
    self.clearButtonMode = UITextFieldViewModeAlways;
    self.textColor = AppColorBlack43;
    [self setRoundCorner];
}

- (id)init
{
    self = [super init];
    if (self)
    {
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self setup];
    }
    return self;
}


@end

typedef BOOL (^UITextFieldReturnBlock) (CommonTextField *textField);
typedef void (^UITextFieldVoidBlock) (CommonTextField *textField);
typedef BOOL (^UITextFieldCharacterChangeBlock) (CommonTextField *textField, NSRange range, NSString *replacementString);

@implementation CommonTextField (Blocks)

static const void *UITextFieldDelegateKey = &UITextFieldDelegateKey;
static const void *UITextFieldShouldBeginEditingKey = &UITextFieldShouldBeginEditingKey;
static const void *UITextFieldShouldEndEditingKey = &UITextFieldShouldEndEditingKey;
static const void *UITextFieldDidBeginEditingKey = &UITextFieldDidBeginEditingKey;
static const void *UITextFieldDidEndEditingKey = &UITextFieldDidEndEditingKey;
static const void *UITextFieldShouldChangeCharactersInRangeKey = &UITextFieldShouldChangeCharactersInRangeKey;
static const void *UITextFieldShouldClearKey = &UITextFieldShouldClearKey;
static const void *UITextFieldShouldReturnKey = &UITextFieldShouldReturnKey;


#pragma mark UITextField Delegate methods

+ (BOOL)textFieldShouldBeginEditing:(CommonTextField *)textField
{
    UITextFieldReturnBlock block = textField.shouldBegindEditingBlock;
    if (block) {
        return block(textField);
    }
    id delegate = objc_getAssociatedObject(self, UITextFieldDelegateKey);
    if ([delegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        return [delegate textFieldShouldBeginEditing:textField];
    }
    // return default value just in case
    return YES;
}
+ (BOOL)textFieldShouldEndEditing:(CommonTextField *)textField
{
    UITextFieldReturnBlock block = textField.shouldEndEditingBlock;
    if (block) {
        return block(textField);
    }
    id delegate = objc_getAssociatedObject(self, UITextFieldDelegateKey);
    if ([delegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
        return [delegate textFieldShouldEndEditing:textField];
    }
    // return default value just in case
    return YES;
}
+ (void)textFieldDidBeginEditing:(CommonTextField *)textField
{
    UITextFieldVoidBlock block = textField.didBeginEditingBlock;
    if (block) {
        block(textField);
    }
    id delegate = objc_getAssociatedObject(self, UITextFieldDelegateKey);
    if ([delegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [delegate textFieldDidBeginEditing:textField];
    }
}
+ (void)textFieldDidEndEditing:(CommonTextField *)textField
{
    UITextFieldVoidBlock block = textField.didEndEditingBlock;
    if (block) {
        block(textField);
    }
    id delegate = objc_getAssociatedObject(self, UITextFieldDelegateKey);
    if ([delegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [delegate textFieldDidBeginEditing:textField];
    }
}
+ (BOOL)textField:(CommonTextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    UITextFieldCharacterChangeBlock block = textField.shouldChangeCharactersInRangeBlock;
    if (block) {
        return block(textField,range,string);
    }
    id delegate = objc_getAssociatedObject(self, UITextFieldDelegateKey);
    if ([delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        return [delegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
    }
    return YES;
}
+ (BOOL)textFieldShouldClear:(CommonTextField *)textField
{
    UITextFieldReturnBlock block = textField.shouldClearBlock;
    if (block) {
        return block(textField);
    }
    id delegate = objc_getAssociatedObject(self, UITextFieldDelegateKey);
    if ([delegate respondsToSelector:@selector(textFieldShouldClear:)]) {
        return [delegate textFieldShouldClear:textField];
    }
    return YES;
}
+ (BOOL)textFieldShouldReturn:(CommonTextField *)textField
{
    UITextFieldReturnBlock block = textField.shouldReturnBlock;
    if (block) {
        return block(textField);
    }
    id delegate = objc_getAssociatedObject(self, UITextFieldDelegateKey);
    if ([delegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
        return [delegate textFieldShouldReturn:textField];
    }
    return YES;
}

#pragma mark Block setting/getting methods

- (BOOL (^)(CommonTextField *))shouldBegindEditingBlock
{
    return objc_getAssociatedObject(self, UITextFieldShouldBeginEditingKey);
}
- (void)setShouldBegindEditingBlock:(BOOL (^)(CommonTextField *))shouldBegindEditingBlock
{
    [self setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, UITextFieldShouldBeginEditingKey, shouldBegindEditingBlock, OBJC_ASSOCIATION_COPY);
}
- (BOOL (^)(CommonTextField *))shouldEndEditingBlock
{
    return objc_getAssociatedObject(self, UITextFieldShouldEndEditingKey);
}
- (void)setShouldEndEditingBlock:(BOOL (^)(CommonTextField *))shouldEndEditingBlock
{
    [self setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, UITextFieldShouldEndEditingKey, shouldEndEditingBlock, OBJC_ASSOCIATION_COPY);
}
- (void (^)(CommonTextField *))didBeginEditingBlock
{
    return objc_getAssociatedObject(self, UITextFieldDidBeginEditingKey);
}
- (void)setDidBeginEditingBlock:(void (^)(CommonTextField *))didBeginEditingBlock
{
    [self setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, UITextFieldDidBeginEditingKey, didBeginEditingBlock, OBJC_ASSOCIATION_COPY);
}
- (void (^)(CommonTextField *))didEndEditingBlock
{
    return objc_getAssociatedObject(self, UITextFieldDidEndEditingKey);
}
- (void)setDidEndEditingBlock:(void (^)(CommonTextField *))didEndEditingBlock
{
    [self setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, UITextFieldDidEndEditingKey, didEndEditingBlock, OBJC_ASSOCIATION_COPY);
}
- (BOOL (^)(CommonTextField *, NSRange, NSString *))shouldChangeCharactersInRangeBlock
{
    return objc_getAssociatedObject(self, UITextFieldShouldChangeCharactersInRangeKey);
}
- (void)setShouldChangeCharactersInRangeBlock:(BOOL (^)(CommonTextField *, NSRange, NSString *))shouldChangeCharactersInRangeBlock
{
    [self setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, UITextFieldShouldChangeCharactersInRangeKey, shouldChangeCharactersInRangeBlock, OBJC_ASSOCIATION_COPY);
}
- (BOOL (^)(CommonTextField *))shouldReturnBlock
{
    return objc_getAssociatedObject(self, UITextFieldShouldReturnKey);
}
- (void)setShouldReturnBlock:(BOOL (^)(CommonTextField *))shouldReturnBlock
{
    [self setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, UITextFieldShouldReturnKey, shouldReturnBlock, OBJC_ASSOCIATION_COPY);
}
- (BOOL (^)(CommonTextField *))shouldClearBlock
{
    return objc_getAssociatedObject(self, UITextFieldShouldClearKey);
}
- (void)setShouldClearBlock:(BOOL (^)(CommonTextField *textField))shouldClearBlock
{
    [self setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, UITextFieldShouldClearKey, shouldClearBlock, OBJC_ASSOCIATION_COPY);
}


#pragma mark control method
- (void)setDelegateIfNoDelegateSet
{
    if (self.delegate != (id<UITextFieldDelegate>)[self class]) {
        objc_setAssociatedObject(self, UITextFieldDelegateKey, self.delegate, OBJC_ASSOCIATION_ASSIGN);
        self.delegate = (id<UITextFieldDelegate>)[self class];
    }
}

#pragma mark - others
NSString *RCCOMMON_TEXTLIMIT_NUM = @"0123456789-";
NSString *RCCOMMON_TEXTLIMIT_WORD = @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz .";

//ShouldChangeCharactersInRangeBlock中调用 限制文本输入语法
- (BOOL)limitTextFieldContent:(NSString *)string type:(NSString *)type
{
    NSCharacterSet *cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:type] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basic = [string isEqualToString:filtered];

    return basic;
}

- (BOOL)limitTextFieldContentToNum:(NSString *)string
{
    return [self limitTextFieldContent:string type:RCCOMMON_TEXTLIMIT_NUM];
};

@end
