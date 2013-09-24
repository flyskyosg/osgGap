//
//  OsgGapPlugin.m
//  Hello_osgGap
//
//  Created by Youna on 13. 9. 16..
//
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "OsgGapPlugin.h"
#import "OsgView.h"


@implementation OsgGapPlugin

@synthesize osgView, m_window;

- (void) getOsgWebView:(CDVInvokedUrlCommand*)command
{
    
    NSLog(@"osgGap Plugin - getOsgWebView");
    CDVPluginResult* pluginResult = nil;
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];

    m_window = [[UIWindow alloc] initWithFrame:screenBounds];
    
    osgView = [[OsgView alloc] initWithWindow:m_window];

    [self.webView setOpaque:NO];
    [self.webView setBackgroundColor:[UIColor clearColor]];
    [m_window setOpaque:NO];
    [m_window setBackgroundColor: [UIColor clearColor]];

    [m_window addSubview:osgView];
    [m_window sendSubviewToBack:osgView];
    [m_window bringSubviewToFront:self.webView];
    
    
    [m_window makeKeyAndVisible];

    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsInt:[osgView getWebViewPtr]];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
}

- (void) webView_setSceneData:(CDVInvokedUrlCommand*)command
{
    NSLog(@"osgGap Plugin - webView_setSceneData");
    CDVPluginResult* pluginResult = nil;
    
    NSArray* ptrs = command.arguments;
    
    BOOL success = [osgView webView_setSceneData:[ptrs[0] integerValue]];
    
    if( success )
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    else
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) getGroupNode:(CDVInvokedUrlCommand*)command
{
    
    NSLog(@"osgGap Plugin - setGroupNode");
    CDVPluginResult* pluginResult = nil;
    
    unsigned int group_ptr = [osgView getGroupNode];
  
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsInt:group_ptr];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
}

- (void) getGeodeNode:(CDVInvokedUrlCommand*)command
{
    
    NSLog(@"osgGap Plugin - setGeodeNode");
    CDVPluginResult* pluginResult = nil;
    
    unsigned int geode_ptr = [osgView getGeodeNode];
    
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsInt:geode_ptr];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
}

- (void) getMatrixTransformNode:(CDVInvokedUrlCommand*)command
{
    
    NSLog(@"osgGap Plugin - getMatrixTransformNode");
    CDVPluginResult* pluginResult = nil;
    
    unsigned int matrixTransform_ptr = [osgView getMatrixTransformNode];
    
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsInt:matrixTransform_ptr];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
}

- (void) matrixTransform_addChild:(CDVInvokedUrlCommand*)command
{
    NSLog(@"osgGap Plugin - matrixTransform_addChild");
    CDVPluginResult* pluginResult = nil;
   
    NSArray* ptrs = command.arguments;

    BOOL success = [osgView matrixTransform_addChild:[ptrs[0] integerValue] geodePtr:[ptrs[1] integerValue]];
    
    if( success )
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    else
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
   
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) group_addChild:(CDVInvokedUrlCommand*)command
{
    NSLog(@"osgGap Plugin - group_addChild");
    CDVPluginResult* pluginResult = nil;
    
    NSArray* ptrs = command.arguments;
    
    BOOL success = [osgView group_addChild:[ptrs[0] integerValue] geodePtr:[ptrs[1] integerValue]];
    
    if( success )
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    else
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end
