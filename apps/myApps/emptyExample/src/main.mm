#include "ofMain.h"
#include "testApp.h"
#include "ofAppGlutWindow.h"
#include "ofBall.h"

int main(){
    //ofAppGlutWindow window;
    //window.setGlutDisplayString("rgba double samples>=4");
	//ofSetupOpenGL(1024,768, OF_FULLSCREEN);			// <-------- setup the GL context
    
    
    ofAppiPhoneWindow * iOSWindow = new ofAppiPhoneWindow();  
    iOSWindow->enableAntiAliasing(2);
    iOSWindow->enableRetinaSupport();  
    ofSetupOpenGL(iOSWindow, 480, 320, OF_FULLSCREEN);  
    ofRunApp(new testApp);  
    //ofSetupOpenGL(640,480, OF_FULLSCREEN);
    
	//ofRunApp(new testApp);
}
