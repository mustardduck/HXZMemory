//Copyright (c) 2014年 Abyss Roger.
//@ roger_ren@qq.com



#pragma mark - GCD
#define GCD_BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define GCD_MAIN(block) dispatch_async(dispatch_get_main_queue(),block)

#pragma mark - OBJC


#pragma mark - BLOCK
//BLOCK

#define BLOCK_REPONSE_VOID ^(void)
#define BLOCK_GET_SEALF(_class) BLOCK_GET_CLASS(_class,self)
#define BLOCK_GET_DELEGATE(_class) BLOCK_GET_CLASS(_class,_delegate)
#define BLOCK_GET_CLASS(_class,_objct) __block _class *blockself = _objct

#pragma mark - INSTANCE
//INSTANCE


#define INSTANCE_INIT() [super init]
#define INSTANCE_INIT_FRAME() [super initWithFrame:frame]
#define INSTANCE_INIT_CODER() [super initWithCoder:aDecoder]
#define INSTANCE_SETUP() if (self) [self setup]
#define INSTANCE_SETUP_WITHPARA(para) if (self) [self setup:para]

#define INSTANCE_CLASS_SETUP(class) \
class\
- (instancetype)initWithFrame:(CGRect)frame\
{\
self = INSTANCE_INIT_FRAME();\
INSTANCE_SETUP();\
return self;\
}\
- (instancetype)initWithCoder:(NSCoder *)aDecoder\
{\
self = INSTANCE_INIT_CODER();\
INSTANCE_SETUP();\
return self;\
}\
- (instancetype)init\
{\
self = INSTANCE_INIT();\
INSTANCE_SETUP();\
return self;\
}
