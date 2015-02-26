//
//  ViewController.m
//  AcronymFinder
//
//  Created by SHASHANKT on 25/02/15.
//  Copyright (c) 2015 personal. All rights reserved.
//

#import "ViewController.h"

#define URL_WITH_QUERY(QUERY) [NSString stringWithFormat:@"http://www.nactem.ac.uk/software/acromine/dictionary.py/?sf=%@",QUERY]

static NSString* cellIdentifier = @"cell";


@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
	
	self.manager = [AFHTTPRequestOperationManager manager];
	self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
  [self.resultsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
	self.resultsArray = [NSMutableArray array];
 }

# pragma mark - UISearchBar Methods

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
	[self.view endEditing:YES];
	NSString *searchURL = URL_WITH_QUERY(searchBar.text);
	[self shouldDisplayIndicator:YES];
	
	__weak typeof(self) weakSelf = self;
	[self.manager GET:searchURL parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary*responseObject) {
		[weakSelf shouldDisplayIndicator:NO];
		if ([responseObject count]) {
			NSArray *responseArray = [[NSArray arrayWithArray:[[responseObject valueForKey:@"lfs"]valueForKey:@"lf"]]objectAtIndex:0];
			self.resultsArray = [NSMutableArray arrayWithArray:responseArray];
			[self.resultsTableView reloadData];
 		}
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		[weakSelf shouldDisplayIndicator:NO];
	}];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
	if (searchText.length == 0) {
		[self.resultsArray removeAllObjects];
		[self.resultsTableView reloadData];
	}
}

# pragma mark - UITableView Methods
- (NSInteger)tableView:(UITableView *)tableview numberOfRowsInSection:(NSInteger)section {
	return [self.resultsArray count];
}

-(UITableViewCell *)tableView: (UITableView *)tableview cellForRowAtIndexPath:(NSIndexPath *)indexpath {
	
	UITableViewCell *cell =[tableview dequeueReusableCellWithIdentifier:cellIdentifier];
	if (self.resultsArray) {
	 cell.textLabel.text = [self.resultsArray objectAtIndex:indexpath.row];
	}
  return cell;
}

- (void)shouldDisplayIndicator: (BOOL)display {
	if (display) {
		[MBProgressHUD showHUDAddedTo:self.view animated:NO];
	} else {
		[MBProgressHUD hideHUDForView:self.view animated:NO];
	}
}

@end
