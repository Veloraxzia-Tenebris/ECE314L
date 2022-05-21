#include <Wire.h> 
#include <LiquidCrystal_I2C.h>
#include <SPI.h>
#include <nRF24L01.h>
#include <RF24.h>
#include <stdlib.h>

RF24 ant(7, 8); // CE, CSN

const byte address[6] = "00001";

int left = 0;
int right = 0;

LiquidCrystal_I2C disp(0x27, 16, 2);

void setup() {
	Serial.begin(9600);
	ant.begin();
	ant.openReadingPipe(0, address);
	ant.setPALevel(RF24_PA_MIN);
	ant.startListening();

	disp.begin();
	disp.backlight();
	disp.clear();
	disp.setCursor(3, 0);
	disp.print("Display On");
}
void loop() {
	if(ant.available()) {
		char text[8] = "";
		ant.read(&text, sizeof(text));
		Serial.println(text);
		char temp[4] = {text[0], text[1], text[2], text[3]};
		char tempp[5] = {text[4], text[5], text[6], text[7]};
		Serial.println(tempp);
		left = atoi(temp) - 1000;
		right = atoi(tempp) - 1000;
	}
	disp.clear();
	disp.setCursor(0, 0);
	disp.print("Left: ");
	disp.setCursor(7, 0);
	disp.print(left);
	disp.setCursor(0, 1);
	disp.print("Right: ");
	disp.setCursor(7, 1);
	disp.print(right);
	delay(10);
}
