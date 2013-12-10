package org.apache.cordova.plugin.osggap;

import kr.ac.kookmin.vcl.osggap_android.<your_mainActivity>;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.DroidGap;
import org.json.JSONArray;
import org.json.JSONException;
import org.openscenegraph.osg.core.Camera;
import org.openscenegraph.osg.core.Geode;
import org.openscenegraph.osg.core.Group;
import org.openscenegraph.osg.core.MatrixTransform;
import org.openscenegraph.osg.core.Node;
import org.openscenegraph.osg.core.Vec3;

import android.app.Activity;
import android.graphics.Color;
import android.util.Log;
import android.view.ViewGroup.LayoutParams;
import android.widget.LinearLayout;

public class osgGap extends CordovaPlugin{
	
	
	public static String TAG = "osgGapPlugin";
	
	private Activity _activity = null;
	private osgGapView _viewer;
	
	public boolean execute (String action, JSONArray args, CallbackContext callbackContext) throws JSONException
	{
		
		_activity = <your_mainActivity>._activity;
		String ptr = "";
		
		if(action.equals("getOsgWebView"))
		{
			final osgGap _me = this;
			_viewer = new osgGapView(_activity.getApplicationContext(), true, 16, 8);
			
			Runnable addview = new Runnable()
			{
				@Override
				public void run() {
					
					_activity.addContentView(_viewer,  
							new LayoutParams(LayoutParams.MATCH_PARENT, LayoutParams.MATCH_PARENT));
					DroidGap droidgap = (DroidGap) _activity;
					droidgap.setIntegerProperty("backgroundColor", 0);
					
					_me.webView.setBackgroundColor(Color.TRANSPARENT);
					
					LinearLayout rootLayout = (LinearLayout) _me.webView.getParent();
					rootLayout.setBackgroundColor(Color.TRANSPARENT);
					rootLayout.bringChildToFront(_me.webView);
					rootLayout.bringToFront();
					rootLayout.invalidate();
					
					_me.webView.invalidate();			
				}	
			};
			
			_activity.runOnUiThread(addview);
			
			ptr += _viewer.getNativePtr();
			callbackContext.success(ptr);
		}
		else if(action.equals("webView_setSceneData"))
		{
			long rootPtr = args.getLong(0);
			_viewer.webView_setSceneData(rootPtr);
			
			callbackContext.success();
		}
		
		// Group
		else if(action.equals("createGroupNode"))
		{
			ptr += new Group().getNativePtr();
			callbackContext.success(ptr);
		}
		else if(action.equals("getGroupNode"))
		{
			long group_node = args.getLong(0);
			
			ptr += new Group(group_node).getNativePtr();
			callbackContext.success(ptr);
		}
		else if(action.equals("group_addChild"))
		{
			long group_node = args.getLong(0);
			long child_node = args.getLong(1);
			
			Group group = new Group(group_node);
			Node child = new Node(child_node);
			group.addChild(child);
			
			callbackContext.success();
		}
		
		
		// Geode
		else if(action.equals("createGeodeNode"))
		{
			ptr += new Geode().getNativePtr();
			callbackContext.success(ptr);
		}
		else if(action.equals("getGeodeNode"))
		{
			long geode_node = args.getLong(0);
			ptr += new Geode(geode_node).getNativePtr();
			callbackContext.success(ptr);
		}
		else if(action.equals("geode_getCube"))
		{
			long geode_node = args.getLong(0);
			long pos_node = args.getLong(1);
			long size_node = args.getLong(2);
			
			Vec3 pos = new Vec3(pos_node);
			Vec3 size = new Vec3(size_node);
			
			Geode cube = new Geode(geode_node);
			cube.getCube(pos, size.x(), size.y(), size.z());
			
			callbackContext.success();
		}
		
		// MatrixTransform
		else if(action.equals("createMatrixTransformNode"))
		{
			ptr += new MatrixTransform().getNativePtr();
			callbackContext.success(ptr);
		}
		else if(action.equals("getMatrixTransformNode"))
		{
			long mt_node = args.getLong(0);
			ptr += new MatrixTransform(mt_node).getNativePtr();
			callbackContext.success(ptr);
		}
		else if(action.equals("matrixTransform_addChild"))
		{
			long mt_node = args.getLong(0);
			long child_node = args.getLong(1);
			
			MatrixTransform mt = new MatrixTransform(mt_node);
			Node child = new Node(child_node);
			
			mt.addChild(child);
			callbackContext.success();
		}
		
		
		// Camera
		else if( action.equals("getDefualtCamera"))
		{
			ptr += _viewer.getCameraPtr();
			callbackContext.success(ptr);
		}
		else if(action.equals("createCameraNode"))
		{
			Camera camera = new Camera();
			ptr += camera.getNativePtr();
			callbackContext.success(ptr);
		}
		else if(action.equals("camera_setClearColor3"))
		{
			long camera_node = args.getLong(0);
			float r = (float)args.getDouble(1);
			float g = (float)args.getDouble(2);
			float b = (float)args.getDouble(3);
			
			Camera camera = new Camera(camera_node);
			camera.setClearColor(r, g, b, 1.0f);
		
			callbackContext.success();
		}
		else if(action.equals("camera_setClearColor4"))
		{
			long camera_node = args.getLong(0);
			float r = (float)args.getDouble(1);
			float g = (float)args.getDouble(2);
			float b = (float)args.getDouble(3);
			float a = (float)args.getDouble(4);
			
			Camera camera = new Camera(camera_node);
			camera.setClearColor(r, g, b, a);
			
			callbackContext.success();
			
		}
		
		// Vec3
		else if(action.equals("createVec3"))
		{
			Vec3 vec3 = new Vec3();
			ptr += vec3.getNativePtr();
			
			callbackContext.success(ptr);
		}
		else if(action.equals("vec3_set"))
		{
			long vec3_node = args.getLong(0);
			float x = (float)args.getDouble(1);
			float y = (float)args.getDouble(2);
			float z = (float)args.getDouble(3);
			
			Vec3 vec3 = new Vec3(vec3_node);
			vec3.set(x, y, z);
			
			callbackContext.success();
		}
		else if(action.equals("vec3_setX"))
		{
			long vec3_node = args.getLong(0);
			float x = (float)args.getDouble(1);
			
			Vec3 vec3 = new Vec3(vec3_node);
			vec3.setX(x);
			
			callbackContext.success();
		}
		else if(action.equals("vec3_setY"))
		{
			long vec3_node = args.getLong(0);
			float y = (float)args.getDouble(1);
			
			Vec3 vec3 = new Vec3(vec3_node);
			vec3.setX(y);
			
			callbackContext.success();
		}
		else if(action.equals("vec3_setZ"))
		{
			long vec3_node = args.getLong(0);
			float z = (float)args.getDouble(1);
			
			Vec3 vec3 = new Vec3(vec3_node);
			vec3.setX(z);
			
			callbackContext.success();
		}
		else if(action.equals("vec3_length"))
		{
			long vec3_node = args.getLong(0);
			
			Vec3 vec3 = new Vec3(vec3_node);
			ptr += vec3.length();
			
			callbackContext.success(ptr);
		}
		else if(action.equals("vec3_getX"))
		{
			long vec3_node = args.getLong(0);
			
			Vec3 vec3 = new Vec3(vec3_node);
			ptr += vec3.x();
			
			callbackContext.success(ptr);
		}
		else if(action.equals("vec3_getY"))
		{
			long vec3_node = args.getLong(0);
			
			Vec3 vec3 = new Vec3(vec3_node);
			ptr += vec3.y();
			
			callbackContext.success(ptr);
		}
		else if(action.equals("vec3_getZ"))
		{
			long vec3_node = args.getLong(0);
			
			Vec3 vec3 = new Vec3(vec3_node);
			ptr += vec3.z();
			
			callbackContext.success(ptr);
		}

		else
		{
			return false;
		}
		
		
		
		return true;
	}

}
