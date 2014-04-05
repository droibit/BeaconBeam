//
//  DBPreferencesController.m
//  BeaconBeam
//
//  Created by kumagai on 2014/04/05.
//  Copyright (c) 2014年 kumagai All rights reserved.
//

#import "DBPreferencesController.h"

#import "NSString+EmptyValidating.h"

NSString *const kDBPreferenceBeaconKey = @"UserDefaultsKey";
NSString *const kDBPreferenceUUIDKey = @"UUID";
NSString *const kDBPreferenceMajorKey = @"Major";
NSString *const kDBPreferenceMinorKey = @"Minor";
NSString *const kDBPreferenceMesuredPowerKey = @"MesuredPower";

NSString *const kDBPreferenceUUID = @"D0026916-294A-429E-A004-37964D8CC1A1";
const NSInteger kDBPreferenceMajor = 1;
const NSInteger kDBPreferenceMinor = 1;
const NSInteger kDBPreferenceMesuredPower = -58;


@interface DBPreferencesController () {
    BOOL isLoaded;
}

@end

@implementation DBPreferencesController

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
        isLoaded = NO;
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    [self setContentsFromUserDefaults];
    
    isLoaded = YES;
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

- (void)showWindow:(id)sender
{
    if (isLoaded) {
        [self setContentsFromUserDefaults];
    }
    [super showWindow:sender];
}

#pragma mark - NSWindow Delegate

- (void)windowWillClose:(NSNotification *)notification
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *uuid = [self.uuidTextField.stringValue isEmpty] ? kDBPreferenceUUID : self.uuidTextField.stringValue;
    NSNumber *major = [self.majorTextField.stringValue isEmpty] ? @(kDBPreferenceMajor) : @(self.majorTextField.integerValue);
    NSNumber *minor = [self.minorTextField.stringValue isEmpty] ? @(kDBPreferenceMinor) : @(self.minorTextField.integerValue);
    NSNumber *mesuredPower = [self.powerTextField.stringValue isEmpty] ? @(kDBPreferenceMesuredPower) : @(self.powerTextField.integerValue);
    NSDictionary *beacon = @{kDBPreferenceUUIDKey: uuid,
                             kDBPreferenceMajorKey: major,
                             kDBPreferenceMinorKey: minor,
                             kDBPreferenceMesuredPowerKey: mesuredPower};
    
    [defaults setObject:beacon forKey:kDBPreferenceBeaconKey];
    [defaults synchronize];
}

#pragma mark - NSTextField Delegate

#pragma mark - Private Methods

- (void)setContentsFromUserDefaults
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *beacon = [defaults dictionaryForKey:kDBPreferenceBeaconKey];
    if (!beacon) {
        return;
    }
    
    [self.uuidTextField setStringValue:beacon[kDBPreferenceUUIDKey]];
    [self.majorTextField setStringValue:beacon[kDBPreferenceMajorKey]];
    [self.minorTextField setStringValue:beacon[kDBPreferenceMinorKey]];
    [self.powerTextField setStringValue:beacon[kDBPreferenceMesuredPowerKey]];
}

@end
