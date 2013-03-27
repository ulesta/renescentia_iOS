#include "testApp.h"
#include "math.h"
#include "ofBall.h"
#define ACCELEROMETER_FORCE		0.9
#define VELOCITY 30


//--------------------------------------------------------------
void testApp::setup(){	
	// initialize the accelerometer
    ofSetBackgroundAuto(false);
	ofxAccelerometer.setup();
    ofxAccelerometer.setForceSmoothing(3);
    
    //mySound.loadSound("Renescentia.mp3");
    //mySound.unloadSound();
    ambient1.loadSound("r.mp3");
    ambient1.setLoop(TRUE);
    ambient1.play();
    
    C4.loadSound("C4.wav", true);
    C5.loadSound("C5.wav", true);
    E4.loadSound("E4.wav", true);
    E5.loadSound("E5.wav", true);
    G4.loadSound("G4.wav", true);
    G5.loadSound("G5.wav", true);
    
    //negative
    C4a.loadSound("C4a.wav", true);
    C5a.loadSound("C5a.wav", true);
    F5a.loadSound("F5a.wav", true);
    G4a.loadSound("G4a.wav", true);
    D3a.loadSound("D3a.wav", true);
    D4a.loadSound("D4a.wav", true);
    
    //mySound.play();
    
	
    if(!my_img.loadImage("teal.jpg")){
        ofLog(OF_LOG_ERROR, "Error while loading image");
    }
    
    if(!my_img2.loadImage("yellow.jpg")){
        ofLog(OF_LOG_ERROR, "Error while loading image");
    }
	//If you want a landscape oreintation 
	//iPhoneSetOrientation(OFXIPHONE_ORIENTATION_LANDSCAPE_RIGHT);
	
	//ofBackground(time, time, time);
    //ofBackground(150, 150, 150);
    
    leagues = 0;
    
   //ofBackgroundGradient(ofColor(255-leagues, 0, 0), ofColor(0+leagues, 0+leagues, 0+leagues));
    
    //ofBackgroundGradient(ofColor(255,50,150), ofColor(((0.5*sin(time/60)+0.5)*255),((0.5*cos(time/30)+0.5)*255),100));
    
    
    currentX = ofGetWidth()/2;
    currentY = ofGetHeight()/2;
    
    mainX = ofGetWidth()/2;
    mainY = ofGetHeight()/2;
    ofEnableAlphaBlending();
    ofSetFrameRate(30);
    
    //mySound.play();
    
    countSize = 1;
    
    inContact = false;

    time = 0;
    
    r1 = 0; g1 = 0; b1 = 0;
    r2 = 255; g2 = 255; b2 = 255;
    
    aheadX = 0.0;
    aheadY = 0.0;
    guideBall = ofBall(MAXWIDTH/2, MAXHEIGHT/2);
    
    
}

