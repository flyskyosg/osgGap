package org.apache.cordova.plugin.osggap;

import java.util.Vector;

import org.openscenegraph.osg.core.Camera;
import org.openscenegraph.osg.core.Geode;
import org.openscenegraph.osg.core.Group;
import org.openscenegraph.osg.core.MatrixTransform;
import org.openscenegraph.osg.core.Node;
import org.openscenegraph.osg.core.Vec3;
import org.openscenegraph.osg.viewer.Viewer;

import android.content.Context;

public class osgGapView extends Viewer{

	private osgGapRenderer _renderer;
	private Camera _camera;
	private Vector<Node> _nodes;
	
	public osgGapView(Context context, boolean _alpha, int _depth, int _stencil) {
		super(context);
		
		_renderer = new osgGapRenderer(this);
		init(true, _depth, _stencil, _renderer);
		
		_camera = this.getCamera();
		_camera.setViewMatrixAsLookAt(new Vec3( 0, 0, 400 ), new Vec3(0, 0, -1) , new Vec3(0, 1, 0));
	
		
	}
	
	// osgGap Plugin
	
	//viewer SetSceneData
	public void webView_setSceneData(long _root)
	{
		Group root = new Group(_root);
		this.setSceneData(root);
	}
	
	// Camera
	public long getCameraPtr()
	{
		return _camera.getNativePtr();
	}
	
	public void camera_setClearColor(long _ptr, float _r, float _g, float _b)
	{
		Camera camera = new Camera(_ptr);
		camera.setClearColor(_r, _g, _b, 1.0f);
	}
	
	public void camera_setClearColor(long _ptr, float _r, float _g, float _b, float _a)
	{
		Camera camera = new Camera(_ptr);
		camera.setClearColor(_r, _g, _b, _a);
	}
	
	public void camera_setViewMatrixAsLookAt(long _ptr, Vec3 eye, Vec3 center, Vec3 up)
	{
		Camera camera = new Camera(_ptr);
		camera.setViewMatrixAsLookAt(eye, center, up);
	}
	
	// Group
	public long getGroupNode()
	{
		Group group = new Group();
		return group.getNativePtr();
	}
	
	public long getGroupNode(long _ptr)
	{
		Group group = new Group(_ptr);
		return group.getNativePtr();
		
	}
	
	public void group_addChild(long _parent, long _child)
	{
		Group group = new Group(_parent);
		Node child = new Node(_child);
		
		group.addChild(child);
		
	}
	
	// Geode
	public long getGeodeNode()
	{
		Geode geode = new Geode();
		return geode.getNativePtr();
	}
	
	public long getGeodeNode(long _ptr)
	{
		Geode geode = new Geode(_ptr);
		return geode.getNativePtr();
	}
	
	// Primitives
	public long getBox(float x, float y, float z)
	{
		Geode box = new Geode();
		box.getCube(new Vec3(0, 0, 0), x, y, z);
		
		return box.getNativePtr();
	}
	
	public long getSphere(float centerX, float centerY, float centerZ, float radius)
	{
		Geode sphere = new Geode();
		sphere.getSphere(new Vec3(centerX, centerY, centerZ), radius);
		
		return sphere.getNativePtr();
	}
	
	
	// MatrixTransform
	public long getMatrixTransformNode()
	{
		MatrixTransform mt = new MatrixTransform();
		return mt.getNativePtr();
	}
	
	public long getMatrixTransformNode(long _ptr)
	{
		MatrixTransform mt = new MatrixTransform(_ptr);
		return mt.getNativePtr();
	}
	
	public void matrixTransform_addChild(long _parent, long _child)
	{
		MatrixTransform mt = new MatrixTransform(_parent);
		Node child = new Node(_child);
		
		mt.addChild(child);
	}

	


}
