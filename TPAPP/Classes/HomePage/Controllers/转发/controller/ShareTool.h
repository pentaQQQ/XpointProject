//
//  ShareTool.h
//  dsaf
//
//  Created by 陈志超 on 2016/12/7.
//  Copyright © 2016年 huaban. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ShareTool : NSObject

- (void)shareWithItems:(NSMutableArray*)items completionHandler:(UIActivityViewControllerCompletionHandler)completionHandler;



@end
