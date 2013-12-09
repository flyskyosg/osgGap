//
//  OsgBridge.h
//  Hello_osgGap
//
//  Created by Youna on 13. 11. 13..
//
//


// c header
#ifndef __OsgGap__osg_iphone__
#define __OsgGap__osg_iphone__
#import <UIKit/UIKit.h>

#ifdef __cplusplus
extern "C" {
#endif // _cplusplus
    
    
    void callOsg(int width, int height);
    void drawOsg();
    
    long getWebViewPtr();
    bool webView_setSceneData( long _rootPtr );
    
    
    // Camera
    long getDefaultCamera();
    long createCameraNode();
    void camera_setClearColor(long _cameraPtr, float _r, float _g, float _b, float _a);
    
    
    // Group
    long getGroupNode();
    bool group_addChild( long _groupPtr, long _ptr );
    
    // Geode
    long getGeodeNode();
    void geode_getCube(long _geodePtr, long _pos, long _size);
    
    
    // MatrixTransform
    long getMatrixTransformNode();
    void matrixTransform_addChild( long _matrixTransform, long _ptr );
    
    
    // Vec3
    long getVec3Node();
    void vec3_set(long _vec3Ptr, float _x, float _y, float _z);
    void vec3_setX(long _vec3Ptr, float _x);
    void vec3_setY(long _vec3Ptr, float _y);
    void vec3_setZ(long _vec3Ptr, float _z);
    float vec3_length(long _vec3Ptr);
    float vec3_getX(long _vec3Ptr);
    float vec3_getY(long _vec3Ptr);
    float vec3_getZ(long _vec3Ptr);
    

#ifdef __cplusplus
}
#endif // _cplusplus

#endif /* defined(__OsgGap__osg_iphone__) */
