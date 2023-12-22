#include <Adafruit_NeoPixel.h>

#define PIN            6    //Neopixel data pin
#define NUMPIXELS      30   //Light num
#define L_BUTTON_PIN   3    //Light buttonpin
#define PHOTO_PIN      A0   //photo resister
#define buzzerPin      8    //buzzerpin
#define M_BUTTON_PIN   2    //Music buttonpin

Adafruit_NeoPixel pixels = Adafruit_NeoPixel(NUMPIXELS, PIN, NEO_GRBW + NEO_KHZ800);

#define NOTE_B4 494
#define NOTE_C5 523
#define NOTE_CS5 554
#define NOTE_D5 587
#define NOTE_DS5 622
#define NOTE_E5 659
#define NOTE_F5 698
#define NOTE_FS5 740
#define NOTE_G5 784
#define NOTE_GS5 831
#define NOTE_A5 880
#define NOTE_AS5 932
#define NOTE_B5 988
#define NOTE_C6 1047
#define NOTE_CS6 1109
#define NOTE_D6 1175
#define NOTE_DS6 1245
#define NOTE_E6 1319
#define NOTE_F6 1397
#define NOTE_FS6 1480
#define NOTE_G6 1568
#define NOTE_GS6 1661
#define NOTE_A6 1760
#define NOTE_AS6 1865
#define NOTE_B6 1976
#define NOTE_C7 2093
#define NOTE_CS7 2217
#define NOTE_D7 2349
#define NOTE_REST 0

int buttonState = 0;
int lastButtonState = HIGH;
int L_mode = 1;
uint32_t colors[NUMPIXELS];
int delayTime;

int M_mode = 1; 
int M_lightValue;

unsigned long previousMillis = 0;
const long interval = 1000;
int currentBrightness = 0; // 현재 밝기
int targetBrightness = 0;  // 목표 밝기
int step = 5;              // 밝기 조절 스텝 크기


int FirstMelody[] = {
  NOTE_REST, NOTE_B4, NOTE_D5, NOTE_E5, NOTE_G5, NOTE_REST, NOTE_D5, 
  NOTE_B4, NOTE_D5, NOTE_E5, NOTE_B5, NOTE_G5,
  NOTE_B5, NOTE_D6, NOTE_B5, NOTE_D6, NOTE_B5, NOTE_A5, NOTE_A5, NOTE_G5, 
  NOTE_D5, NOTE_G5, NOTE_FS5, NOTE_G5, NOTE_REST, NOTE_FS5, NOTE_G5, 
  NOTE_REST, NOTE_B4, NOTE_D5, NOTE_E5, NOTE_G5, NOTE_REST, NOTE_D5, 
  NOTE_B4, NOTE_D5, NOTE_E5, NOTE_B5, NOTE_G5,
  NOTE_B5, NOTE_D6, NOTE_B5, NOTE_D6, NOTE_B5, NOTE_A5, NOTE_A5, NOTE_G5, 
  NOTE_D5, NOTE_G5, NOTE_FS5, NOTE_G5, NOTE_REST, NOTE_FS5, NOTE_G5
};

int FirstNoteDurations[] = {
  4, 8, 8, 8, 8, 8, 8, 
  8, 8, 8, 2, 8, 
  8, 8, 8, 8, 8, 8, 8, 8, 
  8, 8, 8, 8, 8, 4, 8, 
  4, 8, 8, 8, 8, 8, 8, 
  8, 8, 8, 2, 8, 
  8, 8, 8, 8, 8, 8, 8, 8, 
  8, 8, 8, 8, 8, 4, 2
};


int SecondMelody[] = {
  NOTE_G5, NOTE_B5, NOTE_D6, NOTE_FS6, 
  NOTE_G6, NOTE_FS6, NOTE_D6, NOTE_B5, 
  NOTE_G5, NOTE_C6, NOTE_D6, NOTE_G6, 
  NOTE_D6, NOTE_A5, 
};

int SecondNoteDurations[] = {
  4, 4, 4, 4, 
  4, 4, 4, 4, 
  4, 4, 4, 4, 
  2.5, 4, 
};

