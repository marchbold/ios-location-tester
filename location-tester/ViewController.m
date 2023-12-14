//
//  ViewController.m
//  location-tester
//
//  Created by Michael Archbold on 16/1/17.
//  Copyright © 2017 distriqt. All rights reserved.
//

#import "ViewController.h"

#import <CoreLocation/CoreLocation.h>

@interface ViewController () <CLLocationManagerDelegate>

@end

@implementation ViewController
{
	CLLocationManager* _locationManager;
}


- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	
	_locationManager = [[CLLocationManager alloc] init];
	_locationManager.delegate = self;
	
	[self requestAuthorisation: @""];
	
	
	@try
	{
		_locationManager.pausesLocationUpdatesAutomatically = NO;
	}
	@catch (NSException* e)
	{
	}
	
	
	[_locationManager startUpdatingLocation];
    [_locationManager startMonitoringSignificantLocationChanges];
	
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}




-(Boolean) hasAuthorisation
{
	{
		return (
				[CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways
				|| [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse
				);
	}
}



-(Boolean) requestAuthorisation: (NSString*)status
{
	if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)
	{
		NSLog(@"Requesting authorisation" );
		[_locationManager requestAlwaysAuthorization];
	}
	return true;
}





#pragma mark CLLocationManagerDelegate


-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
	NSLog( @"didChangeAuthorizationStatus: %d", status );
	[self requestAuthorisation: @""];
}



- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
	CLLocation* location = [locations lastObject];
	NSLog( @"location: %f, %f", location.coordinate.latitude, location.coordinate.longitude );
}

@end
