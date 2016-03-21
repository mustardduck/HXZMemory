//
//  FastMacro.h
//  miaozhuan
//
//  Created by Abyss on 15-3-6.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#ifndef miaozhuan_FastMacro_h
#define miaozhuan_FastMacro_h

#define MTA_viewDidAppear(_sth) \
- (void)viewDidAppear:(BOOL)animated \
{ \
[super viewDidAppear:animated]; \
[APP_MTA MTA_page_beginFrom:NSStringFromClass([self class]) \
with:NSStringFromClass(self.superclass)]; \
_sth \
}

#define MTA_viewDidDisappear(_sth) \
- (void)viewDidDisappear:(BOOL)animated \
{ \
[super viewDidDisappear:animated]; \
[APP_MTA MTA_page_endFrom:NSStringFromClass([self class]) \
with:NSStringFromClass(self.superclass)]; \
_sth \
}

#endif
