//
//  ViewController.m
//  Acronyms
//
//  Created by Nikunj on 07/03/16.
//  Copyright © 2016 Nikunj Bhagat. All rights reserved.
//

#import "ViewController.h"
#import "WebServiceManager.h"
#import "MBProgressHUD.h"

@interface ViewController () <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    __block NSArray *arrayDataToDisplay;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textfieldAcronym.delegate = self;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    // Tell the keyboard where to go on next / go button.
    if(textField == self.textfieldAcronym)
    {
        [self buttonSearchPressed:self];
    }
    
    return YES;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arrayDataToDisplay.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    UILabel *label =  [cell viewWithTag:1];
    label.text = arrayDataToDisplay[indexPath.row];
    
    return cell;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonSearchPressed:(id)sender {
    
    [self.textfieldAcronym resignFirstResponder];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.label.text = NSLocalizedString(@"Fetching...", @"");
    
    NSString* textToSearch = [self.textfieldAcronym.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    [WebServiceManager fetchFullFormForAcronym:textToSearch withResponse:^(NSArray *arrayData) {
       
        arrayDataToDisplay = arrayData;

        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hideAnimated:YES];
            [self.tableviewResults reloadData];
            
            if (arrayDataToDisplay.count==0) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"No results !" message:@"There are no results for this acronym" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            
            
        });
        NSLog(@"arrayData  = %@",[arrayData description]);
    }];
    
}
@end
