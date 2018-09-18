//
//  RootViewController.m
//  ComboDemo
//
//  Created by pengfeichen on 2018/9/18.
//  Copyright © 2018年 IGG. All rights reserved.
//

#import "RootViewController.h"

#import "PFMultiExtendController.h"

@interface RootViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataList;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self createData];
	[self.view addSubview:self.tableView];
}

- (void)createData {
	self.dataList = @[@"多行可伸缩UILabel"];
}

- (UITableView *)tableView {
	if (_tableView == nil) {
		CGRect frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
		_tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
		_tableView.delegate = self;
		_tableView.dataSource = self;
		[_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
	}
	
	return _tableView;
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *cellIdentifier = @"UITableViewCell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
	cell.textLabel.text = self.dataList[indexPath.row];
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	switch (indexPath.row) {
		case 0: {
			PFMultiExtendController *multiVC = [[PFMultiExtendController alloc] init];
			[self.navigationController pushViewController:multiVC animated:YES];
		}
			break;
			
		default:
			break;
	}
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
