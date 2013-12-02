//
//  OsgGapPlugin.h
//  Hello_osgGap
//
//  Created by Youna on 13. 9. 16..
//
//



#import <Cordova/CDV.h>
#import <UIKit/UIKit.h>
//#import "OsgView.h"
#import "OsgWrapper.h"

@class MainViewController;

@interface OsgGapPlugin : CDVPlugin
{
    OsgWrapper* osgView;
    UIWindow* m_window;
    UIView* m_view;
    
}
@property (nonatomic, retain) OsgWrapper* osgView;
@property (nonatomic, retain) UIWindow* m_window;



- (void) getOsgWebView:(CDVInvokedUrlCommand*)command;
- (void) webView_setSceneData:(CDVInvokedUrlCommand*)command;

// Camera
-(void) getDefaultCamera:(CDVInvokedUrlCommand*)command;
-(void) createCameraNode:(CDVInvokedUrlCommand*)command;
-(void) camera_setClearColor4:(CDVInvokedUrlCommand*)command;

// Group
- (void) getGroupNode:(CDVInvokedUrlCommand*)command;
- (void) group_addChild:(CDVInvokedUrlCommand*)command;

// Geode
- (void) getGeodeNode:(CDVInvokedUrlCommand*)command;
- (void) geode_getCube:(CDVInvokedUrlCommand*)command;


// MatrixTransform
- (void) getMatrixTransformNode:(CDVInvokedUrlCommand*)command;
- (void) matrixTransform_addChild:(CDVInvokedUrlCommand*)command;

// Vec3
-(void) getVec3Node:(CDVInvokedUrlCommand*)command;
-(void) vec3_set:(CDVInvokedUrlCommand*)command;
-(void) vec3_setX:(CDVInvokedUrlCommand*)command;
-(void) vec3_setY:(CDVInvokedUrlCommand*)command;
-(void) vec3_setZ:(CDVInvokedUrlCommand*)command;
-(void) vec3_length:(CDVInvokedUrlCommand*)command;
-(void) vec3_getX:(CDVInvokedUrlCommand*)command;
-(void) vec3_getY:(CDVInvokedUrlCommand*)command;
-(void) vec3_getZ:(CDVInvokedUrlCommand*)command;



@end