int ThirdMelody[] = {
  NOTE_B5, NOTE_B5, NOTE_B5, 
  NOTE_B5, NOTE_B5, NOTE_B5, 
  NOTE_B5, NOTE_D6, NOTE_G5, NOTE_A5, 
  NOTE_B5, NOTE_REST,
  NOTE_C6, NOTE_C6, NOTE_C6, NOTE_C6, 
  NOTE_C6, NOTE_B5, NOTE_B5, NOTE_B5, 
  NOTE_B5, NOTE_A5, NOTE_A5, NOTE_B5, 
  NOTE_A5, NOTE_D6, 
  NOTE_B5, NOTE_B5, NOTE_B5, 
  NOTE_B5, NOTE_B5, NOTE_B5, 
  NOTE_B5, NOTE_D6, NOTE_G5, NOTE_A5, 
  NOTE_B5, NOTE_REST,
  NOTE_C6, NOTE_C6, NOTE_C6, NOTE_C6, 
  NOTE_C6, NOTE_B5, NOTE_B5, NOTE_B5, 
  NOTE_D6, NOTE_D6, NOTE_C6, NOTE_A5, 
  NOTE_G5
};

int ThirdNoteDurations[] = {
  8, 8, 4, 
  8, 8, 4, 
  8, 8, 6, 16, 
  4, 4,
  8, 8, 6, 16, 
  8, 8, 8, 8, 
  8, 8, 8, 8, 
  4, 4, 
  8, 8, 4, 
  8, 8, 4, 
  8, 8, 6, 16, 
  4, 4,
  8, 8, 6, 16, 
  8, 8, 8, 8, 
  8, 8, 8, 8, 
  2
};


void setup() {
  pixels.begin();         
  pinMode(M_BUTTON_PIN, INPUT_PULLUP);
  pinMode(buzzerPin, OUTPUT);
  pinMode(L_BUTTON_PIN, INPUT_PULLUP);
  Serial.begin(9600); 
  Serial.println("Press the button to control the Music and Lights");
  
}

void sendModeToProcessing(int mode) {
  Serial.print("M");
  Serial.println(mode);
}


void loop() {
  if (Serial.available() > 0) {
    char received = Serial.read();
    switch (received) {
      case '1':
        FirstplayMelody();
        break;
      case '2':
        SecondplayMelody();
        break;
      case '3':
        ThirdplayMelody();
        break;
    }

  }
  switch (M_mode) {
    case 1:     
      noTone(buzzerPin);
      break;
    case 2:    
      FirstplayMelody();
      break;
    case 3:     
      SecondplayMelody();
      break;
    case 4:
      ThirdplayMelody();
      break;
    case 5:   
      M_lightValue = analogRead(PHOTO_PIN);
      Serial.print("Light Value: ");
      Serial.println(M_lightValue);
      chooseMelodyByLight(M_lightValue);
      break;

  }
   if (digitalRead(M_BUTTON_PIN) == LOW) {
    delay(50); 
    M_mode = (M_mode % 6) + 1; 
    Serial.print("Music Mode changed to: ");
    Serial.println(M_mode);
    while (digitalRead(M_BUTTON_PIN) == LOW) {} 
    delay(50); 
  }


  
  buttonState = digitalRead(L_BUTTON_PIN);

  if (buttonState != lastButtonState) {
    if (buttonState == LOW) {
      changeMode();
    }
    delay(50);
  }

  lastButtonState = buttonState;

  switch (L_mode) {
    case 1:
      turnOffLights();
      break;
    case 2:
      alternateColors();
      break;
    case 3:
      blinkAlternate(); 
      break;
    case 4:
      brightnessBasedLight();
      break;

  }
}

void changeMode() {
  L_mode = (L_mode % 5) + 1; 
  Serial.print("Light Mode changed to: ");
  Serial.println(L_mode);
  
  if (L_mode == 1) {
    turnOffLights();
  } else {
    pixels.clear();
    pixels.show();
    if (L_mode == 2) {
      for (int i = 0; i < NUMPIXELS; i++) {
        colors[i] = pixels.Color(random(256), random(256), random(256));
      }
    }
  }
  delay(50);
}

bool isRed = true; // 빨간색 또는 초록색 여부를 나타내는 플래그 변수

