#ifndef _M_ENTITY // if this class hasn't been defined, the program can define it
#define _M_ENTITY // by using this if statement you prevent the class to be called more 
// than once which would confuse the compiler

#include "ofMain.h"
#include "ofxiPhone.h"
#include "ofxiPhoneExtras.h"

class mEntity {
    
public: // place public functions or variables declarations here
    
    // methods, equivalent to specific functions of your class objects
    void update();  // update method, used to refresh your objects properties
    void draw(double time, double currentX, double currentY, double mainX, double mainY);   // draw method, this where you'll do the object's drawing 
    
    void recursiveDraw(int depth, int MAX, int counter, int AMP);
    
    // variables    
    int numEat;
    int shapesEat[50];
    
    float angletemp;
    float angle;
    int counter;
    
    float angles[30];
    
    float accelY;
    float accelX;
    
    float laccelY;
    float laccelX;
    
    float kFilteringFactor;
    
    float amp1;
    float amp2;
    
    
    mEntity(); // constructor - used to initialize an object, if no properties are passed
    //               the program sets them to the default value
    
private: // place private functions or variables declarations here
    
}; // dont't forget the semicolon!!

#endif 