//
//  ViewController.h
//  GPSTracker
//
//  Created by Chris Wong on 2014-10-25.
//  Copyright (c) 2014 Chris Wong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <Parse/Parse.h>
#import <CommonCrypto/CommonDigest.h>
#import "NSString+MD5.h"

@interface ViewController : UIViewController <CLLocationManagerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *longitude;
@property (strong, nonatomic) IBOutlet UILabel *latitude;
@property (strong, nonatomic) IBOutlet UILabel *time;
@property (strong, nonatomic) IBOutlet UITextField *phoneNumber;

- (IBAction)textFieldDismiss:(id)sender;

@end

