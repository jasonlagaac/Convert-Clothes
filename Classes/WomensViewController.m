//
//  WomensViewController.m
//  clothingConverter
//
//  Created by Jason Lagaac on 13/05/10.
//  Copyright Jason Lagaac 2010. All rights reserved.
//

#import "WomensViewController.h"


@implementation WomensViewController

@synthesize selectedFields;

@synthesize categoryPicker;
@synthesize categoryPickerToolbar;
@synthesize category;

@synthesize convertButton;

@synthesize clothingSizesList;
@synthesize shoeSizesList;
@synthesize braSizesList;
@synthesize pantSizesList;
@synthesize convertedItems;

@synthesize itemSelected;
@synthesize itemSizeSystem;
@synthesize itemSizes;

@synthesize flagsDisplayed;




// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	NSDictionary *tmpDictFile;
	
	NSBundle *bundle = [NSBundle mainBundle];
	
	UIImage *buttonImageNormal = [UIImage imageNamed:@"whiteButton.png"];
	UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:12 topCapHeight:0];
	[convertButton setBackgroundImage:stretchableButtonImageNormal forState:UIControlStateNormal];
	
	
	// Load plist dictionary files and define categories
	NSString *clothingPlistPath = [bundle pathForResource:@"womenClothingSizes" ofType:@"plist"];
	NSString *shoePlistPath = [bundle pathForResource:@"womenShoeSizes" ofType:@"plist"];
	NSString *braPlistPath = [bundle pathForResource:@"womenBraSizes" ofType:@"plist"];
	NSString *pantPlistPath = [bundle pathForResource:@"womenPantSizes" ofType:@"plist"];
	
	NSArray *itemCategories = [[NSArray alloc] initWithObjects:@"Clothes", @"Shoes", @"Bra", @"Pants",nil];
	
	self.category = itemCategories;
	[itemCategories release];
	
	// Initialise temporary dictionary for clothes.
	tmpDictFile = [[NSDictionary alloc] initWithContentsOfFile:clothingPlistPath];
	self.clothingSizesList = tmpDictFile;
	[tmpDictFile release];

	// Initialise temporary dictionary for shoes.
	tmpDictFile = [[NSDictionary alloc] initWithContentsOfFile:shoePlistPath];
	self.shoeSizesList = tmpDictFile;
	[tmpDictFile release];
	
	// Initialise temporary dictionary for bras
	tmpDictFile = [[NSDictionary alloc] initWithContentsOfFile:braPlistPath];
	self.braSizesList = tmpDictFile;
	[tmpDictFile release];
	
	// Initialise temporary dictionary for pants.
	tmpDictFile = [[NSDictionary alloc] initWithContentsOfFile:pantPlistPath];
	self.pantSizesList = tmpDictFile;
	[tmpDictFile release];
	
	// Initialise first "default" item which is Clothing
	self.itemSizeSystem = [self.clothingSizesList allKeys];
	itemSelected = @"Clothes";
	
	NSString *selectedSystem = [self.itemSizeSystem objectAtIndex:0];
	NSArray *array = [self.clothingSizesList objectForKey:selectedSystem]; 
	
	self.itemSizes = array;
	[self loadFlags];

}
	

-(IBAction)buttonPressed:(id)sender{
	[categoryPicker setHidden:NO];
	[categoryPickerToolbar setHidden:NO];

}

-(IBAction)pickerCompleted:(id)sender{
	[categoryPickerToolbar setHidden:YES];
	[categoryPicker setHidden:YES];
	
	//NSInteger itemSelectedRow = [categoryPicker selectedRowInComponent:kItemComponent];
	NSInteger systemSelectedRow = [categoryPicker selectedRowInComponent:kSizeSystemComponent];
	NSInteger sizeSelectedRow = [categoryPicker selectedRowInComponent:kSizeComponent];

	NSLog(@"%d", [flagsDisplayed retainCount]);
	
	[self clearValues];
	[self clearFlags];
	
	[self convertSizes:systemSelectedRow selectedSize:sizeSelectedRow];
	[self displayValues];
	[self displayFlags];

}

-(IBAction)pickerCancel:(id)sender{
	[categoryPickerToolbar setHidden:YES];
	[categoryPicker setHidden:YES];
}



- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
	NSLog(@"%d", [flagsDisplayed retainCount]);
    [super didReceiveMemoryWarning];
	
    
    // Release any cached data, images, etc that aren't in use.
	
}

- (void)viewDidUnload {
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	
	self.categoryPicker = nil;
	self.categoryPickerToolbar = nil;
	self.category = nil;
	
	self.clothingSizesList = nil;
	self.shoeSizesList = nil;
	self.braSizesList = nil;
	self.pantSizesList = nil;
	
	self.itemSizeSystem = nil;
	self.itemSizes = nil;
	self.itemSelected = nil;
	
	[super viewDidUnload];
}


