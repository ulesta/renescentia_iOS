#pragma once

#include "ofMain.h"
#include "ofxiPhone.h"
#include "ofxiPhoneExtras.h"
#include "ofBall.h"
#include "mEntity.h"


#define NUMBALLS 120
class testApp : public ofxiPhoneApp{
	
    public:
        void setup();
        void update();
        void draw();
        void exit();
	
        void touchDown(ofTouchEventArgs & touch);
        void touchMoved(ofTouchEventArgs & touch);
        void touchUp(ofTouchEventArgs & touch);
        void touchDoubleTap(ofTouchEventArgs & touch);
        void touchCancelled(ofTouchEventArgs & touch);
        void playPositive();


        void lostFocus();
        void gotFocus();
        void gotMemoryWarning();
        void deviceOrientationChanged(int newOrientation);
        ofImage my_img;
        ofImage my_img2;

        int x;
        int y;
        
        double time;
        
        int currentX;
        int currentY;
        
        float mainX;
        float mainY;
    
        ofBall myBall[NUMBALLS];
        ofBall guideBall;
        
        mEntity myEntity;
        
        
   // ofBall myBall;
        // Sounds
        ofSoundPlayer mySound;
        ofSoundPlayer ambient;
        ofSoundPlayer ambient1;
        ofSoundPlayer C4, C5, E4, E5, G4, G5;
        ofSoundPlayer C4a, C5a, D3a, D4a, G4a, F5a;
    
    
        int countSize;
        int contactWith;
        bool inContact;
    
        // background
        int leagues;
        bool bgActivate;
    
        int r1, g1, b1, r2, g2, b2;
    
        int aheadX;
        int aheadY;
    
};


