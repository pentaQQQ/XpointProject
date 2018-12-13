//
//  QuestionDeatailCell.h
//  TPAPP
//
//  Created by Frank on 2018/8/27.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionDeatailCell : UITableViewCell
@property (nonatomic, strong)UITextView *myTextView;
@property (nonatomic, strong)UIButton *cameraBtn;
@property (nonatomic, strong)void (^selectCameraBlock)(QuestionDeatailCell*);
@property (nonatomic, strong)void (^textViewTextBlock)(NSString*);
@property (nonatomic, strong)void (^deleteImageBlock)(NSInteger);
@property (nonatomic, assign)NSInteger imagesNumber;
-(void)configWithImage:(UIImage *)image;
- (void)configWithModel:(ApplyReturnGoodsModel *)minModel;
@end
