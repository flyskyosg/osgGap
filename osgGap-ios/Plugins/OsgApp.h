//
//  OsgApp.h
//  Hello_osgGap
//
//  Created by Youna on 13. 11. 13..
//
//

#ifndef __Hello_osgGap__OsgApp__
#define __Hello_osgGap__OsgApp__

#include <osg/MatrixTransform>
#include <osg/CameraNode>
#include <osgText/Text>
#include <osgViewer/Viewer>
#include <osg/ShapeDrawable>
#include <osg/Matrix>
#include <osg/io_utils>
#include <osg/BoundingBox>
#include <osg/Vec3>

#include <osgGA/TrackballManipulator>

#include <osgDB/ReadFile>

//#include "osgGUIEventHandler.h"
#include "osgPlugins.h"

class OsgApp
{
public:
    OsgApp() {}
    void initOSGWindow(int x, int y, int width, int height);
    void set(char path[]);
    void draw();
    
    // WebView
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
    bool matrixTransform_addChild( long _matrixTransform, long _ptr );

    
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
    
  //  PickModeHandler* picker;
    
//    osgViewer::Viewer* viewer;
//    float scale;
//    float angle;
    
protected:
   // float depth;
//    
//    osg::Group* root;
//    osg::Camera* camera;
//    
//    osg::MatrixTransform* getMatrixTransformSetMatrix(osg::Geode *geode, int x, int y, int z, float width, float height);
    osg::Geode* getCube(float x, float y, float z, float lengthX, float lengthY, float lengthZ);
//    osg::Geode* getTextureRectangle(float width, float height, std::string fileName);
    
    osg::ref_ptr<osgViewer::Viewer> _viewer;
    osg::ref_ptr<osg::Camera>       _camera;
    
   // std::vector<osg::Group*>        _groups;
   // std::vector<osg::Geode*>        _geodes;
    
    
    
};


#endif /* defined(__Hello_osgGap__OsgApp__) */
