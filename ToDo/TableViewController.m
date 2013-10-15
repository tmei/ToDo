//
//  TableViewController.m
//  ToDo
//
//  Created by Z_ZyngaTesting on 10/12/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "TableViewController.h"
#import "TableViewCell.h"
#import "objc/runtime.h"

@interface TableViewController ()

@property (strong, nonatomic) NSMutableArray *cellArray;
@property (strong, nonatomic) UIBarButtonItem *addButtonItem;

@end

@implementation TableViewController

static char STRING_KEY;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.title = @"Not To Do";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    UINib *tableViewCellNib = [UINib nibWithNibName:@"TableViewCell" bundle:nil];
    [self.tableView registerNib:tableViewCellNib forCellReuseIdentifier:@"TableViewCell"];
    
    self.addButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(onAddButton)];
    self.navigationItem.rightBarButtonItem = self.addButtonItem;
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    self.cellArray = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.cellArray count];
}

- (TableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TableViewCell";
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textField.delegate = self;

    objc_setAssociatedObject(cell.textField, &STRING_KEY, indexPath, OBJC_ASSOCIATION_RETAIN);
    cell.textField.text = self.cellArray[[indexPath indexAtPosition:1]];
    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        // [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [self.cellArray removeObjectAtIndex:[indexPath indexAtPosition:1]];
        [tableView reloadData];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    NSUInteger fromIndex = [fromIndexPath indexAtPosition:1];
    NSUInteger toIndex = [toIndexPath indexAtPosition:1];
    
    [self.cellArray exchangeObjectAtIndex: fromIndex withObjectAtIndex: toIndex];
    [tableView reloadData];
}


// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}

- (void)onAddButton
{
    [self.cellArray addObject:@""];
    [self.tableView reloadData];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSIndexPath *indexPath = objc_getAssociatedObject(textField, &STRING_KEY);
    NSUInteger index = [indexPath indexAtPosition:1];
    [self.cellArray setObject:textField.text atIndexedSubscript:index];
    [self.tableView reloadData];
}

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
