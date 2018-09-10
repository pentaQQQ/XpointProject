//
//  IdentificationController.h
//  TPAPP
//
//  Created by Frank on 2018/8/22.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import <CFNetwork/CFNetwork.h>
#import <Foundation/Foundation.h>
enum {
    kSendBufferSize = 32768
};

@interface IdentificationController : BaseViewController<NSStreamDelegate>
{
    uint8_t _buffer[kSendBufferSize];
}
@end
