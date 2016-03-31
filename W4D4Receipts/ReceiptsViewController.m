//
//  ReceiptsViewController.m
//  W4D4Receipts
//
//  Created by Karlo Pagtakhan on 03/31/2016.
//  Copyright © 2016 AccessIT. All rights reserved.
//

#import "ReceiptsViewController.h"
#import "CoreDateHandler.h"
#import "Receipt.h"
#import "Tag.h"

static NSString *defaultCurrency = @"$";

@interface ReceiptsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray<Tag *> *sourceArray;
@property (strong, nonatomic) IBOutlet UIButton *addCategoryButton;
@property (strong, nonatomic) IBOutlet UIButton *addReceiptButton;
@end

@implementation ReceiptsViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  [self prepareView];
}
-(void)viewDidAppear:(BOOL)animated{
  [self.sourceArray removeAllObjects];
  [self.sourceArray addObjectsFromArray:[[CoreDataHandler sharedInstance] getAllTags]];
  [self.tableView reloadData];
}
//MARK: Preparation
-(void)prepareView{
  self.sourceArray = [NSMutableArray new];
  self.tableView.delegate = self;
  self.tableView.dataSource = self;
  
  self.addCategoryButton.layer.borderWidth  = 0.5;
  self.addCategoryButton.layer.borderColor  = [UIColor lightGrayColor].CGColor;
  self.addCategoryButton.layer.cornerRadius  = 5.0;
  self.addReceiptButton.layer.borderWidth  = 0.5;
  self.addReceiptButton.layer.borderColor  = [UIColor lightGrayColor].CGColor;
  self.addReceiptButton.layer.cornerRadius  = 5.0;
  [self.addReceiptButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}
//MARK: Table view
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  return self.sourceArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  return self.sourceArray[section].receipts.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReceiptCell" forIndexPath:indexPath];
  
  NSSet *receipts = self.sourceArray[indexPath.section].receipts;
  NSArray<Receipt *> *receiptsArray = [receipts allObjects];
  
  cell.textLabel.text = receiptsArray[indexPath.row].note;
  cell.detailTextLabel.text = [NSString stringWithFormat:@"%@%@",defaultCurrency,[@(receiptsArray[indexPath.row].amount) stringValue]];
  return cell;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
  return self.sourceArray[section].tagName;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    NSSet *receipts = self.sourceArray[indexPath.section].receipts;
    NSArray<Receipt *> *receiptsArray = [receipts allObjects];
    [[CoreDataHandler sharedInstance] deleteReceipt:receiptsArray[indexPath.row]];
//    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView reloadData];
  }
}
//MARK:Actions
- (IBAction)addCategoryButtonTapped:(id)sender {
  UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Add a new Category" message:@"Enter category name" preferredStyle:UIAlertControllerStyleAlert];
  //Add text field
  [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
    //do nothing
  }];
  //Add ok button
  [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    [[CoreDataHandler sharedInstance] createTagWithName:alertController.textFields[0].text];
    [self.tableView reloadData];
  }]];
  //Add cancel button
  [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    //do nothing
  }]];
  
  [self presentViewController:alertController animated:YES completion:nil];
  
}


@end
