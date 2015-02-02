//
//  ViewController.h
//  KeyboardHideShow
//
//  Created by Ernest Cunningham on 2/02/15.
//  Copyright (c) 2015 Icy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate>
{
    IBOutlet UITextField        *input;
    IBOutlet UITableView        *chatTableView;
}

@property (nonatomic, strong) NSMutableArray *tableItemArray;

-(IBAction)submit;

@end

