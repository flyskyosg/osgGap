//
//  OsgBridge.m
//  Hello_osgGap
//
//  Created by Youna on 13. 11. 13..
//
//

#import "OsgBridge.h"
#include "OsgApp.h"

static OsgApp *m_osg = new OsgApp();

void callOsg(int width, int height)
{
    
//    CFURLRef url = CFBundleCopyResourceURL(CFBundleGetMainBundle(), CFSTR("cessna"), CFSTR("osg"), NULL);
//    char path[1024];
//    CFURLGetFileSystemRepresentation(url, true, (uint8_t*)path, sizeof(path));
//    CFRelease(url);
    
    //CCFileUtils::fullPathFromRelativeFile("cessna.osgt");
    m_osg->initOSGWindow(0,0,width,height);
    
    
}

void drawOsg()
{
    m_osg->draw();
}



long getWebViewPtr()
{
    return m_osg->getWebViewPtr();
}
bool webView_setSceneData( long _rootPtr )
{
    return m_osg->webView_setSceneData(_rootPtr);
}


// Camera
long getDefaultCamera()
{
    return m_osg->getDefaultCamera();
}
long createCameraNode()
{
    return m_osg->createCameraNode();
}
void camera_setClearColor(long _cameraPtr, float _r, float _g, float _b, float _a)
{
    m_osg->camera_setClearColor(_cameraPtr, _r, _g, _b, _a);
}

// Group
long getGroupNode()
{
    return m_osg->getGroupNode();
}
bool group_addChild( long _groupPtr, long _ptr )
{
    return m_osg->group_addChild(_groupPtr, _ptr);
}

// Geode
long getGeodeNode()
{
    return m_osg->getGeodeNode();
}
void geode_getCube(long _geodePtr, long _pos, long _size)
{
    m_osg->geode_getCube(_geodePtr, _pos, _size);
}

// MatrixTransform
long getMatrixTransformNode()
{
    return m_osg->getMatrixTransformNode();
}
void matrixTransform_addChild( long _matrixTransform, long _ptr )
{
    m_osg->matrixTransform_addChild(_matrixTransform, _ptr);
}

// Vec3
long getVec3Node()
{
    return m_osg->getVec3Node();
}
void vec3_set(long _vec3Ptr, float _x, float _y, float _z)
{
    m_osg->vec3_set(_vec3Ptr, _x, _y, _z);
}
void vec3_setX(long _vec3Ptr, float _x)
{
    m_osg->vec3_setX(_vec3Ptr, _x);
}
void vec3_setY(long _vec3Ptr, float _y)
{
    m_osg->vec3_setY(_vec3Ptr, _y);
}
void vec3_setZ(long _vec3Ptr, float _z)
{
    m_osg->vec3_setZ(_vec3Ptr, _z);
}
float vec3_length(long _vec3Ptr)
{
    return m_osg->vec3_length(_vec3Ptr);
}
float vec3_getX(long _vec3Ptr)
{
    return m_osg->vec3_getX(_vec3Ptr);
}
float vec3_getY(long _vec3Ptr)
{
    return m_osg->vec3_getY(_vec3Ptr);
}
float vec3_getZ(long _vec3Ptr)
{
    return m_osg->vec3_getZ(_vec3Ptr);
}
