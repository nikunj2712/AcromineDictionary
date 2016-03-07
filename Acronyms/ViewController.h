//
//  ViewController.h
//  Acronyms
//
//  Created by Nikunj on 07/03/16.
//  Copyright © 2016 Nikunj Bhagat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *textfieldAcronym;
@property (weak, nonatomic) IBOutlet UIButton *buttonSearch;

- (IBAction)buttonSearchPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *tableviewResults;

@end

