//
//  SingletonMacro.h
//  QMS
//
//  Created by Angus on 12-6-4.
//  Copyright (c) 2012年 NMH. All rights reserved.
//

#import <Foundation/Foundation.h>



//单例宏
#define SINGLETON_INTERFACE(className) +(className*)sharedInstance




#define SINGLETON_IMPLE(className) \
                                    + (className *)sharedInstance {\
                                            static dispatch_once_t once;\
                                            static id instance;\
                                            dispatch_once(&once, ^{instance = self.new;});\
                                            return instance;\
                                        }



