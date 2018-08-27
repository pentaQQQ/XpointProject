//
//  QuestionDeatailCell.m
//  TPAPP
//
//  Created by Frank on 2018/8/27.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//
#define image_width (kScreenWidth-40-40*6)/5
#import "QuestionDeatailCell.h"

@implementation QuestionDeatailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.myTextView = [[UITextView alloc] init];
//    self.myTextView.backgroundColor = colorWithRGB(0xEEEEEE);
    [self.contentView addSubview:self.myTextView];
    self.myTextView.tag = 100;
    UILabel *placeHolderLabel = [[UILabel alloc] init];
    placeHolderLabel.text = @"相关问题描述:";
    placeHolderLabel.numberOfLines = 0;
    placeHolderLabel.textColor = [UIColor lightGrayColor];
    [placeHolderLabel sizeToFit];
    [self.myTextView addSubview:placeHolderLabel];
    self.myTextView.font = [UIFont systemFontOfSize:14.f];
    placeHolderLabel.font = [UIFont systemFontOfSize:14.f];
    [self.myTextView setValue:placeHolderLabel forKey:@"_placeholderLabel"];
    self.myTextView.sd_layout
    .topSpaceToView(self.contentView, 0)
    .leftSpaceToView(self.contentView, 20)
    .widthIs(kScreenWidth-40)
    .heightIs(100);
    
    self.cameraBtn = [[UIButton alloc] init];
    self.cameraBtn.tag = 110;
    self.cameraBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.cameraBtn setImage:[UIImage imageNamed:@"camera"] forState:UIControlStateNormal];
    [self.cameraBtn addTarget:self action:@selector(applyBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.cameraBtn];
    self.cameraBtn.sd_layout
    .bottomSpaceToView(self.contentView, 20)
    .leftSpaceToView(self.contentView, 20)
    .widthIs(30)
    .heightIs(30);
    
}
- (void)configWithImage:(UIImage *)image
{
    
    if (self.imagesNumber == 6) {
        self.cameraBtn.userInteractionEnabled = NO;
        return;
    }
    self.imagesNumber++;
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(20+((40+image_width)*(self.imagesNumber-1)), 117.5, 40,50)];
    imageview.image = image;
    imageview.tag = self.imagesNumber-1;
    [self.contentView addSubview:imageview];
