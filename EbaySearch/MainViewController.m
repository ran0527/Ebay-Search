//
//  MainViewController.m
//  EbaySearch
//
//  Created by Xinran on 4/25/15.
//  Copyright (c) 2015 self.edu. All rights reserved.
//

#import "MainViewController.h"
#import "ResultTableViewController.h"
#import "AFNetworking.h"
#import "UIViewController+Toast.h"

@interface MainViewController ()

- (IBAction)search:(id)sender;
- (IBAction)clear:(id)sender;
@property (strong, nonatomic) NSArray *resultArray;
@property (strong, nonatomic) NSDictionary *jsonObj;
@property (strong, nonatomic) IBOutlet UITextField *keywordTextField;
@property (strong, nonatomic) IBOutlet UITextField *priceFromTextField;
@property (strong, nonatomic) IBOutlet UITextField *priceToTextField;

@property (readwrite, nonatomic) NSString *fromPrice;
@property (readwrite, nonatomic) NSString *toPrice;
@property (readwrite, nonatomic) NSString *keyword;
@property (readwrite, nonatomic) NSString *sort;

@property (strong, nonatomic) IBOutlet UILabel *warningLabel;

@property (strong, nonatomic) IBOutlet UIPickerView *sortPicker;
@property (strong, nonatomic) NSArray *sortKeyArray;
@property (strong, nonatomic) NSArray *sortValueArray;
@property (weak, nonatomic) IBOutlet UILabel *headingLabel;


@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.sortKeyArray = @[@"Best Match",@"Price: highest first",@"Price+Shipping:highest first", @"Price+Shipping:lowest first"];
    self.sortValueArray = @[@"BestMatch", @"CurrentPriceHighest", @"PricePlusShippingHighest", @"PricePlusShippingLowest"];
    
    self.sortPicker.delegate = self;
    self.sortPicker.dataSource = self;
    self.headingLabel.font = [UIFont boldSystemFontOfSize:17];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)search:(id)sender {
    static BOOL isProcessing = FALSE;
    if (isProcessing) {
        return;
    } else {
        isProcessing = TRUE;
    }
    
    NSString *warning = [self validate];
    if (warning) {
        self.warningLabel.text = warning;
        isProcessing = FALSE;
        return;
    } else {
        self.warningLabel.text = @"";
    }
    
    NSString *urlString = [self constructUrl];
    NSLog(@"requesting URL: %@", urlString);
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.jsonObj = (NSDictionary *)responseObject;
        NSLog(@"json: %@", self.jsonObj);
        NSMutableArray *objArray = [NSMutableArray array];
        if ([self.jsonObj[@"ack"] isEqualToString: @"Success"]) {
            for (int i = 0; i < 5; i++) {
                NSString *key = [NSString stringWithFormat:@"item%d", i];
                if (!self.jsonObj[key]) {
                    break;
                }
                [objArray addObject:self.jsonObj[key]];
            }
        }
        self.resultArray = [objArray copy];
        if (objArray.count > 0) {
            [self performSegueWithIdentifier:@"showResult" sender:self];
        } else {
            self.warningLabel.text = @"No Result";
        }
        isProcessing = FALSE;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // TODO: error
        isProcessing = FALSE;
    }];

    [operation start];
}

- (NSString *)constructUrl {
    NSString *url = @"http://shihaha.elasticbeanstalk.com/HW8.php?submit=Search&page=5&page_number=1";
    if (self.fromPrice) {
        url = [url stringByAppendingString:[NSString stringWithFormat:@"&minprice=%@", self.fromPrice]];
    }
    
    if (self.toPrice) {
        url = [url stringByAppendingString:[NSString stringWithFormat:@"&maxprice=%@", self.toPrice]];
    }
    
    if (self.keyword) {
        NSString *escapedKeyword = [self.keyword stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
        url = [url stringByAppendingString:[NSString stringWithFormat:@"&keywords=%@", escapedKeyword]];
    }
    
    if (self.sort) {
        url = [url stringByAppendingString:[NSString stringWithFormat:@"&sort=%@", self.sort]];
    }
    
    return url;
}

- (IBAction)clear:(id)sender {
    self.keywordTextField.text = @"";
    self.priceFromTextField.text = @"";
    self.priceToTextField.text = @"";
    self.warningLabel.text = @"";
    [self.sortPicker selectRow:0 inComponent:0 animated:YES];
}

- (NSString *)validate {
    self.fromPrice = nil;
    self.toPrice = nil;
    self.keyword = nil;
    self.sort = nil;
    
    if ([self.keywordTextField.text length] == 0) {
        return @"Please enter a keyword";
    }
    
    self.keyword = self.keywordTextField.text;
    
    if ([self.priceFromTextField.text length] != 0) {
        NSScanner *scanner = [NSScanner scannerWithString:self.priceFromTextField.text];
        BOOL isNumeric = [scanner scanDecimal:NULL] && [scanner isAtEnd];
        if (!isNumeric) {
            return @"Please enter a valid min price";
        }
        
        double price = [self.priceFromTextField.text doubleValue];
        
        if (price < 0) {
            return @"Min price must not less than 0";
        }
        
        self.fromPrice = [[NSNumber numberWithDouble:price] stringValue];
    }
    
    if ([self.priceToTextField.text length] != 0) {
        NSScanner *scanner = [NSScanner scannerWithString:self.priceToTextField.text];
        BOOL isNumeric = [scanner scanDecimal:NULL] && [scanner isAtEnd];
        if (!isNumeric) {
            return @"Please enter a valid max price";
        }
        
        double price = [self.priceToTextField.text doubleValue];
        
        if (price < 0) {
            return @"Max price must not less than 0";
        }
        
        self.toPrice = [[NSNumber numberWithDouble:price] stringValue];
    }
    
    if (self.fromPrice && self.toPrice &&
        [self.fromPrice doubleValue] > [self.toPrice doubleValue]) {
        return @"max price must not be less than min price";
    }
    
    NSUInteger row = [self.sortPicker selectedRowInComponent:0];
    self.sort = self.sortValueArray[row];
    
    return nil;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString: @"showResult"]) {
        ResultTableViewController *controller = (ResultTableViewController *)segue.destinationViewController;
        controller.resultArray = self.resultArray;
        controller.keyword = self.keyword;
    }
}

#pragma mark - Picker View
// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return (int)self.sortKeyArray.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.sortKeyArray[row];
}

@end
