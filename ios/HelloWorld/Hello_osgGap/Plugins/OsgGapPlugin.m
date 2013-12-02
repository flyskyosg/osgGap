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
//#import "AppDelegate.h"
//#import "OsgView.h"
#import "OsgWrapper.h"
#import "MainViewController.h"


@implementation OsgGapPlugin

@synthesize osgView, m_window;

- (void) getOsgWebView:(CDVInvokedUrlCommand*)command
{
    
    NSLog(@"osgGap Plugin - getOsgWebView");
    CDVPluginResult* pluginResult = nil;
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
    
    m_window = [[UIApplication sharedApplication] keyWindow];
    osgView = [[OsgWrapper alloc] initWithFrame:screenBounds];
    
    [self.webView addSubview:osgView];
    [self.webView sendSubviewToBack:osgView];
    
    self.webView.opaque = NO;
    self.webView.backgroundColor = [UIColor clearColor];
    [m_window makeKeyAndVisible];


    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsInt:[osgView getWebViewPtr]];
    //pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
}

- (void) webView_setSceneData:(CDVInvokedUrlCommand*)command
{
    
 
    NSLog(@"osgGap Plugin - webView_setSceneData");
    CDVPluginResult* pluginResult = nil;
    
    NSArray* ptrs = command.arguments;
    
    BOOL success = [osgView webView_setSceneData:[ptrs[0] longValue]];
    
    if( success )
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    else
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

// Camera

-(void) getDefaultCamera:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    long cameraPtr = [osgView getDefaultCamera];
    
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsInt:cameraPtr];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
}
-(void) createCameraNode:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    long cameraPtr = [osgView createCameraNode];
    
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsInt:cameraPtr];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}
-(void) camera_setClearColor4:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSArray* ptrs = command.arguments;
    
    [osgView camera_setClearColor:[ptrs[0] longValue] _r:[ptrs[1] floatValue] _g:[ptrs[2] floatValue] _b:[ptrs[3] floatValue] _a:[ptrs[4] floatValue]];
    
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}


// Group

- (void) getGroupNode:(CDVInvokedUrlCommand*)command
{
    
    NSLog(@"osgGap Plugin - setGroupNode");
    CDVPluginResult* pluginResult = nil;
    
    long group_ptr = [osgView getGroupNode];
    NSLog(@"osgGap Plugin - setGroupNode : %ld" , group_ptr);
  
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsInt:group_ptr];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
}
- (void) group_addChild:(CDVInvokedUrlCommand*)command
{
    NSLog(@"osgGap Plugin - group_addChild");
    CDVPluginResult* pluginResult = nil;
    
    NSArray* ptrs = command.arguments;
    
    [osgView group_addChild:[ptrs[0] longValue] geodePtr:[ptrs[1] longValue]];
    
    
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

//Geode

- (void) getGeodeNode:(CDVInvokedUrlCommand*)command
{
    
    NSLog(@"osgGap Plugin - setGeodeNode");
    CDVPluginResult* pluginResult = nil;
    
    long geode_ptr = [osgView getGeodeNode];
    
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsInt:geode_ptr];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
}
- (void) geode_getCube:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    
    NSArray* ptrs = command.arguments;
    
    [osgView geode_getCube:[ptrs[0] longValue] _pos:[ptrs[1] longValue] _size:[ptrs[2] longValue]];
    
    
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}


// MatrixTransform

- (void) getMatrixTransformNode:(CDVInvokedUrlCommand*)command
{
    
    NSLog(@"osgGap Plugin - getMatrixTransformNode");
    CDVPluginResult* pluginResult = nil;
    
    long matrixTransform_ptr = [osgView getMatrixTransformNode];
    
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsInt:matrixTransform_ptr];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
}

- (void) matrixTransform_addChild:(CDVInvokedUrlCommand*)command
{
    NSLog(@"osgGap Plugin - matrixTransform_addChild");
    CDVPluginResult* pluginResult = nil;
   
    NSArray* ptrs = command.arguments;

    [osgView matrixTransform_addChild:[ptrs[0] longValue] geodePtr:[ptrs[1] longValue]];
    
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

// Vec3
-(void) getVec3Node:(CDVInvokedUrlCommand*)command
{
    
    CDVPluginResult* pluginResult = nil;
    long vec3 = [osgView getVec3Node];
    
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsInt:vec3];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

}
-(void) vec3_set:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    
    NSArray* ptrs = command.arguments;
    
    [osgView vec3_set:[ptrs[0] longValue] _x:[ptrs[1] floatValue]  _y:[ptrs[2] floatValue] _z:[ptrs[3] floatValue]];
    
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

}
-(void) vec3_setX:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    
    NSArray* ptrs = command.arguments;
    
    [osgView vec3_setX:[ptrs[0] longValue] _x:[ptrs[1] floatValue]];
    
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}
-(void) vec3_setY:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    
    NSArray* ptrs = command.arguments;
    
    [osgView vec3_setY:[ptrs[0] longValue] _y:[ptrs[2] floatValue]];
    
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}
-(void) vec3_setZ:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    
    NSArray* ptrs = command.arguments;
    
    [osgView vec3_setZ:[ptrs[0] longValue] _z:[ptrs[3] floatValue]];
    
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}
-(void) vec3_length:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    
    NSArray* ptrs = command.arguments;
    
    float len = [osgView vec3_length:[ptrs[0] longValue]];
    
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDouble:len];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
}
-(void) vec3_getX:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    
    NSArray* ptrs = command.arguments;
    
    float x = [osgView vec3_getX:[ptrs[0] longValue]];
    
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDouble:x];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}
-(void) vec3_getY:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    
    NSArray* ptrs = command.arguments;
    
    float y = [osgView vec3_getY:[ptrs[0] longValue]];
    
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDouble:y];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}
-(void) vec3_getZ:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    
    NSArray* ptrs = command.arguments;
    
    float z = [osgView vec3_getZ:[ptrs[0] longValue]];
    
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDouble:z];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}



@end