//--------------------------------------------------------------
void testApp::update(){
    
    guideBall.update(guideBall);
    
    leagues = myEntity.numEat;
    
    myEntity.update();
    
    time = ofGetElapsedTimef()*10;
    // Background gradient controlled by time
    ofBackgroundGradient(ofColor((0.5*sin(time/30)+0.5)*50,(0.5*sin(time/30)+0.5)*143,(0.5*sin(time/30)+0.5)*150), ofColor(0, 0 ,(0.5*sin(time/30)+0.5)*143));
    //ofBackground(ofColor(0,0,0));
    //ofBackgroundGradient(ofColor(r1, g1, b1), ofColor(r2, g2, b2));
    //r1 *=leagues;
    //b2 *= leagues;
    
    
    
    // Main control for MAIN ENTITY
    // main X, Y is the actual displacement of MAIN ENTITY
    // current X, Y is the current touch location
    
    //mainX += ACCELEROMETER_FORCE * ofxAccelerometer.getForce().x * VELOCITY;
    //mainY += -ACCELEROMETER_FORCE * ofxAccelerometer.getForce().y * VELOCITY;
    
    for (int i = 0 ; i < NUMBALLS ; i++) {
        myBall[i].update(guideBall);
        
        // Logic for collision between two shapes
        for ( int j = 0 ; j < NUMBALLS; j++) {
            if ( j != i ) {
                ofVec2f vDist(myBall[i].x-myBall[j].x, myBall[i].y-myBall[j].y);
                float len = vDist.length();
                if (len <= myBall[i].dim+myBall[j].dim-0.5) {
                    myBall[i].speedX *= -1;
                    myBall[i].speedY *= -1;
                }
            }
        }
        // Logic for collision between MAIN ENTITY and shape
        ofVec2f vDist(mainX-myBall[i].x, mainY-myBall[i].y); 
        float len = vDist.length(); // Calculate distance between ball
        if (len <= 12+myBall[i].dim +10 && myBall[i].dim != 0) {
           // cout << "HIT!";
            inContact = true;
            contactWith = i;
          /*  cout << "\n";
            cout << contactWith;
            cout << "\n"; */
        }
    }
    
    if (inContact) {
        ofVec2f vDist2(mainX-myBall[contactWith].x, mainY-myBall[contactWith].y);
        float len2 = vDist2.length(); 
        if (len2 <= 12+myBall[contactWith].dim +10) {
            ofSetColor(255-(countSize*5), 0+countSize*5, 0);
            ofCircle(myBall[contactWith].x, myBall[contactWith].y, myBall[contactWith].dim+countSize);
            countSize++;
            //cout << contactWith;
            //cout << "\n";
            if (countSize >= 30) {
                myBall[contactWith].dim = 0;
                playPositive();
                inContact = false;
                myEntity.numEat++;
                //cout << myEntity.numEat;
            }
        }
        else {
            inContact = false;
        }
    }
    else {
        countSize = 1;
    }
    
    /*cout << "\n";*/

} //END UPDATE()

//--------------------------------------------------------------
void testApp::draw(){
    //ofScale(1.0*(0.5*sin(time*2.08)+0.5), 1);
    for (int i = 0 ; i < NUMBALLS ; i++) {
        myBall[i].draw(time);
    }

    ofEnableBlendMode(OF_BLENDMODE_MULTIPLY);
	my_img.draw(0,0);
    ofEnableBlendMode(OF_BLENDMODE_MULTIPLY);
    my_img2.draw(x,y);
    ofDisableBlendMode();
    
    myEntity.draw(time, aheadX, aheadY, mainX, mainY);
    
    
    
    ofSetColor(255, 0, 0);
    ofFill();
    /*
    ofLine(mainX, mainY, currentX, currentY);
    ofLine(mainX, mainY, currentX, mainY);
    ofLine(currentX, mainY, currentX, currentY);
    ofLine(mainX, mainY, currentX, currentY);
    */
    
    // RESET COLOR FILL
    ofSetColor(255,255,255);
    //ofLine(aheadX, aheadY, mainX, mainY);

    
    
}

//--------------------------------------------------------------
void testApp::exit(){

    ambient1.unloadSound();
    
    C4.unloadSound();
    C5.unloadSound();
    E4.unloadSound();
    E5.unloadSound();
    G4.unloadSound();
    G5.unloadSound();
    
    //negative
    C4a.unloadSound();
    C5a.unloadSound();
    F5a.unloadSound();
    G4a.unloadSound();
    D3a.unloadSound();
    D4a.unloadSound();

    
    
    

}

//--------------------------------------------------------------
void testApp::touchDown(ofTouchEventArgs & touch){
   currentX = touch.x;
   currentY = touch.y;
    myEntity.numEat++;
   
}

//--------------------------------------------------------------
void testApp::touchMoved(ofTouchEventArgs & touch){
    //x = touch.x-250;
    //y = touch.y-250;
    currentX = touch.x;
    currentY = touch.y;
}

//--------------------------------------------------------------
void testApp::touchUp(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void testApp::touchDoubleTap(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void testApp::touchCancelled(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void testApp::lostFocus(){

}

//--------------------------------------------------------------
void testApp::gotFocus(){

}

//--------------------------------------------------------------
void testApp::gotMemoryWarning(){

}

//--------------------------------------------------------------
void testApp::deviceOrientationChanged(int newOrientation){

}

void testApp::playPositive(){
    
    int rand = ofRandom(0, 6);
    switch (rand)
    {
        case 0: C4.play();
        case 1: C5.play();
        case 2: E4.play();
        case 3: E5.play();
        case 4: G4.play();
        case 5: G5.play();

            
    }
    /*cout << "\n";
    cout << "RAND:";
    cout << rand;
    cout << "\n";*/
}

