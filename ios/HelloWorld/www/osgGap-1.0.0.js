
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
    console.log("SetSceneData");
    var rootPtr = _root.ptr;
    
    cordova.exec(function(states){ console.log(states); } , function(error) {console.log("osgGap webView_setSceneData error!");}, "osgGap", "webView_setSceneData", [rootPtr]);
}

osgGap.Group = function () {

    // osgGap Group instance variable
    this.ptr = null;
    
    var groupPtr;
    cordova.exec(function(states){ console.log(states); groupPtr = states; } , function(error) {console.log("osgGap Get Group node error!");}, "osgGap", "getGroupNode", []);
    
    this.ptr = groupPtr;
   
};

osgGap.Group.prototype.addChild = function ( _child ) {

    var childPtr = _child.ptr;
    
    cordova.exec(function(states){ console.log(states); } , function(error) {console.log("osgGap group_addChild error!");}, "osgGap", "group_addChild", [this.ptr, childPtr]);
    
};





osgGap.Geode = function () {
    
    // osgGap Geode instance variable
    this.ptr = null;
    
    var geodePtr;
    cordova.exec(function(states){ console.log(states); geodePtr = states; } , function(error) {console.log("osgGap Get Geode node error!");}, "osgGap", "getGeodeNode", []);
    
    this.ptr = geodePtr;
    
};

osgGap.MatrixTransform = function () {
    
    // osgGap Geode instance variable
    this.ptr = null;
    
    var matrixTransformPtr;
    cordova.exec(function(states){ console.log(states); matrixTransformPtr = states; } , function(error) {console.log("osgGap Get Geode node error!");}, "osgGap", "getMatrixTransformNode", []);
    
    this.ptr = matrixTransformPtr;
    
};

osgGap.MatrixTransform.prototype.addChild = function ( _child ) {
    
 
    var childPtr = _child.ptr;

    cordova.exec(function(states){ console.log(states);} , function(error) {console.log("osgGap matrixTransform_addChild error!");}, "osgGap", "matrixTransform_addChild", [this.ptr, childPtr]);

};
