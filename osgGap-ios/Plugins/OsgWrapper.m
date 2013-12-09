//
//  OsgWrapper.m
//  Hello_osgGap
//
//  Created by Youna on 13. 11. 13..
//
//

#import "OsgWrapper.h"
#import "OsgBridge.h"

@implementation OsgWrapper

-(id) initWithFrame:(CGRect)frame
{
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
        
        //OpenGL init
        
        GLuint framebuffer, renderbuffer;
        
        glGenFramebuffersOES(1, &framebuffer);
        glGenRenderbuffersOES(1, &renderbuffer);
        
        glBindFramebufferOES(GL_FRAMEBUFFER_OES, framebuffer);
        glBindRenderbufferOES(GL_RENDERBUFFER_OES, renderbuffer);
        
        [m_context renderbufferStorage:GL_RENDERBUFFER_OES fromDrawable:eaglLayer];
        
        glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_COLOR_ATTACHMENT0_OES, GL_RENDERBUFFER_OES, renderbuffer);
        /*
         glMatrixMode(GL_PROJECTION);
         glLoadIdentity();
         glOrthof(0.0f, 0.0f, 0.0f, 1.0f, -1.0f, 1.0f);
         glViewport(0,  0, CGRectGetWidth(frame), CGRectGetHeight(frame));
         */
        //desiredAngle = angle;
        //currentAngle = desiredAngle;
        
        callOsg(frame.size.width, frame.size.height);
        
        
        [self setupDisplayLink];
        
    }
    
    return self;
}

+(Class) layerClass
{
    return [CAEAGLLayer class];
}

-(void)setupDisplayLink
{
    NSLog(@"OGLView setupDisplayLink");
	CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(render:)];
	[displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

-(void)render:(CADisplayLink *)displayLink
{
    //[self renderView];
    
    drawOsg();
    
    [m_context presentRenderbuffer:GL_RENDERBUFFER_OES];
}




-(long) getWebViewPtr
{
    return getWebViewPtr();
}

-(BOOL) webView_setSceneData:(long)_rootPtr
{
    return webView_setSceneData(_rootPtr);
}


// Camera
-(long) getDefaultCamera
{
    return getDefaultCamera();
}
-(long) createCameraNode
{
    return createCameraNode();
}
-(void) camera_setClearColor:(long) _cameraPtr _r:(float)r _g:(float)g _b:(float)b _a:(float)a
{
    camera_setClearColor(_cameraPtr, r, g, b, a);
}

// Group
-(long) getGroupNode
{
    return getGroupNode();
}
-(void) group_addChild:(long)_groupPtr geodePtr:(long)_ptr
{
    group_addChild(_groupPtr, _ptr);
}

// Geode
-(long) getGeodeNode
{
    return getGeodeNode();
}
-(void) geode_getCube:(long) _geodePtr _pos:(long)pos _size:(long)size
{
    geode_getCube(_geodePtr, pos, size);
}


// MatrixTransform
-(long) getMatrixTransformNode
{
    return getMatrixTransformNode();
}

-(void) matrixTransform_addChild:(long)_matrixTransform geodePtr:(long)_ptr
{
    matrixTransform_addChild(_matrixTransform, _ptr);
}

// Vec3
-(long) getVec3Node
{
    return getVec3Node();
}
-(void) vec3_set:(long) _vec3Ptr _x:(float)x _y:(float)y _z:(float)z
{
    vec3_set(_vec3Ptr, x, y, z);
}
-(void) vec3_setX:(long) _vec3Ptr _x:(float)x
{
    vec3_setX(_vec3Ptr, x);
}
-(void) vec3_setY:(long) _vec3Ptr _y:(float)y
{
    vec3_setY(_vec3Ptr, y);
}
-(void) vec3_setZ:(long) _vec3Ptr _z:(float)z
{
    vec3_setZ(_vec3Ptr, z);
}
-(float) vec3_length:(long) _vec3Ptr
{
    return vec3_length(_vec3Ptr);
}
-(float) vec3_getX:(long) _vec3Ptr
{
    return vec3_getX(_vec3Ptr);
}
-(float) vec3_getY:(long) _vec3Ptr
{
    return vec3_getY(_vec3Ptr);
}
-(float) vec3_getZ:(long) _vec3Ptr
{
    return vec3_getZ(_vec3Ptr);
}


-(void) dealloc
{
    if([EAGLContext currentContext] == m_context)
        [EAGLContext setCurrentContext:nil];
    
    [m_context release];
    [super dealloc];
}

@end
