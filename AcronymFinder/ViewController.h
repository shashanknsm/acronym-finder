//
//  ViewController.h
//  AcronymFinder
//
//  Created by SHASHANKT on 25/02/15.
//  Copyright (c) 2015 personal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking.h>
#import <MBProgressHUD.h>


@interface ViewController : UIViewController <UISearchBarDelegate,UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong,nonatomic) AFHTTPRequestOperationManager *manager;
@property (weak, nonatomic) IBOutlet UITableView *resultsTableView;
@property (strong,nonatomic) NSMutableArray *resultsArray;


@end

