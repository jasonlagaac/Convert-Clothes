//
//  MensViewController.h
//  clothingConverter
//
//  Created by Jason Lagaac on 13/05/10.
//  Copyright Jason Lagaac 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kItemComponent			0
#define kSizeSystemComponent	1
#define kSizeComponent			2

// Positioning values for labels
#define NEW_OUTPUT_ROW			0


@interface MensViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
	//UI Elements
	UIPickerView *categoryPicker;
	UIToolbar *categoryPickerToolbar;
	UILabel *selectedFields;
	
	// Button for Conversion
	UIButton *convertButton;
	
	// List of Categories
	NSArray	*category;
	
	// List of Mens Shirt Sizes
	NSDictionary *shirtSizesList;
	
	// List of Men Shoe Sizes
	NSDictionary *shoeSizesList;
	
	// List of Men Pant Sizes
	NSDictionary *pantSizesList;
	
	// List of Mens Coat Sizes
	NSDictionary *coatSizesList;
	
	// Item Sizing System and Sizes
	NSString *itemSelected;
	NSArray *itemSizeSystem;
	NSArray *itemSizes;
	
	// Dictionary for Converted Sizes
	NSMutableDictionary *convertedItems;
	
	// Array of Image Items for Display
	UILabel *sizesDisplayed[10];
	NSMutableDictionary *flagsDisplayed;
}

@property (nonatomic, retain) IBOutlet UIPickerView *categoryPicker;
@property (nonatomic, retain) IBOutlet UIToolbar *categoryPickerToolbar;
@property (nonatomic, retain) IBOutlet UILabel *selectedFields;
@property (nonatomic, retain) IBOutlet UIButton *convertButton;


@property (nonatomic, retain) NSArray *category;

@property (nonatomic, retain) NSDictionary *shirtSizesList;
@property (nonatomic, retain) NSDictionary *shoeSizesList;
@property (nonatomic, retain) NSDictionary *pantSizesList;
@property (nonatomic, retain) NSDictionary *coatSizesList;


@property (nonatomic, retain) NSMutableDictionary *convertedItems;

@property (nonatomic, retain) NSString *itemSelected;
@property (nonatomic, retain) NSArray *itemSizeSystem;
@property (nonatomic, retain) NSArray *itemSizes;

@property (nonatomic, retain) NSMutableDictionary *flagsDisplayed;

//Swap Category Lists Functions;
-(void)categoryListSwitch:(NSString *)selectedCategory
			  selectedRow:(NSInteger)row;

-(void)convertSizes:(NSInteger)SystemRow
	   selectedSize:(NSInteger)SizeRow;

// Display and Clear Values Functions
-(void)displayValues;
-(void)clearValues;

// Display and Clear Flags Functions
-(void)loadFlags;
-(void)displayFlags;
-(void)clearFlags;


// IBAction definitions
-(IBAction)buttonPressed:(id)sender;
-(IBAction)pickerCompleted:(id)sender;
-(IBAction)pickerCancel:(id)sender;

@end
