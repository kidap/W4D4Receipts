//
//  AddReceiptViewController.m
//  W4D4Receipts
//
//  Created by Karlo Pagtakhan on 03/31/2016.
//  Copyright © 2016 AccessIT. All rights reserved.
//

#import "AddReceiptViewController.h"
#import "CoreDateHandler.h"
#import "Tag.h"

@interface AddReceiptViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *receiptAmount;
@property (strong, nonatomic) IBOutlet UITextView *receiptDescription;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray<Tag *> *sourceArray;


@end

@implementation AddReceiptViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  [self prepareView];
  
}
-(void)prepareView{
  [self.datePicker setDatePickerMode:UIDatePickerModeDate];
  self.tableView.delegate = self;
  self.tableView.dataSource = self;
  [self.tableView setAllowsMultipleSelection:YES];
  self.sourceArray = [[[CoreDataHandler sharedInstance] getAllTags] mutableCopy];
  self.receiptDescription.delegate = self;
  
  //Set borders
  self.receiptAmount.layer.borderWidth  = 0.5;
  self.receiptAmount.layer.borderColor  = [UIColor lightGrayColor].CGColor;
  self.receiptAmount.layer.cornerRadius  = 5.0;
  self.receiptDescription.layer.borderWidth  = 0.5;
  self.receiptDescription.layer.borderColor  = [UIColor lightGrayColor].CGColor;
  self.receiptDescription.layer.cornerRadius  = 5.0;
  [self.receiptDescription setTextColor:[UIColor lightGrayColor]];
}
//MARK: Actions
- (IBAction)saveButton:(id)sender {
  double amount = [self.receiptAmount.text doubleValue];
  NSString *timestamp = [self.datePicker.date description];
  
  //Tag *newTag = [[CoreDataHandler sharedInstance] createTagWithName:@"Test Tag"];
  
  NSMutableSet *addTags = [[NSMutableSet alloc] init];
  for (NSIndexPath *indexPath in self.tableView.indexPathsForSelectedRows){
    [addTags addObject:self.sourceArray[indexPath.row]];
  }
  [[CoreDataHandler sharedInstance] addReceiptWithAmount: amount
                                                    note:self.receiptDescription.text
                                               timestamp:timestamp
                                                    tags:addTags];
  [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)cancelButton:(id)sender {
  [self dismissViewControllerAnimated:YES completion:nil];
}
//MARK: TableView delegate, datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  return self.sourceArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TagCell" forIndexPath:indexPath];
  cell.textLabel.text = self.sourceArray[indexPath.row].tagName;
  return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
  cell.textLabel.text = self.sourceArray[indexPath.row].tagName;
  cell.accessoryType = UITableViewCellAccessoryCheckmark;
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
  UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
  cell.textLabel.text = self.sourceArray[indexPath.row].tagName;
  cell.accessoryType = UITableViewCellAccessoryNone;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
  return @"Category";
}

//MARK: TextField/TextView delegate
-(void)textViewDidBeginEditing:(UITextView *)textView{
  textView.text = @"";
  [textView setTextColor:[UIColor blackColor]];
}

@end
