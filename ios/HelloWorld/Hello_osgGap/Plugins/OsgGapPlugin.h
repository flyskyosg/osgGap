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

@class OsgView;

@interface OsgGapPlugin : CDVPlugin
{
    OsgView* osgView;
    UIWindow* m_window;
    
}
@property (nonatomic, retain) OsgView* osgView;
@property (nonatomic, retain) UIWindow* m_window;


- (void) getOsgWebView:(CDVInvokedUrlCommand*)command;

- (void) webView_setSceneData:(CDVInvokedUrlCommand*)command;

- (void) getGroupNode:(CDVInvokedUrlCommand*)command;
- (void) getGeodeNode:(CDVInvokedUrlCommand*)command;
- (void) getMatrixTransformNode:(CDVInvokedUrlCommand*)command;

- (void) matrixTransform_addChild:(CDVInvokedUrlCommand*)command;
- (void) group_addChild:(CDVInvokedUrlCommand*)command;

@end



