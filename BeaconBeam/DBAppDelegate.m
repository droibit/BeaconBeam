//
//  DBAppDelegate.m
//  BeaconBeam
//
//  Created by kumagai on 2014/04/04.
//  Copyright (c) 2014年 kumagai. All rights reserved.
//

#import "DBAppDelegate.h"
#import "DBBeaconRegion.h"
#import "DBPreferencesController.h"


static const NSInteger kDBAppDelegateStartBeaconTag = 1;
static const NSInteger kDBAppDelegateStopBeaconTag = 0;

static NSString *const kDBAppDelegateUserDefaultsFirstRunKey = @"FirstRun";

@interface DBAppDelegate()

///< メニューバーを表示するためのオブジェクト(strong属性で保持する必要あり）
@property (nonatomic) NSStatusItem *statusItem;
@property (nonatomic) DBPreferencesController *windowController;
@property (nonatomic) CBPeripheralManager *peripheralManager;

@end

@implementation DBAppDelegate

- (void)applicationWillFinishLaunching:(NSNotification *)notification
{
    // 初回起動時にBeaconの初期設定を行う
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults boolForKey:kDBAppDelegateUserDefaultsFirstRunKey]) {
        NSDictionary *beacon = @{kDBPreferenceUUIDKey: kDBPreferenceUUID,
                                 kDBPreferenceMajorKey: @(kDBPreferenceMajor),
                                 kDBPreferenceMinorKey: @(kDBPreferenceMinor),
                                 kDBPreferenceMesuredPowerKey: @(kDBPreferenceMesuredPower)};
        [defaults setObject:beacon forKey:kDBPreferenceBeaconKey];
        [defaults setBool:YES forKey:kDBAppDelegateUserDefaultsFirstRunKey];
        [defaults synchronize];
    }
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    NSStatusBar *systemStatusBar = [NSStatusBar systemStatusBar];
    _statusItem = [systemStatusBar statusItemWithLength:NSVariableStatusItemLength];
    _statusItem.highlightMode = YES;
    _statusItem.image = [NSImage imageNamed:@"MenuBarIcon"];
    _statusItem.menu = self.menuBar;
    
    self.windowController = [[DBPreferencesController alloc] initWithWindowNibName:@"DBPreferencesController"];
}

#pragma mark - CBPeripheral Manager Delegate

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    if (peripheral.state != CBPeripheralManagerStatePoweredOn) {
        return;
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *beacon = [defaults dictionaryForKey:kDBPreferenceBeaconKey];
    if (!beacon) {
        return;
    }
    
    NSUUID *proximityUUID = [[NSUUID alloc] initWithUUIDString:beacon[kDBPreferenceUUIDKey]];
    DBBeaconRegion *region = [[DBBeaconRegion alloc] initWithProximityUUID:proximityUUID
                                                                     major:[beacon[kDBPreferenceMajorKey] unsignedIntegerValue]
                                                                     minor:[beacon[kDBPreferenceMinorKey] unsignedIntegerValue]
                                                             measuredPower:[beacon[kDBPreferenceMesuredPowerKey] integerValue]];
    
    NSLog(@"%@", region.description);
    
    [peripheral startAdvertising:region.peripheralData];
}

#pragma mark - IBAction Methods

- (IBAction)toggleBeacon:(id)sender
{
    NSMenuItem *item = sender;
    if (item.tag == kDBAppDelegateStartBeaconTag) {
        self.peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self
                                                                         queue:nil
                                                                       options:@{CBPeripheralManagerOptionShowPowerAlertKey: @YES}];
        NSLog(@"Start Advertising ...");
        item.title = @"Stop";
        item.tag = kDBAppDelegateStopBeaconTag;
        return;
    }
    
    [self.peripheralManager stopAdvertising];
    
    NSLog(@"Stop Advertising ...");
    
    item.title = @"Start";
    item.tag = kDBAppDelegateStartBeaconTag;
}

- (IBAction)lauchPreference:(id)sender
{
    [self.windowController showWindow:self];
}
@end
