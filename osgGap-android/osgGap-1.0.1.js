
var osgGap = osgGap || {};

self.console = self.console || {

info: function() {},
log: function() {},
debug: function() {},
warn: function() {},
error: function() {}

};

osgGap.WebView = null;




osgGap.SceneInit = function () {

    // osgGap instance variable
    this.ptr = null;
    
    // Get OSG view
    var webViewPtr;
    cordova.exec(function(states){ console.log(states); webViewPtr = states; } , function(error) {console.log("osgGap GetWebView error!");}, "osgGap", "getOsgWebView", []);
    
    this.ptr = webViewPtr;
    osgGap.WebView = this;

};

osgGap.SceneInit.prototype.setSceneData = function ( _root )
{
    //console.log("SetSceneData");
    var rootPtr = _root.ptr;
    
    cordova.exec(function(states){ console.log(states); } , function(error) {console.log("osgGap webView_setSceneData error!");}, "osgGap", "webView_setSceneData", [rootPtr]);
};

osgGap.SceneInit.prototype.getCamera = function () {

	this.camera = null;
	
	var webViewDefaultCamera;
	cordova.exec(function(states){ console.log(states); webViewDefaultCamera = states; } , function(error) {console.log("osgGap webViewDefaultCamera error!");}, "osgGap", "getDefualtCamera", []);

	
	//console.log("webView Camera : " + webViewDefaultCamera);
	this.camera = new osgGap.Camera();
	this.camera.ptr = webViewDefaultCamera;
	
	return this.camera;
	
};

osgGap.Camera = function() {
	
	//console.log("getCameraNode");
	this.ptr = null;
	
	var cameraPtr;
	cordova.exec(function(states){ console.log(states); cameraPtr = states; } , function(error) {console.log("osgGap Get Camera node error!");}, "osgGap", "createCameraNode", []);
	this.ptr = cameraPtr;
	
};

osgGap.Camera.prototype.setClearColor = function (r, g, b) {
	
	cordova.exec(function(states){ console.log("set Clear Color success"); } , function(error) {console.log("osgGap camera_setClearColor3 error!");}, 
												"osgGap", "camera_setClearColor3", [this.ptr, r, g, b]);
	
};


osgGap.Camera.prototype.setClearColor = function (r, g, b, a) {
	
	cordova.exec(function(states){ console.log("set Clear Color success"); } , function(error) {console.log("osgGap camera_setClearColor4 error!");}, 
												"osgGap", "camera_setClearColor4", [this.ptr, r, g, b, a]);
	
};



//Group
osgGap.Group = function () {

    // osgGap Group instance variable
    //console.log("getGroupNode");
    this.ptr = null;
    
    var groupPtr;
    cordova.exec(function(states){ console.log(states); groupPtr = states; } , function(error) {console.log("osgGap Get Group node error!");}, "osgGap", "createGroupNode", []);
    
   // console.log("getGroupNode : " + groupPtr);
    this.ptr = groupPtr;
   
};

osgGap.Group.prototype.addChild = function ( _child ) {

    var childPtr = _child.ptr;
    
    cordova.exec(function(states){ console.log(states); } , function(error) {console.log("osgGap group_addChild error!");}, "osgGap", "group_addChild", [this.ptr, childPtr]);
    
};



// Geode
osgGap.Geode = function () {
    
    // osgGap Geode instance variable
    this.ptr = null;
    
    var geodePtr;
    cordova.exec(function(states){ console.log(states); geodePtr = states; } , function(error) {console.log("osgGap Get Geode node error!");}, "osgGap", "createGeodeNode", []);
    
    this.ptr = geodePtr;
    
};


osgGap.Geode.prototype.getCube = function ( _pos, _size ) {
	
    cordova.exec(function(states){ console.log(states); } , function(error) {console.log("osgGap Get Cube node error!");}, "osgGap", "geode_getCube", [this.ptr, _pos.ptr, _size.ptr]);
    
    //this.ptr = cubePtr;
};

// MatrixTransform
osgGap.MatrixTransform = function () {
    
    // osgGap Geode instance variable
    this.ptr = null;
    
    var matrixTransformPtr;
    cordova.exec(function(states){ console.log(states); matrixTransformPtr = states; } , function(error) {console.log("osgGap Get Geode node error!");}, "osgGap", "createMatrixTransformNode", []);
    
    this.ptr = matrixTransformPtr;
    
};

osgGap.MatrixTransform.prototype.addChild = function ( _child ) {
    
 
    var childPtr = _child.ptr;

    cordova.exec(function(states){ console.log(states);} , function(error) {console.log("osgGap matrixTransform_addChild error!");}, "osgGap", "matrixTransform_addChild", [this.ptr, childPtr]);

};



// Vec3, Vec4
osgGap.Vec3 = function () {
	
	this.ptr = null;
	
	var vec3Ptr;
	cordova.exec(function(states){ console.log(states); vec3Ptr = states;} , function(error) {console.log("osgGap createVec3 error!");}, "osgGap", "createVec3", []);

	this.ptr = vec3Ptr;
	
};

osgGap.Vec3 = function (x, y, z) {
	
	this.ptr = null;
	cordova.exec(function(states){ console.log(states); vec3Ptr = states;} , function(error) {console.log("osgGap createVec3 error!");}, "osgGap", "createVec3", []);

	this.ptr = vec3Ptr;
	this.set(x, y, z);
	
};

osgGap.Vec3.prototype.set = function (x, y, z) {
	
	cordova.exec(function(states){ console.log(states);} , function(error) {console.log("osgGap setVec3 error!");}, "osgGap", "vec3_set", [this.ptr, x, y, z]);

};

osgGap.Vec3.prototype.setX = function (_x) {
	
	var x = _x;
	cordova.exec(function(states){ console.log(states);} , function(error) {console.log("osgGap vec3_setX error!");}, "osgGap", "vec3_setX", [this.ptr, x]);
	
};

osgGap.Vec3.prototype.setY = function (_y) {
	
	var y = _y;
	cordova.exec(function(states){ console.log(states);} , function(error) {console.log("osgGap vec3_setY error!");}, "osgGap", "vec3_setY", [this.ptr, y]);
	
};

osgGap.Vec3.prototype.setZ = function (_z) {
	
	var z = _z;
	cordova.exec(function(states){ console.log(states);} , function(error) {console.log("osgGap vec3_setZ error!");}, "osgGap", "vec3_setZ", [this.ptr, z]);

};

osgGap.Vec3.prototype.length = function () {
	
	var length;
	cordova.exec(function(states){ console.log(states); length = states;} , function(error) {console.log("osgGap vec3_getZ error!");}, "osgGap", "vec3_legth", [this.ptr]);

	return length;
	
};

osgGap.Vec3.prototype.x = function () {
	
	var x;
	cordova.exec(function(states){ console.log(states); x = states;} , function(error) {console.log("osgGap vec3_getX error!");}, "osgGap", "vec3_getX", [this.ptr]);

	return x;
	
};

osgGap.Vec3.prototype.y = function () {
	
	var y;
	cordova.exec(function(states){ console.log(states); y = states;} , function(error) {console.log("osgGap vec3_getY error!");}, "osgGap", "vec3_getY", [this.ptr]);

	return y;
	
};

osgGap.Vec3.prototype.z = function () {
	
	var z;
	cordova.exec(function(states){ console.log(states); z = states;} , function(error) {console.log("osgGap vec3_getZ error!");}, "osgGap", "vec3_getZ", [this.ptr]);

	return z;
	
};