- (void)dealloc {
	// Release items 
	
	[categoryPicker release];
	[categoryPickerToolbar release];
	
	[category release];
	
	[clothingSizesList release];
	[shoeSizesList release];
	[braSizesList release];
	[pantSizesList release];
	
	[itemSizeSystem release];
	
	[self clearValues];
	[self clearFlags];
	
	[flagsDisplayed release];
	
    [super dealloc];
}

#pragma mark -
#pragma mark Picker Data Source Methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
	numberOfRowsInComponent:(NSInteger)component {
	
	if (component == kItemComponent)
		return [category count];
	else if (component == kSizeSystemComponent)
		return [self.itemSizeSystem count];
	else 
		return [self.itemSizes count];
	

}

#pragma mark Picker Delegate Methods
- (NSString *)pickerView:(UIPickerView *)pickerView
			 titleForRow:(NSInteger)row
			forComponent:(NSInteger)component {
	
	if (component == kItemComponent)
		return [category objectAtIndex:row];
	else if (component == kSizeSystemComponent)
		return [itemSizeSystem objectAtIndex:row];
	else
		return [itemSizes objectAtIndex:row];
	
}

-(void)pickerView:(UIPickerView *)pickerView
	 didSelectRow:(NSInteger)row
	  inComponent:(NSInteger)component {
	
	
	if (component == kItemComponent) {
		// Section for Item Component
		if ( [[category objectAtIndex:row] isEqualToString:@"Shoes"] )
			[self categoryListSwitch:@"Shoes" selectedRow:row];
		else if ( [[category objectAtIndex:row] isEqualToString:@"Clothes"] )
			[self categoryListSwitch:@"Clothes" selectedRow:row];
		else if ( [[category objectAtIndex:row] isEqualToString:@"Bra"] )
			[self categoryListSwitch:@"Bra" selectedRow:row];
		else if ( [[category objectAtIndex:row] isEqualToString:@"Pants"] )
			[self categoryListSwitch:@"Pants" selectedRow:row];
	} else if (component == kSizeSystemComponent) {
		// Section for System Component
		NSString *selectedSystem = [self.itemSizeSystem objectAtIndex:row];
		NSArray *array;
		
		if ([self.itemSelected isEqualToString:@"Shoes"]) {
			array = [self.shoeSizesList objectForKey:selectedSystem];
		} else if ([self.itemSelected isEqualToString:@"Clothes"]) {
			array = [self.clothingSizesList objectForKey:selectedSystem];
		} else if ([self.itemSelected isEqualToString:@"Bra"]) {
			array = [self.braSizesList objectForKey:selectedSystem];
		} else if ([self.itemSelected isEqualToString:@"Pants"]) {
			array = [self.pantSizesList objectForKey:selectedSystem];
		}
		
		self.itemSizes = array;
				
		[categoryPicker selectRow:0 inComponent:kSizeComponent animated:YES];
		
		[categoryPicker reloadComponent:kSizeComponent];

	}
	
}

#pragma mark Category Switch Function
-(void)categoryListSwitch:(NSString *)selectedCategory
			 selectedRow:(NSInteger)row {
	
	self.itemSelected = selectedCategory;
	
	if ( [selectedCategory isEqualToString:@"Shoes"] ) {
		self.itemSizeSystem = [self.shoeSizesList allKeys];
		
		NSString *selectedSystem = [self.itemSizeSystem objectAtIndex:0];
		NSArray *array = [self.shoeSizesList objectForKey:selectedSystem];
		
		self.itemSizes = array;
		
	} else if ( [selectedCategory isEqualToString:@"Clothes"] ) {
		self.itemSizeSystem = [self.clothingSizesList allKeys];
		
		NSString *selectedSystem = [self.itemSizeSystem objectAtIndex:0];
		NSArray *array = [self.clothingSizesList objectForKey:selectedSystem];
		
		self.itemSizes = array;
		
	} else if ( [selectedCategory isEqualToString:@"Bra"] ) {
		self.itemSizeSystem = [self.braSizesList allKeys];
		
		NSString *selectedSystem = [self.itemSizeSystem objectAtIndex:0];
		NSArray *array = [self.braSizesList objectForKey:selectedSystem];
		
		self.itemSizes = array;
		
	}  else if ( [selectedCategory isEqualToString:@"Pants"] ) {
		self.itemSizeSystem = [self.pantSizesList allKeys];
		
		NSString *selectedSystem = [self.itemSizeSystem objectAtIndex:0];
		NSArray *array = [self.pantSizesList objectForKey:selectedSystem];
		
		self.itemSizes = array;
		
	}
	
	[categoryPicker selectRow:0 inComponent:kSizeSystemComponent animated:YES];
	[categoryPicker selectRow:0 inComponent:kSizeComponent animated:YES];
	
	[categoryPicker reloadComponent:kSizeSystemComponent];
	[categoryPicker reloadComponent:kSizeComponent];
	
}

