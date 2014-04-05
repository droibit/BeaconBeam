//
//  DBAppDelegate.h
//  BeaconBeam
//
//  Created by kumagai on 2014/04/04.
//  Copyright (c) 2014年 kumagai. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <IOBluetooth/IOBluetooth.h>

@interface DBAppDelegate : NSObject <NSApplicationDelegate, CBPeripheralManagerDelegate>

#pragma mark - Outlet Properties
///< メニューバー
@property (weak) IBOutlet NSMenu *menuBar;

@property (assign) IBOutlet NSWindow *window;

#pragma mark - Action Methods
///< Beaconの
- (IBAction)toggleBeacon:(id)sender;
///<
- (IBAction)lauchPreference:(id)sender;

@end
