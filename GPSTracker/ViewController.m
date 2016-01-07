//
//  ViewController.m
//  GPSTracker
//
//  Created by Chris Wong on 2014-10-25.
//  Copyright (c) 2014 Chris Wong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSDateFormatter *)dateFormatter {
    if (_dateFormatter == nil) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        [_dateFormatter setTimeStyle:NSDateFormatterLongStyle];
    }
    return _dateFormatter;
}


- (IBAction)startTracking:(id)sender {
    NSLog(@"Start Tracking");
    
    [self setupLocationManager];
    
    [self.locationManager startUpdatingLocation];
}

- (IBAction)stopTracking:(id)sender {
    if(self.locationManager != nil){
        NSLog(@"Stop Tracking");

        self.longitude.text = @"";
        self.latitude.text = @"";
        self.time.text = @"";
        
        [self.locationManager stopUpdatingLocation];

    }
}

- (void)setupLocationManager {
    
    if (!self.locationManager) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
    }
    
    // This is the most important property to set for the manager. It ultimately determines how the manager will
    // attempt to acquire location and thus, the amount of power that will be consumed.
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    // When "tracking" the user, the distance filter can be used to control the frequency with which location measurements
    // are delivered by the manager. If the change in distance is less than the filter, a location will not be delivered.
    self.locationManager.distanceFilter = 5;
    
    // Once configured, the location manager must be "started".
    //
    // for iOS 8, specific user level permission is required,
    // "when-in-use" authorization grants access to the user's location
    //
    // important: be sure to include NSLocationWhenInUseUsageDescription along with its
    // explanation string in your Info.plist or startUpdatingLocation will not work.
    //
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.locationManager requestAlwaysAuthorization];
    }

}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    for (CLLocation *location in locations){
        NSLog(@"Received a Location: %@ %f %f", location.timestamp, location.coordinate.latitude, location.coordinate.longitude);
    
        self.longitude.text = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
        self.latitude.text = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
        self.time.text = [self.dateFormatter stringFromDate:location.timestamp];
        
        //NSString *deviceName = [[UIDevice currentDevice] name];
        
        PFObject *locationObject = [PFObject objectWithClassName:@"Data"];
        locationObject[@"phoneId"] = [self.phoneNumber.text MD5];
        locationObject[@"longitude"] = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
        locationObject[@"latitude"] = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
        locationObject[@"timestamp"] = location.timestamp;
        [locationObject saveInBackground];
        
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)textFieldDismiss:(id)sender {
    [self.phoneNumber resignFirstResponder];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end