-(void)convertSizes:(NSInteger)SystemRow
	   selectedSize:(NSInteger)SizeRow {
	
	convertedItems = nil;
	convertedItems = [[NSMutableDictionary alloc] init];
	
	for (int i = 0; i < [itemSizeSystem count]; i++) {
			NSString *itemSystemConvert;
		
			itemSystemConvert = [self.itemSizeSystem objectAtIndex:i];
			
			if ([self.itemSelected isEqualToString:@"Clothes"]) {
				//itemSizeConvert = [self.clothingSizesList objectForKey:itemSystemConvert];
				[convertedItems setObject:[[self.clothingSizesList objectForKey:itemSystemConvert] objectAtIndex:SizeRow] forKey:itemSystemConvert];
			} else if ([self.itemSelected isEqualToString:@"Shoes"]) {
				[convertedItems setObject:[[self.shoeSizesList objectForKey:itemSystemConvert] objectAtIndex:SizeRow] forKey:itemSystemConvert];
			} else if ([self.itemSelected isEqualToString:@"Bra"]) {
				[convertedItems setObject:[[self.braSizesList objectForKey:itemSystemConvert] objectAtIndex:SizeRow] forKey:itemSystemConvert];
			} else if ([self.itemSelected isEqualToString:@"Pants"]) {
				[convertedItems setObject:[[self.pantSizesList objectForKey:itemSystemConvert] objectAtIndex:SizeRow] forKey:itemSystemConvert];
			}
	}
}

#pragma mark Display and Clear Values Functions
// Display Values Functions
-(void)displayValues {
		
	int count = 0;
	int pos_x = 130;
	int pos_x_1 = 250;
	int pos_y = 210;
	
	UIColor *color = [[UIColor alloc] initWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
	
	
	for (id key in convertedItems) {
		if (count % 2 == NEW_OUTPUT_ROW) {
			sizesDisplayed[count] = [[UILabel alloc] initWithFrame:CGRectMake(pos_x, pos_y, 50, 20) ];
			[sizesDisplayed[count] setBackgroundColor:color];
			sizesDisplayed[count].text = [convertedItems objectForKey:key];
			sizesDisplayed[count].textColor = [UIColor whiteColor];
			sizesDisplayed[count].font = [UIFont fontWithName:@"HelveticaNeue" size:15];
			[self.view insertSubview:sizesDisplayed[count] atIndex:0];
			
		} else {
			
			sizesDisplayed[count] = [[UILabel alloc] initWithFrame:CGRectMake(pos_x_1, pos_y, 50, 20) ];
			[sizesDisplayed[count] setBackgroundColor:color];
			sizesDisplayed[count].text = [convertedItems objectForKey:key];
			sizesDisplayed[count].textColor = [UIColor whiteColor];
			sizesDisplayed[count].font = [UIFont fontWithName:@"HelveticaNeue" size:15];
			[self.view insertSubview:sizesDisplayed[count] atIndex:0];
			
			pos_y += 50;
		}
		count++;
		
	}
}

-(void)clearValues {
	for (int count = 0; count < [convertedItems count]; count++) {
		[sizesDisplayed[count] removeFromSuperview];
		[sizesDisplayed[count] release];
	}
	
	[convertedItems release];
}

#pragma mark Display and Clear Flag Functions

-(void)displayFlags {
	// TODO: Implement Flag display
	
	int count = 0;
	int pos_x = 100;
	int pos_x_1 = 220;
	int pos_y = 220;
	
	UIImageView *flagImg;
	

	for (id key in convertedItems) {
		
		if ([[flagsDisplayed objectForKey:key] isEqual:nil]){
			NSLog(@"uh oh");
		}
		
		if (count % 2 == NEW_OUTPUT_ROW) {
			flagImg = [flagsDisplayed objectForKey:key];
			
			flagImg.center = CGPointMake(pos_x, pos_y);
			[self.view insertSubview:flagImg atIndex:0];

		}  else {
			flagImg = [flagsDisplayed objectForKey:key];
			
			flagImg.center = CGPointMake(pos_x_1, pos_y);
			[self.view insertSubview:flagImg atIndex:0];
			pos_y += 50;
		}
		count++;
		
	}
}

-(void)clearFlags {
	
		NSEnumerator *enumerator = [flagsDisplayed keyEnumerator];
		id key;
	
		while (key = [enumerator nextObject]) {
			[[flagsDisplayed objectForKey:key] removeFromSuperview];
		}
		
}

-(void)loadFlags {
	// TODO: Implement Load Flags
	NSString *path = [[NSBundle mainBundle] pathForResource:@"countries" ofType:@"plist"];
	NSMutableArray *flagsList = [[NSMutableArray alloc] initWithContentsOfFile:path];
	
	UIImage *flag;
	UIImageView *flagImg; 
	
	flagsDisplayed = [[NSMutableDictionary alloc] init];
	
	for (NSString *str in flagsList) {
		flag = [UIImage imageNamed:[str stringByAppendingFormat:@".png"]];
		flagImg = [[UIImageView alloc] initWithImage:flag];
		[flagsDisplayed setObject:flagImg forKey:str];
	}
}
@end
