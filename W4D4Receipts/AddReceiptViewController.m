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
@property (weak, nonatomic) IBOutlet UITextField *receiptAmount;
@property (weak, nonatomic) IBOutlet UITextView *receiptDescription;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (strong, nonatomic) NSMutableArray<Tag *> *sourceArray;


@end

@implementation AddReceiptViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  [self prepareView];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  [self.view endEditing:YES];
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
  
  self.cancelButton.layer.borderWidth  = 0.5;
  self.cancelButton.layer.borderColor  = [UIColor lightGrayColor].CGColor;
  self.cancelButton.layer.cornerRadius  = 5.0;
  self.saveButton.layer.borderWidth  = 0.5;
  self.saveButton.layer.borderColor  = [UIColor lightGrayColor].CGColor;
  self.saveButton.layer.cornerRadius  = 5.0;
  [self.cancelButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
  [self.saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
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
-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
  UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
  
    [header.contentView setBackgroundColor: [UIColor colorWithRed:0.004 green:0.255 blue:0.373 alpha:1]];
  [header.textLabel setTextColor:[UIColor colorWithRed:0.996 green:0.824 blue:0.047 alpha:1]];
}
//MARK: TextField/TextView delegate
-(void)textViewDidBeginEditing:(UITextView *)textView{
  textView.text = @"";
  [textView setTextColor:[UIColor blackColor]];
}

@end