void alternateColors() {
  for (int i = 0; i < NUMPIXELS; i++) {
    if (isRed) {
      pixels.setPixelColor(i, pixels.Color(255, 0, 0)); // 빨간색
    } else {
      pixels.setPixelColor(i, pixels.Color(0, 255, 0)); // 초록색
    }
    isRed = !isRed; // 색을 교차시킴
  }
  pixels.show();
}

void brightnessBasedLight() {
  unsigned long currentMillis = millis();

  // 1초마다 포토레지스터 값을 읽어 목표 밝기 설정
  if (currentMillis - previousMillis >= interval) {
    int L_lightValue = analogRead(PHOTO_PIN);

    // 포토레지스터 값을 기반으로 목표 밝기 설정
    targetBrightness = map(L_lightValue, 0, 1023, 0, 255);

    previousMillis = currentMillis; // 현재 시간을 저장하여 다음 밝기 조절을 위해 사용

    // 이제 매번 밝기 조절을 수행
    if (currentBrightness < targetBrightness) {
      currentBrightness = min(currentBrightness + step, targetBrightness);
    } else if (currentBrightness > targetBrightness) {
      currentBrightness = max(currentBrightness - step, targetBrightness);
    }

    for (int i = 0; i < NUMPIXELS; i++) {
      if (i % 2 == 0) {
        // 짝수 인덱스의 픽셀은 빨간색
        pixels.setPixelColor(i, pixels.Color(currentBrightness, 0, 0)); // 빨간색 밝기 조절
      } else {
        // 홀수 인덱스의 픽셀은 초록색
        pixels.setPixelColor(i, pixels.Color(0, currentBrightness, 0)); // 초록색 밝기 조절
      }
    }

    pixels.show();
  }
}


void blinkAlternate() {
  for (int i = 0; i < NUMPIXELS; i++) {
    if (i % 2 == 0) {
      pixels.setPixelColor(i, pixels.Color(255, 0, 0)); // 짝수 번째 픽셀은 빨간색
    } else {
      pixels.setPixelColor(i, pixels.Color(0, 255, 0)); // 홀수 번째 픽셀은 초록색
    }
  }

  pixels.show();
  delay(500);

  for (int i = 0; i < NUMPIXELS; i++) {
    if (i % 2 == 0) {
      pixels.setPixelColor(i, pixels.Color(0, 255, 0)); // 짝수 번째 픽셀은 초록색
    } else {
      pixels.setPixelColor(i, pixels.Color(255, 0, 0)); // 홀수 번째 픽셀은 빨간색
    }
  }

  pixels.show();
  delay(500);
}



void turnOffLights() {
  pixels.clear();
  pixels.show();
}

void FirstplayMelody() {
  Serial.println("1");
  for (int thisNote = 0; thisNote < sizeof(FirstMelody) / sizeof(FirstMelody[0]); thisNote++) {
    int noteDuration = 1500 / FirstNoteDurations[thisNote];
    tone(buzzerPin, FirstMelody[thisNote], noteDuration);

    float pauseBetweenNotes = noteDuration * 1.30;
    delay(pauseBetweenNotes);

    noTone(buzzerPin);
  }
  Serial.println("-1");
}



void SecondplayMelody() {
  Serial.println("2");
  for (int thisNote = 0; thisNote < sizeof(SecondMelody) / sizeof(SecondMelody[0]); thisNote++) {
    int noteDuration = 1500 / SecondNoteDurations[thisNote];
    tone(buzzerPin, SecondMelody[thisNote], noteDuration);

    float pauseBetweenNotes = noteDuration * 1.30;
    delay(pauseBetweenNotes);

    noTone(buzzerPin);
  }
  Serial.println("-2");
}

void ThirdplayMelody() {
  Serial.println("3");
  for (int thisNote = 0; thisNote < sizeof(ThirdMelody) / sizeof(ThirdMelody[0]); thisNote++) {
    int noteDuration = 1500 / ThirdNoteDurations[thisNote];
    tone(buzzerPin, ThirdMelody[thisNote], noteDuration);

    float pauseBetweenNotes = noteDuration * 1.30;
    delay(pauseBetweenNotes);

    noTone(buzzerPin);
    
  }
  Serial.println("-3");
}

void chooseMelodyByLight(int S_lightValue) {
  if (S_lightValue > 300) {
    FirstplayMelody();
  } else if (S_lightValue > 150) {
    SecondplayMelody();
  } else {
    ThirdplayMelody();
  }
}

