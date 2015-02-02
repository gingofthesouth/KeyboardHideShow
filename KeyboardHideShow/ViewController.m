//
//  ViewController.m
//  KeyboardHideShow
//
//  Created by Ernest Cunningham on 2/02/15.
//  Copyright (c) 2015 Icy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize tableItemArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // INitialise the Table view data array
    tableItemArray = [[NSMutableArray alloc] initWithObjects:@"Hello", @"World", nil];
    
    // Register for Keyboard Notifications
    [self registerForKeyboardNotifications];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TextField Delegate methods


-(BOOL)textFieldShouldReturn:(UITextField*)textField;
{
    [textField resignFirstResponder];
    
    return NO; // We do not want UITextField to insert line-breaks.
}

#pragma mark - Keyboard delegate methods

// Call this method somewhere in your view controller setup code.
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}
// Called when the UIKeyboardDidShowNotification is sent.
// Slightly modified version of this: http://stackoverflow.com/a/16044603/4518324
- (void)keyboardWasShown:(NSNotification *)note {
    NSDictionary *userInfo = note.userInfo;
    NSTimeInterval duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve curve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    CGRect keyboardFrameEnd = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    keyboardFrameEnd = [self.view convertRect:keyboardFrameEnd fromView:nil];
    
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionBeginFromCurrentState | curve animations:^{
        self.view.frame = CGRectMake(0, 0, keyboardFrameEnd.size.width, keyboardFrameEnd.origin.y);
    } completion:nil];
    
    // Scroll to the bottom of the table view
    NSIndexPath* ipath = [NSIndexPath indexPathForRow: [tableItemArray count] -1 inSection:0];
    [chatTableView scrollToRowAtIndexPath: ipath atScrollPosition: UITableViewScrollPositionTop animated: YES];
}

- (void)keyboardWillBeHidden:(NSNotification *)note {
    NSDictionary *userInfo = note.userInfo;
    NSTimeInterval duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve curve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    CGRect keyboardFrameEnd = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    keyboardFrameEnd = [self.view convertRect:keyboardFrameEnd fromView:nil];
    
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionBeginFromCurrentState | curve animations:^{
        self.view.frame = CGRectMake(0, 0, keyboardFrameEnd.size.width, keyboardFrameEnd.origin.y);
    } completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [tableItemArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *chatString = [tableItemArray objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"default"];
    cell.textLabel.text = chatString;
        
    return cell;
}
-(IBAction)submit
{
    // Get the current input
    NSString *chatLine = input.text;
    
    // If the input textField is empty, we can just return
    if ([chatLine isEqualToString:@""]) return;
    
    // Add it to the table array
    [tableItemArray addObject:chatLine];
    
    // Reload the table contents
    [chatTableView reloadData];
    
    // Clear the input field
    input.text = @"";
    
    // Scroll to the bottom
    NSIndexPath* ipath = [NSIndexPath indexPathForRow: [tableItemArray count] -1 inSection:0];
    [chatTableView scrollToRowAtIndexPath: ipath atScrollPosition: UITableViewScrollPositionTop animated: YES];
}

@end