//    imageview.sd_layout
//    .topSpaceToView(self.myTextView, 17.5)
//    .leftSpaceToView(self.contentView, 20+((40+image_width)*(self.imagesNumber-1)))
//    .widthIs(40)
//    .heightIs(50);
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20+40-7.5+((40+image_width)*(self.imagesNumber-1)), 110, 15,15)];
    btn.tag = self.imagesNumber-1;
    [btn setImage:[UIImage imageNamed:@"delete_image"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(deletetnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:btn];
//    btn.sd_layout
//    .topSpaceToView(self.myTextView, 10)
//    .leftSpaceToView(self.contentView, 20+40-7.5+((40+image_width)*(self.imagesNumber-1)))
//    .widthIs(15)
//    .heightIs(15);
}
- (void)deletetnAction:(UIButton*)btn
{
    NSInteger tag = btn.tag;
    [btn removeFromSuperview];
    for (UIImageView* subView in self.contentView.subviews)
    {
        if (subView.tag == tag) {
            [subView removeFromSuperview];
        }
    }
    self.imagesNumber --;
    self.cameraBtn.userInteractionEnabled = YES;
    if (tag == 0) {
        for (UIImageView * subView in self.contentView.subviews)
        {
            if ([subView isKindOfClass:[UIImageView class]]) {
                if (subView.tag == 1) {
                                    subView.tag = 0;
                    [self changeWithIamgeView:subView withNumber:0];
                }else if (subView.tag == 2){
                                    subView.tag = 1;
                    [self changeWithIamgeView:subView withNumber:1];
                }else if (subView.tag == 3){
                                    subView.tag = 2;
                    [self changeWithIamgeView:subView withNumber:2];
                }else if (subView.tag == 4){
                                    subView.tag = 3;
                    [self changeWithIamgeView:subView withNumber:3];
                }else if (subView.tag == 5){
                                    subView.tag = 4;
                    [self changeWithIamgeView:subView withNumber:4];
                }
            }
            
        }

        for (UIButton* subView in self.contentView.subviews)
        {
            if ([subView isKindOfClass:[UIButton class]]) {
                if (subView.tag == 1) {
                                    subView.tag = 0;
                    [self changeWithBtn:subView withNumber:0];
                }else if (subView.tag == 2){
                                    subView.tag = 1;
                    [self changeWithBtn:subView withNumber:1];
                }else if (subView.tag == 3){
                                    subView.tag = 2;
                    [self changeWithBtn:subView withNumber:2];
                }else if (subView.tag == 4){
                                    subView.tag = 3;
                    [self changeWithBtn:subView withNumber:3];
                }else if (subView.tag == 5){
                                    subView.tag = 4;
                    [self changeWithBtn:subView withNumber:4];
                }
            }

        }
        
    }else if (tag == 1) {
        
        
        for (UIImageView * subView in self.contentView.subviews)
        {
            if ([subView isKindOfClass:[UIImageView class]]) {
                if (subView.tag == 2){
                    subView.tag = 1;
                    [self changeWithIamgeView:subView withNumber:1];
                }else if (subView.tag == 3){
                    subView.tag = 2;
                    [self changeWithIamgeView:subView withNumber:2];
                }else if (subView.tag == 4){
                    subView.tag = 3;
                    [self changeWithIamgeView:subView withNumber:3];
                }else if (subView.tag == 5){
                    subView.tag = 4;
                    [self changeWithIamgeView:subView withNumber:4];
                }
            }
            
        }
        
        for (UIButton* subView in self.contentView.subviews)
        {
            if ([subView isKindOfClass:[UIButton class]]) {
                if (subView.tag == 2){
                    subView.tag = 1;
                    [self changeWithBtn:subView withNumber:1];
                }else if (subView.tag == 3){
                    subView.tag = 2;
                    [self changeWithBtn:subView withNumber:2];
                }else if (subView.tag == 4){
                    subView.tag = 3;
                    [self changeWithBtn:subView withNumber:3];
                }else if (subView.tag == 5){
                    subView.tag = 4;
                    [self changeWithBtn:subView withNumber:4];
                }
            }
            
        }
       
    }else if (tag == 2) {
        for (UIImageView * subView in self.contentView.subviews)
        {
            if ([subView isKindOfClass:[UIImageView class]]) {
               if (subView.tag == 3){
                    subView.tag = 2;
                    [self changeWithIamgeView:subView withNumber:2];
                }else if (subView.tag == 4){
                    subView.tag = 3;
                    [self changeWithIamgeView:subView withNumber:3];
                }else if (subView.tag == 5){
                    subView.tag = 4;
                    [self changeWithIamgeView:subView withNumber:4];
                }
            }
            
        }
        
        for (UIButton* subView in self.contentView.subviews)
        {
            if ([subView isKindOfClass:[UIButton class]]) {
                if (subView.tag == 3){
                    subView.tag = 2;
                    [self changeWithBtn:subView withNumber:2];
                }else if (subView.tag == 4){
                    subView.tag = 3;
                    [self changeWithBtn:subView withNumber:3];
                }else if (subView.tag == 5){
                    subView.tag = 4;
                    [self changeWithBtn:subView withNumber:4];
                }
            }
            
        }
        
    }else if (tag == 3) {
        for (UIImageView * subView in self.contentView.subviews)
        {
            if ([subView isKindOfClass:[UIImageView class]]) {
                if (subView.tag == 4){
                    subView.tag = 3;
                    [self changeWithIamgeView:subView withNumber:3];
                }else if (subView.tag == 5){
                    subView.tag = 4;
                    [self changeWithIamgeView:subView withNumber:4];
                }
            }
            
        }
        
        for (UIButton* subView in self.contentView.subviews)
        {
            if ([subView isKindOfClass:[UIButton class]]) {
                if (subView.tag == 4){
                    subView.tag = 3;
                    [self changeWithBtn:subView withNumber:3];
                }else if (subView.tag == 5){
                    subView.tag = 4;
                    [self changeWithBtn:subView withNumber:4];
                }
            }
            
        }
        
    }else if (tag == 4) {
        for (UIImageView * subView in self.contentView.subviews)
        {
            if ([subView isKindOfClass:[UIImageView class]]) {
                if (subView.tag == 5){
                    subView.tag = 4;
                    [self changeWithIamgeView:subView withNumber:4];
                }
            }
            
        }
        
        for (UIButton* subView in self.contentView.subviews)
        {
            if ([subView isKindOfClass:[UIButton class]]) {
               if (subView.tag == 5){
                    subView.tag = 4;
                    [self changeWithBtn:subView withNumber:4];
                }
            }
            
        }
        
    }
   
}
-(void)changeWithIamgeView:(UIImageView *)imageView withNumber:(NSInteger)number
{
   imageView.frame =  CGRectMake(20+((40+image_width)*number), 117.5, 40,50);

}

-(void)changeWithBtn:(UIButton *)btn withNumber:(NSInteger)number
{
    btn.frame =  CGRectMake(20+40-7.5+((40+image_width)*number), 110, 15,15);

}

- (void)applyBtnAction
{
    self.selectCameraBlock(self);
}
#pragma mark-字体宽度自适应
- (CGFloat)widthLabelWithModel:(NSString *)titleString withFont:(NSInteger)font
{
    CGSize size = CGSizeMake(self.contentView.bounds.size.width, MAXFLOAT);
    CGRect rect = [titleString boundingRectWithSize:size options:NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:font]} context:nil];
    return rect.size.width+5;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
