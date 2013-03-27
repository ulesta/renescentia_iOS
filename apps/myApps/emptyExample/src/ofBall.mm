#include "ofBall.h"
#include "testApp.h"
#define ACCELEROMETER_FORCE		0.9
#define VELOCITY 30


ofBall::ofBall()
{
    x = ofRandom(0, MAXHEIGHT);      // give some random positioning
    y = ofRandom(0, MAXWIDTH);
    
    speedX = ofRandom(-1, 1);           // and random speed and direction
    speedY = ofRandom(-1, 1);
    
    //speedX = 5;         // and random speed and direction
    //speedY = 5;
    
    colorR = ofRandom(255);
    colorG = ofRandom(255);
    colorB = ofRandom(255);
    
        
    dim = ofRandom(1, 10);
    
    amp = ofRandom(4,10);
}

ofBall::ofBall(int i, int j)
{
    x = i;
    y = j;
    
    speedX = 0;           // and random speed and direction
    speedY = 0;
    
    //speedX = 5;         // and random speed and direction
    //speedY = 5;
        
    dim = ofRandom(1);
}

void ofBall::update(ofBall guide){
    /*if(x < 0 + dim ){
        x = 0 + dim;
        speedX *= -1;
    } else if(x > MAXHEIGHT - dim){
        x = MAXHEIGHT - dim;
        speedX *= -1;
    }
    
    if(y < 0 + dim){
        y = 0 + dim;
        speedY *= -1;
    } else if(y > MAXWIDTH - dim){
        y = MAXWIDTH - dim;
        speedY *= -1;
    }*/
    
    int vel = 30;
 

    /*if ( guide.x <= 0)
    {
       //x+=speedX;
       vel = 0;
       x+=1;
    }
    else if ( guide.x >= MAXWIDTH) {
        vel = 0;
        x-=1;
    }
    else*/
    
            y+=speedY + (ACCELEROMETER_FORCE * ofxAccelerometer.getForce().y * VELOCITY);
           x+=speedX - (ACCELEROMETER_FORCE * ofxAccelerometer.getForce().x * VELOCITY);
    
    /*if ( guide.y <= 0)
    {
       //x+=speedX;
       vel = 0;
       y-=1;
    }
    else if ( guide.x >= MAXHEIGHT) {
        vel = 0;
        x-=1;
    }
    else
           x+=speedX - (ACCELEROMETER_FORCE * ofxAccelerometer.getForce().x * VELOCITY);*/
    
    /*if ( guide.y >= 0)
    {
        y+=speedY + (ACCELEROMETER_FORCE * ofxAccelerometer.getForce().y * VELOCITY);
    }
    if (guide.y <= 0)
    {
        y+=speedY - (ACCELEROMETER_FORCE * ofxAccelerometer.getForce().y * VELOCITY);
    }*/
    
    
    

}

void ofBall::draw(double time){
    // values for R, G, B
//<<<<<<< HEAD
    //Playing around with the ball's shape
    ofSetColor(((0.5*sin(time/amp)+0.5)*colorR), ((0.5*sin(time/amp)+0.5)*colorG), ((0.5*sin(time/amp)+0.5)*colorB));
    ofPushMatrix();
    ofTranslate(x, y);
    ofRotate(amp*360);
    ofCircle(0, 0, dim);
    ofRect(0,0,dim, dim);
    ofPopMatrix();
//=======
    ofSetColor(colorR, colorG, colorB);
    
//>>>>>>> I tried to create a random number of balls at once!
    ofSetColor(255,255,255);
} 