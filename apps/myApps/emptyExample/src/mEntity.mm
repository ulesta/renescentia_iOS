#include "mEntity.h"
#include "testApp.h"

mEntity::mEntity()
{
    ofxAccelerometer.setup();
    ofxAccelerometer.setForceSmoothing(3);
    numEat = 0;
    
    // 0 = circle, 1 = triangle, 2 = square
    

    /*for (int i = 0; i <= sizeof(shapesEat); i+=3)
    {
        shapesEat[i] = 0;
    }
    
    for (int i = 1; i <= sizeof(shapesEat); i+=3)
    {
        shapesEat[i] = 1;
    }
    
    for (int i = 2; i <= sizeof(shapesEat); i+=3)
    {
        shapesEat[i] = 2;
    }*/
    
    /*for (int i = 0; i <= 5; i++)
    {
        shapesEat[i] = 0;
    }
    for (int i = 6; i <= 12; i++)
    {
        shapesEat[i] = 1;
    }*/
    
    shapesEat[0] = 0;
    shapesEat[1] = 1;
    shapesEat[2] = 2;
    shapesEat[3] = 1;
    shapesEat[4] = 1;
    shapesEat[5] = 0;
    shapesEat[6] = 1;
    shapesEat[7] = 1;
    shapesEat[8] = 0;
    shapesEat[9] = 0;
    shapesEat[10] = 1;
    shapesEat[11] = 1;
    shapesEat[12] = 1;
    shapesEat[13] = 2;
    shapesEat[14] = 2;
    
    
    angletemp = 360 - RAD_TO_DEG * atan2( ofxAccelerometer.getForce().y, ofxAccelerometer.getForce().x );
    counter = 0;
    angle = 0;
    
}

void mEntity::update(){
    
    
    angle = 180 - RAD_TO_DEG * atan2( ofxAccelerometer.getForce().y, ofxAccelerometer.getForce().x );
    
    amp1 = (sin(ofGetElapsedTimef())+2)*5.0;
    amp2 = (sin(ofGetElapsedTimef())+2)*5.0;
    
}

void mEntity::draw(double time, double currentX, double currentY, double mainX, double mainY){
    
    /////// ENTITY Start
    ofPushMatrix();
    {
        ofTranslate(mainX, mainY);
        ofRotate(angle);
        
        ofRotate(270);
        
        ofSetColor(((0.5*sin(time/5)+0.5)*50), ((0.5*sin(time/5)+0.5)*100), ((0.5*sin(time/5)+0.5)*255));
        ofFill();
    
        
        
    // Rotating entity 1
    ofPushMatrix();
    {   ofRotate((time/15)*360);
        ofTranslate(16, 0);
        ofCircle(0, 0, 3);
    }
        ofPopMatrix(); 
        

    ofCircle(0, 0, 12); // HEAD
    ofSetColor(255, 255, 255);
    ofTriangle(-10, 0, 0, -10, 10, 0);
    
    ofSetColor(((0.5*sin(time/5)+0.5)*50), ((0.5*sin(time/5)+0.5)*100), ((0.5*sin(time/5)+0.5)*255));
    
    
    // void recursiveDraw(int depth, int MAX, int counter, int AMP);
    // rules of thumb : - depth must be (numEat - actual depth)
    //                  - (max - counter) == actual depth
    //                  - counter iterates through objects ate, it has to be on the first index of that limb
    //                      i.e. if current limb has 6 elements, and previous limb has 5, prev limb [0,...,4], then
    //                            current limb [5,...,10], therefore counter = 5, MAX = 6+5 = 11
    //                  - AMP is the amplitude i.e. how much the limb will 'wave'
        
        ofPushMatrix();
            recursiveDraw(numEat, 6, 0, amp1);
        ofPopMatrix();
        ofPushMatrix();
            ofRotate(45);
            recursiveDraw(numEat, 6, 0, amp2);
        ofPopMatrix();
        
    if (numEat > 6) {
        ofPushMatrix();
            ofRotate(90);
            recursiveDraw(numEat-6, 12, 6, amp1);
        ofPopMatrix();
        ofPushMatrix();
            ofRotate(135);
            recursiveDraw(numEat-6, 12, 6, amp2);
        ofPopMatrix();
        
    }

    
    }
    ofPopMatrix();

    ofSetColor(255,255,255);
} 

void mEntity::recursiveDraw(int depth, int MAX, int counter, int AMP)
{       if (counter >= MAX)
        {
            return;
        }
        if (depth == 0) {
            return;
        }
        else {
            ofTranslate(0, 20);
            if (shapesEat[counter] == 1)
                ofTriangle(-10, -10, 0, 10, 10, -10);
            else if (shapesEat[counter] == 0)
                ofCircle(0, 0, 10);
            else if (shapesEat[counter] == 2)
                ofRect(-10, -10, 20, 20);
            ofPushMatrix();
                if (depth <= MAX/2)
                    ofRotate(sin((ofGetElapsedTimef()*10)/3)*AMP);
                else
                    ofRotate(cos((ofGetElapsedTimef()*10)/3)*AMP);
                depth -= 1;
                counter += 1;
                recursiveDraw(depth, MAX, counter, AMP);
            ofPopMatrix();
        }
}