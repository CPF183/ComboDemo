//
//  PFMultiExtendController.m
//  ComboDemo
//
//  Created by pengfeichen on 2018/9/18.
//  Copyright © 2018年 IGG. All rights reserved.
//

#import "PFMultiExtendController.h"

@interface PFMultiExtendController ()

@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIButton *moreBtn;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) BOOL isExtend;

@end

@implementation PFMultiExtendController

static const CGFloat fontSize = 14; //字体大小
static const NSUInteger numberOfLines = 3; //行数
static const CGFloat lineSpace = 2.0f; //行间距

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self createViews];
	[self.view addSubview:self.contentLabel];
	[self.view addSubview:self.moreBtn];
}

- (UILabel *)contentLabel {
	if (_contentLabel == nil) {
		_contentLabel = [[UILabel alloc] init];
		_contentLabel.frame = CGRectMake(10.0f, 80.0f, [UIScreen mainScreen].bounds.size.width - 20, 0);
		_contentLabel.font = [UIFont systemFontOfSize:fontSize];
		_contentLabel.numberOfLines = numberOfLines;
		_contentLabel.attributedText = [self attributedStringFromStingWithFont:[UIFont systemFontOfSize:fontSize] withLineSpacing:lineSpace text:self.content];
	}
	
	return _contentLabel;
}

- (UIButton *)moreBtn {
	if (_moreBtn == nil) {
		_moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
		_moreBtn.frame = CGRectMake(10.0f, CGRectGetMaxY(self.contentLabel.frame), 80.0f, 20.0f);
		[_moreBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		_moreBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
		[_moreBtn setTitle:@"查看更多" forState:UIControlStateNormal];
		_moreBtn.hidden = YES;
		[_moreBtn addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
	}
	
	return _moreBtn;
}

- (void)createViews {
	self.view.backgroundColor = [UIColor whiteColor];
	self.title = @"多行可伸缩UILabel";
	self.content = @"jerkq;jfalerqopuvnoehqpofnqjef#";
	[self reloadViews];
}

- (void)moreBtnClick {
	self.isExtend = !self.isExtend;
	[self reloadViews];
}

- (void)reloadViews {
	CGFloat height = [self getStringHeight:self.content font:fontSize];
	//是否隐藏
	if (height <= [self maxNormalHeight]) {
		self.moreBtn.hidden = YES;
	} else {
		self.moreBtn.hidden = NO;
	}
	
	//文字状态更改
	if (self.isExtend) {
		[self.moreBtn setTitle:@"收起" forState:UIControlStateNormal];
	} else {
		[self.moreBtn setTitle:@"查看更多" forState:UIControlStateNormal];
	}
	
	//行数更改
	if (self.isExtend) {
		self.contentLabel.numberOfLines = 0;
	} else {
		self.contentLabel.numberOfLines = numberOfLines;
	}
	
	//高度改变
	CGFloat labelH = self.contentLabel.frame.size.height;
	if (height <= [self maxNormalHeight]) {
		labelH = height;
	} else {
		if (self.isExtend) {
			labelH = height + 20;
		} else {
			labelH = [self maxNormalHeight] + 20;
		}
	}
	
	self.contentLabel.frame = CGRectMake(self.contentLabel.frame.origin.x, self.contentLabel.frame.origin.y, self.contentLabel.frame.size.width, labelH);
	self.moreBtn.frame = CGRectMake(self.moreBtn.frame.origin.x, CGRectGetMaxY(self.contentLabel.frame), self.moreBtn.frame.size.width, self.moreBtn.frame.size.height);
}

//正常行数最大高度
- (CGFloat)maxNormalHeight {
	return  [[UIFont systemFontOfSize:fontSize] lineHeight] * numberOfLines + lineSpace * (numberOfLines - 1);
}

//高度计算
- (CGFloat)getStringHeight:(NSString *)string font:(CGFloat)fontSize {
	CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width - 20;
	CGSize maxSize = CGSizeMake(maxWidth, CGFLOAT_MAX);
	NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
	[paragraphStyle setLineSpacing:lineSpace];
	CGSize size = [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize],NSParagraphStyleAttributeName:paragraphStyle} context:nil].size;
	
	return size.height;
}

//富文本
- (NSMutableAttributedString *)attributedStringFromStingWithFont:(UIFont *)font
												 withLineSpacing:(CGFloat)lineSpacing
															text:(NSString *)text{
	NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName:font}];
	
	NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
	[paragraphStyle setLineSpacing:lineSpacing];
	[paragraphStyle setLineBreakMode:NSLineBreakByTruncatingTail]; //截断方式，"abcd..."
	[attributedStr addAttribute:NSParagraphStyleAttributeName
						  value:paragraphStyle
						  range:NSMakeRange(0, [text length])];
	
	return attributedStr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
