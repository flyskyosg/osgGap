//
//  OsgView.h
//  Hello_osgGap
//
//  Created by Youna on 13. 9. 16..
//
//

#import <OpenGLES/EAGL.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>


@interface OsgView : UIView
{
    EAGLContext* m_context;
}


//-(id) initWithFrame:(CGRect)frame;
+(Class) layerClass;

-(id) initWithFrame:(CGRect)_frame;

-(unsigned int) getWebViewPtr;

-(BOOL) webView_setSceneData:(int)_rootPtr;

-(unsigned int) getGroupNode;
-(unsigned int) getGeodeNode;
-(unsigned int) getMatrixTransformNode;

-(BOOL) matrixTransform_addChild:(int)_matrixTransform geodePtr:(int)_ptr;
-(BOOL) group_addChild:(int)_groupPtr geodePtr:(int)_ptr;

@end
