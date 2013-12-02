//
//  OsgView.m
//  Hello_osgGap
//
//  Created by Youna on 13. 9. 16..
//
//

#import "OsgView.h"

#import <OpenGLES/EAGL.h>
#import <QuartzCore/QuartzCore.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

#import <osgViewer/api/IOS/GraphicsWindowIOS>
#import <osg/ShapeDrawable>
#import <osgDB/ReadFile>
#import <osg/MatrixTransform>
#import <osgText/Text>
#import <osg/CameraNode>
#import <osgViewer/Viewer>

#import "osgPlugins.h"

@interface OsgView()
-(void)drawView:(CADisplayLink *)displayLink;
@end

@implementation OsgView

osg::ref_ptr<osgViewer::Viewer> _viewer;
osg::ref_ptr<osg::Camera>       _camera;

std::vector<osg::Group*>        _groups;
std::vector<osg::Geode*>        _geodes;

+(Class) layerClass
{
    return [CAEAGLLayer class];
}

-(id) initWithFrame:(CGRect)_frame
{
    CGRect frame = _frame;
    if(self = [super initWithFrame:frame])
    {
        CAEAGLLayer* eaglLayer = (CAEAGLLayer*) super.layer;
        eaglLayer.opaque = NO;
        
        m_context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
        if(!m_context || ![EAGLContext setCurrentContext:m_context])
        {
            [self release];
            return nil;
        }
        [m_context renderbufferStorage:GL_RENDERBUFFER_BINDING_OES fromDrawable:eaglLayer];
        
        osg::ref_ptr<osg::GraphicsContext::Traits> traits = new osg::GraphicsContext::Traits;
       
        osg::ref_ptr<osgViewer::GraphicsWindowIOS::WindowData> winDataIOS_data = new osgViewer::GraphicsWindowIOS::WindowData;
        //osg::ref_ptr<osg::Referenced> windataIOS_data = new osgViewer::GraphicsWindowIOS::WindowData(_window);
        winDataIOS_data->setCreateTransparentView(true);
        //osg::ref_ptr<osg::Referenced> windataIOS_data = new osgViewer::GraphicsWindowIOS::WindowData(_window);
        
        traits->x = 110;
        traits->y = 110;
        traits->width = frame.size.width;
        traits->height = frame.size.height;
        traits->depth = 16;
        traits->alpha = 1;
        traits->windowDecoration = true;
        traits->doubleBuffer = true;
        //traits->sharedContext = winDataIOS_data;
        traits->setInheritedWindowPixelFormat = true;
        traits->windowName = "osgVewer";
        traits->inheritedWindowData = winDataIOS_data;
        
       // osg::ref_ptr<osgViewer::GraphicsWindowIOS> winDataIOS = new osgViewer::GraphicsWindowIOS(traits.get());
        //
        //m_context = winDataIOS->getContext();
        
        // Create the Graphics Context
        osg::ref_ptr<osg::GraphicsContext> _graphicsContext = osg::GraphicsContext::createGraphicsContext(traits.get());
        
         //osg::ref_ptr<osg::GraphicsContext> _graphicsContext = winDataIOS->getContext();
        
        _viewer = new osgViewer::Viewer();
       // _viewer->setUpViewerAsEmbeddedInWindow(traits->x, traits->y, traits->width, traits->height);
        _viewer->setThreadingModel(osgViewer::ViewerBase::SingleThreaded);
        _viewer->getViewerStats()->collectStats("scene", true);
        
        _camera = _viewer->getCamera();
        _camera->setGraphicsContext( _graphicsContext );
        _camera->setViewport(new osg::Viewport(0, 0, traits->width, traits->height));
        _camera->setReferenceFrame(osg::Camera::ABSOLUTE_RF);
        _camera->setClearMask(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
        _camera->setClearColor(osg::Vec4(1.0f, 0.3f, 1.0f, 0.3f));
        _camera->setComputeNearFarMode(osgUtil::CullVisitor::DO_NOT_COMPUTE_NEAR_FAR);
       // _camera->setRenderOrder(osg::Camera::POST_RENDER);
        _camera->setAllowEventFocus(true);
        
//        osg::StateSet* stateset = _camera->getOrCreateStateSet();
//        stateset->setMode(GL_BLEND,osg::StateAttribute::ON);
//        stateset->setRenderingHint(osg::StateSet::TRANSPARENT_BIN);
        
        
        //_groups = *new std::vector<osg::Group*>();
        //_geodes = *new std::vector<osg::Geode*>();
        //Option//
        
        _camera->setProjectionMatrixAsFrustum(-10.0f, 10.0f, -10.0f, 10.0f, 1.0f, 100.f);
        _camera->setViewMatrixAsLookAt(osg::Vec3(0.0f,0.0f,10.f), osg::Vec3(0.0f, 0.0f, 0.0f), osg::Vec3(0.0f, 1.0f, 0.0f));
        
        
        
        
//        osg::Group* _root = new osg::Group();
//        osg::MatrixTransform *mt = new osg::MatrixTransform();
//        osg::Matrixd m;
//        m.makeTranslate(osg::Vec3(0, 0, 0));
//        mt->setMatrix(m);
//        
//        osg::Geode *geode = new osg::Geode();
//        
//        
//        osg::Box *box = new osg::Box(osg::Vec3(0.0f, 0.0f, 0.0f), 10.0f , 10.f, 10.0f);
//        osg::ShapeDrawable *sDrawable = new osg::ShapeDrawable(box);
//        
//        sDrawable->getOrCreateStateSet()->setMode(GL_LIGHTING, osg::StateAttribute::OFF);
//        sDrawable->getOrCreateStateSet()->setMode(GL_DEPTH_TEST, osg::StateAttribute::OFF);
//        sDrawable->getOrCreateStateSet()->setMode(GL_CULL_FACE, osg::StateAttribute::OFF);
//        sDrawable->setColor(osg::Vec4(0.1f, 0.1f, 0.8f, 1.0f));
//        
//        geode->addDrawable(sDrawable);
//        
//       
//        _root->addChild(geode);
//        
//        _viewer->setSceneData(_root);
        
        
        //Option//
        
        
        _viewer->realize();
        
        
        // Set the Render function
        
        
        CADisplayLink* displayLink;
        displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(drawView:)];
        [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        
    }
    
    return self;
}

-(void)drawView:(CADisplayLink *)displayLink
{
    _viewer->frame();
    //[m_context presentRenderbuffer:GL_RENDERBUFFER_OES];
}




-(unsigned int) getWebViewPtr
{
    return (unsigned int)(_viewer.get());
}



-(BOOL) webView_setSceneData:(int)_rootPtr
{
    
    osg::Group*         _root = NULL;
    
    for( int i=0; i<_groups.size(); i++)
    {
        if( (int)_groups.at(i) == _rootPtr )
        {
            _root = (osg::Group*)_groups.at(i)->asGroup();
            break;
        }
    }
    
    if(_root == NULL)
        return false;
    
    _viewer->setSceneData( _root );
   // _viewer->realize();
    
    return true;
}




-(unsigned int) getGroupNode
{
    osg::Group* group = new osg::Group();
    _groups.push_back(group);
    
    return (unsigned int)(group);
}

-(unsigned int) getGeodeNode
{
    
    // Youna Lee 2013. 9. 16
    // For Test
    osg::Box *box = new osg::Box(osg::Vec3(0.0f, 0.0f, 0.0f), 10.0f , 10.f, 10.0f);
    osg::ShapeDrawable *sDrawable = new osg::ShapeDrawable(box);
    
    sDrawable->getOrCreateStateSet()->setMode(GL_LIGHTING, osg::StateAttribute::OFF);
    sDrawable->getOrCreateStateSet()->setMode(GL_DEPTH_TEST, osg::StateAttribute::OFF);
    sDrawable->getOrCreateStateSet()->setMode(GL_CULL_FACE, osg::StateAttribute::OFF);
    sDrawable->setColor(osg::Vec4(0.1f, 0.1f, 0.8f, 1.0f));

    //////////////////////////
    
    osg::Geode* geode = new osg::Geode();
    
    
    ////////////
    geode->addDrawable(sDrawable);
    ////////////
    
    
    _geodes.push_back(geode);
    
    return (unsigned int)(geode);
}

-(unsigned int) getMatrixTransformNode
{
    osg::MatrixTransform* matrixTransform = new osg::MatrixTransform();
    osg::Matrix m;
    m.makeTranslate(osg::Vec3(0.0f, 0.0f, 0.0f));
    
    matrixTransform->setMatrix(m);
    
    _groups.push_back(matrixTransform);
    
    return (unsigned int)(matrixTransform);
}


-(BOOL) matrixTransform_addChild:(int)_matrixTransform geodePtr:(int)_ptr
{
   // NSLog(@"mt ptr : %d ",_matrixTransform);
   // NSLog(@"g ptr : %d ",_ptr);
    
    osg::MatrixTransform* _mt;
    osg::Geode*           _g;
    
    for( int i=0; i<_groups.size(); i++)
    {

        if( (int)_groups.at(i) == _matrixTransform )
        {
            _mt = (osg::MatrixTransform*)_groups.at(i);
            break;
        }
    }

    for( int j=0; j<_geodes.size(); j++ )
    {

        if( (int)_geodes.at(j) == _ptr )
        {
            _g = (osg::Geode*)_geodes.at(j);
            break;
        }
    }
    
    if( _mt==NULL || _g==NULL )
    {
        return false;
    }
    
    _mt->addChild(_g);
    
    return true;
}

-(BOOL) group_addChild:(int)_groupPtr geodePtr:(int)_ptr
{    
    osg::Group*           _group;
    osg::Group*           _child;
    
    for( int i=0; i<_groups.size(); i++)
    {
        if( (int)_groups.at(i) == _groupPtr )
        {
            _group = (osg::Group*)_groups.at(i)->asGroup();
            break;
        }
    }
    
    for( int j=0; j<_groups.size(); j++ )
    {
         
        if( (int)_groups.at(j) == _ptr )
        {
            _child = (osg::Group*)_groups.at(j)->asGroup();
            break;
        }
    }
    
    if( _group==NULL || _child==NULL )
    {
        return false;
    }
    
    _group->addChild(_child);
    
    return true; 
}





-(void) dealloc
{
    if([EAGLContext currentContext] == m_context)
        [EAGLContext setCurrentContext:nil];
    
    [m_context release];
    [super dealloc];

}



@end
