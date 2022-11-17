#include <stdio.h>
#include <IIRFilter.h>

/* FILTER COEFFS REDACTED; SAMPLE OFFLINE DATA REDACTED
 * const double a[] = {0};
const double b[] = {0};
const double o[463] = {1};
const double h[401] = {0};
int x[15000] = {0};
IIRFilter iir(b, a);

*/

void setup() {
  Serial.begin(115200);
  analogReadResolution(8);
  analogReadAveraging(1);
    /*for(int i = 0; i < 16000; i++) {
      double out = iir.filter(x[i]);
      Serial.println(out);
    }*/

  
}
int in;
double desiredPhase = 0;
int counter = 0;
double outBP;
int bufferCounter = 0;
// FIR BUFFER/LAG SPECS REDACTED
double realLag[0] = {0};
int lag = 0;
double firBuffer[0] = {0}; 
int bufLen = 0; // This length is = to the # of hilbert coeffs
double outH;
double tmp;
double p;
int startTime;
bool checkWave = true; 

void loop() {


  
    in = analogRead(A0);
    startTime = micros();
    outBP = iir.filter(in);
    //Serial.println(outBP);
    if(bufferCounter < bufLen) { // STARTUP FILLS UP BUFFER
      firBuffer[bufferCounter] = outBP;
      bufferCounter++;
      if(bufferCounter >= bufLen - lag + 1 && bufferCounter < bufLen) {
        realLag[bufferCounter - lag] = outBP;
      }
    }
    else {
      
      for(int j = 0; j < lag; j++) { // FIFO REFILL
        realLag[j] = realLag[j + 1];
      }
      for(int k = 0; k < bufLen-1; k++) { // FIFO REFILL
        firBuffer[k] = firBuffer[k + 1];
      }
      realLag[lag] = outBP;
      firBuffer[0] = outBP;


      tmp = 0;
      // FIR FUNC LOOP
      for(int i = 0; i < bufLen; i++) {
        tmp += h[bufLen-1-i] * firBuffer[i];
      }

      
      outH = tmp;
      
      p = atan2(outH, realLag[0]);
      if(p > desiredPhase - 0.05 && p < desiredPhase + 0.05 && checkWave == true) {
        digitalWrite(0, HIGH);
        delayMicroseconds(200);
        digitalWrite(0, LOW);
        delayMicroseconds(75);
        checkWave = false;
      }
      else {
        if(desiredPhase > -3) {
          if(p < desiredPhase - 0.1) {
            checkWave = true;
          }
        }
        else {
          if(p > desiredPhase + 0.1) {
            checkWave = true;
          }
        }
        delayMicroseconds(275);
      }
      Serial.print(p);
      Serial.print(",");
      Serial.println(outBP/20);
      //delay(5);
      
      
      
    }
    counter += 1;


    



    
}
