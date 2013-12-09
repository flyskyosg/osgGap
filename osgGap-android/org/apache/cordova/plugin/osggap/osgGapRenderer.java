package org.apache.cordova.plugin.osggap;

import javax.microedition.khronos.egl.EGLConfig;
import javax.microedition.khronos.opengles.GL10;

import org.openscenegraph.osg.viewer.OSGRenderer;
import org.openscenegraph.osg.viewer.Viewer;

public class osgGapRenderer extends OSGRenderer{

	private Viewer _viewer;
	
	public osgGapRenderer(Viewer viewer) {
		super(viewer);
		
		_viewer = viewer;
	}
	
	@Override
	public void onDrawFrame(GL10 gl) {
		super.onDrawFrame(gl);
	}

	@Override
	public void onSurfaceChanged(GL10 gl, int width, int height) {
		super.onSurfaceChanged(gl, width, height);
	}

	@Override
	public void onSurfaceCreated(GL10 gl, EGLConfig config) {
		super.onSurfaceCreated(gl, config);
	
	}

	
	// osgGap Plugin
	
}
