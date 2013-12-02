//
//  OsgWrapper.h
//  Hello_osgGap
//
//  Created by Youna on 13. 11. 13..
//
//

#import <OpenGLES/EAGL.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>


@interface OsgWrapper : UIView
{
    EAGLContext* m_context;
}

-(id) initWithFrame:(CGRect)frame;
-(void)render:(CADisplayLink *)displayLink;

-(long) getWebViewPtr;
-(BOOL) webView_setSceneData:(long)_rootPtr;

// Camera
-(long) getDefaultCamera;
-(long) createCameraNode;
-(void) camera_setClearColor:(long) _cameraPtr _r:(float)r _g:(float)g _b:(float)b _a:(float)a;


// Group
-(long) getGroupNode;
-(void) group_addChild:(long)_groupPtr geodePtr:(long)_ptr;

// Geode
-(long) getGeodeNode;
-(void) geode_getCube:(long) _geodePtr _pos:(long)pos _size:(long)size;


// MatrixTransform
-(long) getMatrixTransformNode;
-(void) matrixTransform_addChild:(long)_matrixTransform geodePtr:(long)_ptr;

// Vec3
-(long) getVec3Node;
-(void) vec3_set:(long) _vec3Ptr _x:(float)x _y:(float)y _z:(float)z;
-(void) vec3_setX:(long) _vec3Ptr _x:(float)x;
-(void) vec3_setY:(long) _vec3Ptr _y:(float)y;
-(void) vec3_setZ:(long) _vec3Ptr _z:(float)z;
-(float) vec3_length:(long) _vec3Ptr;
-(float) vec3_getX:(long) _vec3Ptr;
-(float) vec3_getY:(long) _vec3Ptr;
-(float) vec3_getZ:(long) _vec3Ptr;



@end
