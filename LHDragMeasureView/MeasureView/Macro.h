//
//  Macro.h
//  LHDragMeasureView
//
//  Created by liuzhihua on 2019/1/2.
//  Copyright © 2019 TouchPal. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

#define LHColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]/// rgb颜色转换（16进制->10进制）

#define LHScreenWidth [UIScreen mainScreen].bounds.size.width

#define LHScreenHeight [UIScreen mainScreen].bounds.size.height

#define LHSTR_FORMAT(format, ...)         [NSString stringWithFormat:(format), ##__VA_ARGS__]

#define WEAK_SELF       __weak      typeof(self) weakSelf = self  ;

#endif /* Macro_h */
