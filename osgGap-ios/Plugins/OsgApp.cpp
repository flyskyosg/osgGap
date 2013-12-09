//
//  OsgApp.cpp
//  Hello_osgGap
//
//  Created by Youna on 13. 11. 13..
//
//

#include "OsgApp.h"


void OsgApp::initOSGWindow(int x, int y, int width, int height)
{
    _viewer = new osgViewer::Viewer();
    _viewer->setUpViewerAsEmbeddedInWindow(x,y,width, height);
    _viewer->setThreadingModel( osgViewer::ViewerBase::SingleThreaded );
    
    _camera = _viewer->getCamera();
    _camera->setViewport( new osg::Viewport(x, y, width, height ));
    _camera->setReferenceFrame(osg::Camera::ABSOLUTE_RF);
    _camera->setClearMask(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    //_camera->setClearColor(osg::Vec4(1.0f, 0.3f, 1.0f, 0.3f));
    _camera->setComputeNearFarMode(osgUtil::CullVisitor::DO_NOT_COMPUTE_NEAR_FAR);
    _camera->setAllowEventFocus(true);
                         
    _camera->setProjectionMatrixAsFrustum(-10.0f, 10.0f, -10.0f, 10.0f, 1.0f, 100.f);
    _camera->setViewMatrixAsLookAt(osg::Vec3(0.0f,0.0f,10.f), osg::Vec3(0.0f, 0.0f, 0.0f), osg::Vec3(0.0f, 1.0f, 0.0f));
    
    
    //_groups = new std::vector<osg::Group*>();
    //_geodes = new std::vector<osg::Geode*>();
    
    _viewer->realize();
    
}

void OsgApp::draw()
{
    _viewer->frame();
}







/*
 WebView
 */

long OsgApp::getWebViewPtr()
{
    return reinterpret_cast<long>(_viewer.get());
}


bool OsgApp::webView_setSceneData(long _rootPtr)
{
    osg::Group* _root = reinterpret_cast<osg::Group *>(_rootPtr);
    _viewer->setSceneData(_root);
    
    return true;
    
}

/*
 Camera
 */
long OsgApp::getDefaultCamera()
{
    return reinterpret_cast<long>(_viewer->getCamera());
}

long OsgApp::createCameraNode()
{
    osg::Camera* camera = new osg::Camera();
    return reinterpret_cast<long>(camera);
    
}
void OsgApp::camera_setClearColor(long _cameraPtr, float _r, float _g, float _b, float _a)
{
    osg::Camera* camera = reinterpret_cast<osg::Camera *>(_cameraPtr);
    
    camera->setClearColor(osg::Vec4(_r, _g, _b, _a));
}


/*
 Group
*/
long OsgApp::getGroupNode()
{
    osg::Group* group = new osg::Group();
    return reinterpret_cast<long>(group);
}

bool OsgApp::group_addChild( long _groupPtr, long _ptr )
{
    
    osg::Group* _group = reinterpret_cast<osg::Group *>(_groupPtr);
    osg::Node* _child = reinterpret_cast<osg::Node *>(_ptr);
    
    if( _group==NULL || _child==NULL )
        return false;
    
    
    _group->addChild(_child);
    
    return true;
}

/*
 Geode
 */
long OsgApp::getGeodeNode()
{
//    osg::Box *box = new osg::Box(osg::Vec3(0.0f, 0.0f, 0.0f), 10.0f , 10.f, 10.0f);
//    osg::ShapeDrawable *sDrawable = new osg::ShapeDrawable(box);
//    
//    sDrawable->getOrCreateStateSet()->setMode(GL_LIGHTING, osg::StateAttribute::OFF);
//    sDrawable->getOrCreateStateSet()->setMode(GL_DEPTH_TEST, osg::StateAttribute::OFF);
//    sDrawable->getOrCreateStateSet()->setMode(GL_CULL_FACE, osg::StateAttribute::OFF);
//    sDrawable->setColor(osg::Vec4(0.1f, 0.1f, 0.8f, 1.0f));
    
    //////////////////////////
    
    osg::Geode* geode = new osg::Geode();
    
    
    ////////////
    //geode->addDrawable(sDrawable);
    ////////////
    
    
    return reinterpret_cast<long>(geode);
}

void OsgApp::geode_getCube(long _geodePtr, long _pos, long _size)
{
    
    std::cout << "Native geode_getCube : " << _geodePtr << std::endl;
    osg::Geode* geode = reinterpret_cast<osg::Geode *>(_geodePtr);
    osg::Vec3* pos_node = reinterpret_cast<osg::Vec3 *>(_pos);
    osg::Vec3* size_node = reinterpret_cast<osg::Vec3 *>(_size);
    
    osg::Box* cube = new osg::Box(osg::Vec3(pos_node->x(), pos_node->y(), pos_node->z()), size_node->x(), size_node->y(), size_node->z());
    osg::ShapeDrawable* drawable = new osg::ShapeDrawable(cube);
    //drawable->setColor(osg::Vec4(0.1f, 0.1f, 0.8f, 1.0f));
    
    
    
    geode->addDrawable(drawable);
    
}

/*
 MatrixTransform
 */

long OsgApp::getMatrixTransformNode()
{
    osg::MatrixTransform* matrixTransform = new osg::MatrixTransform();
    osg::Matrix m;
    m.makeTranslate(osg::Vec3(0.0f, 0.0f, 0.0f));
    
    matrixTransform->setMatrix(m);
    
    
    return reinterpret_cast<long>(matrixTransform);
}

bool OsgApp::matrixTransform_addChild( long _matrixTransform, long _ptr )
{
    osg::MatrixTransform* _mt = reinterpret_cast<osg::MatrixTransform *>(_matrixTransform);
    osg::Node*           _g = reinterpret_cast<osg::Node *>(_ptr);
    
    if( _mt==NULL || _g==NULL )
        return false;
    
    _mt->addChild(_g);
    return true;
}




/*
 Vec3
 */
long OsgApp::getVec3Node()
{
    osg::Vec3* vec3 = new osg::Vec3();
    return reinterpret_cast<long>(vec3);
    
}
void OsgApp::vec3_set(long _vec3Ptr, float _x, float _y, float _z)
{
    osg::Vec3* vec3 = reinterpret_cast<osg::Vec3 *>(_vec3Ptr);
    vec3->set(_x, _y, _z);
    
}
void OsgApp::vec3_setX(long _vec3Ptr, float _x)
{
    osg::Vec3* vec3 = reinterpret_cast<osg::Vec3 *>(_vec3Ptr);
    vec3->x() = _x;
}
void OsgApp::vec3_setY(long _vec3Ptr, float _y)
{
    osg::Vec3* vec3 = reinterpret_cast<osg::Vec3 *>(_vec3Ptr);
    vec3->y() = _y;
}
void OsgApp::vec3_setZ(long _vec3Ptr, float _z)
{
    osg::Vec3* vec3 = reinterpret_cast<osg::Vec3 *>(_vec3Ptr);
    vec3->z() = _z;
}
float OsgApp::vec3_length(long _vec3Ptr)
{
    osg::Vec3* vec3 = reinterpret_cast<osg::Vec3 *>(_vec3Ptr);
    return vec3->length();
}
float OsgApp::vec3_getX(long _vec3Ptr)
{
    osg::Vec3* vec3 = reinterpret_cast<osg::Vec3 *>(_vec3Ptr);
    return vec3->x();
}
float OsgApp::vec3_getY(long _vec3Ptr)
{
    osg::Vec3* vec3 = reinterpret_cast<osg::Vec3 *>(_vec3Ptr);
    return vec3->y();
}
float OsgApp::vec3_getZ(long _vec3Ptr)
{
    osg::Vec3* vec3 = reinterpret_cast<osg::Vec3 *>(_vec3Ptr);
    return vec3->z();
}



void OsgApp::set(char path[])
{
    osg::Group* root = new osg::Group();
    
    //root->addChild(getCube(0, 0, 0, 40, 40, 40));
    
    osg::Node* readnode = new osg::Node();
   // readnode = osgDB::readNodeFile(path);
   // osg::Node* root = new osg::Node();
    osg::Geode* cube = getCube(0, 0, 0, 40, 40, 40);
    osg::Geode* cube2 = getCube(0, 0, 0, 40, 40, 40);
    osg::MatrixTransform* mt = new osg::MatrixTransform();
    osg::MatrixTransform* mt2 = new osg::MatrixTransform();
   // mt->addChild(picker->addDraggerToScene(readnode,"TabBoxDraggerTransparent"));
    mt->addChild(cube);
    //mt2->addChild(readnode);
    //mt2->addChild(picker->addDraggerToScene(readnode,"TabBoxDraggerTransparent"));
    mt2->addChild(cube2);
    osg::Matrixd m, m2;
    m2.makeTranslate(osg::Vec3f(0,0,0));
    m.makeTranslate(osg::Vec3f(20,0,0));
    mt->setMatrix(m);
    mt2->setMatrix(m2);
    root->addChild(mt);
    root->addChild(mt2);
    
    osg::StateSet* state = root->getOrCreateStateSet();
    state->setMode(GL_CULL_FACE,  osg::StateAttribute::ON);
    
   // viewer->addEventHandler(root);
    
    //viewer->getCamera()->setProjectionMatrixAsPerspective(45, 1, 0.5, 1000);
    _viewer->getCamera()->setViewMatrixAsLookAt(osg::Vec3(0, 0, 400), osg::Vec3(0, 0,-1.0f), osg::Vec3(0.0f, 1.0f, 0.0f));
    
    _viewer->setSceneData(root);
}

osg::Geode* OsgApp::getCube(float x, float y, float z, float lengthX, float lengthY, float lengthZ)
{
	osg::Geode *CubeGeode = new osg::Geode();
    
	osg::ShapeDrawable* unitCubeDrawable =
    new osg::ShapeDrawable(new osg::Box(osg::Vec3((float)x, (float)y, (float)z), (float)lengthX, (float)lengthY, (float)lengthZ));
	unitCubeDrawable->setColor(osg::Vec4(0.5,0.5,0.5,1));
	CubeGeode->addDrawable(unitCubeDrawable);
    
    return CubeGeode;
    
}