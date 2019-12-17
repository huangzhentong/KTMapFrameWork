//
//  KTModel.h
//  KTMapFrameWork_Example
//
//  Created by KT--stc08 on 2019/12/17.
//  Copyright © 2019 181310067@qq.com. All rights reserved.
//

#ifndef KTModel_h
#define KTModel_h


#endif /* KTModel_h */
//
//  KTModel.h
//  KTModel <https://github.com/ibireme/KTModel>
//
//  Created by ibireme on 15/5/10.
//  Copyright (c) 2015 ibireme.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import <Foundation/Foundation.h>

#if __has_include(<KTModel/KTModel.h>)
FOUNDATION_EXPORT double KTModelVersionNumber;
FOUNDATION_EXPORT const unsigned char KTModelVersionString[];
#import <KTModel/NSObject+KTModel.h>
#import <KTModel/KTClassInfo.h>
#else
#import "NSObject+KTModel.h"
#import "KTClassInfo.h"
#endif
