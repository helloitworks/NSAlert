//
//  AppDelegate.m
//  NSAlert
//
//  Created by shenyixin on 14-6-6.
//  Copyright (c) 2014年 shenyixin. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

//采用Window的方式展示
- (IBAction)ShowNSAlertWindow:(id)sender
{
    
    NSAlert *alert = [NSAlert alertWithMessageText:@"messageText"
                                     defaultButton:@"defaultButton"
                                   alternateButton:@"alternateButton"
                                       otherButton:@"otherButton"
                         informativeTextWithFormat:@"informativeText"];
    
    NSUInteger action = [alert runModal];
    //响应window的按钮事件
    if(action == NSAlertDefaultReturn)
    {
        NSLog(@"defaultButton clicked!");
    }
    else if(action == NSAlertAlternateReturn )
    {
        NSLog(@"alternateButton clicked!");
    }
    else if(action == NSAlertOtherReturn)
    {
        NSLog(@"otherButton clicked!");
    }
    
}


//采用Sheet的方式展示
- (IBAction)ShowNSAlertSheet:(id)sender
{
    NSMutableDictionary * extrasDict = [[NSMutableDictionary alloc] init];
    [extrasDict setObject:@"http://www.baidu.com" forKey:@"link"];
    
    NSAlert *alert = [NSAlert alertWithMessageText:@"messageText"
                                     defaultButton:@"defaultButton"
                                   alternateButton:@"alternateButton"
                                       otherButton:@"otherButton"
                         informativeTextWithFormat:@"informativeText"];
    //__bridge_retained for arc
    [alert beginSheetModalForWindow:self.window
                      modalDelegate:self
                     didEndSelector:@selector(alertSheetDidEnd:returnCode:contextInfo:)
                        contextInfo:(__bridge void *)(extrasDict )];
}


//响应Sheet的按钮事件
- (void)alertSheetDidEnd:(NSAlert *)alert returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo
{
    if (returnCode == NSAlertDefaultReturn)
    {
        NSLog(@"alternateButton clicked!");
        //show you how to use contextInfo
        //__bridge_transfer for arc
        NSString *url = [(__bridge NSDictionary*)contextInfo objectForKey:@"link"];
        [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:url]];
    }
    else if(returnCode == NSAlertAlternateReturn )
    {
        NSLog(@"alternateButton clicked!");
    }
    else if(returnCode == NSAlertOtherReturn)
    {
        NSLog(@"otherButton clicked!");
    }
}

@end
