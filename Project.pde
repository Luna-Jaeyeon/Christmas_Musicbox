import processing.serial.*;

PImage bg_img;
Serial arduino;

int[] CS_btX;
int[] CS_btY; // 버튼 위치
int btSize = 250; // 버튼 크기
color[] btDefaultColors = new color[3];
color bt_pressed_color;
boolean[] CSbtOver = new boolean[3];
int playingSong = 0; // 현재 연주 중인 곡 번호

void setup() {
  size(1080, 1080);
  bg_img = loadImage("Tree.png");
  btDefaultColors[0] = color(255, 0, 0, 150); // 붉은색
  btDefaultColors[1] = color(255, 255, 0, 150); // 노란색
  btDefaultColors[2] = color(0, 255, 0, 150); // 초록색
  bt_pressed_color = color(255, 255, 255, 150); // 흰색

  CS_btX = new int[]{172, 860, 408}; // X 좌표
  CS_btY = new int[]{665, 394, 165}; // Y 좌표
  
  String portName = "COM6"; 
  arduino = new Serial(this, portName, 9600);
  arduino.bufferUntil('\n');
}

void serialEvent(Serial myPort) {
  String inputString = myPort.readStringUntil('\n');
  if (inputString != null) {
    inputString = trim(inputString);
    if (inputString.equals("1")) {
      playingSong = 1;
    } else if (inputString.equals("-1")) {
      playingSong = 0;
    } else if (inputString.equals("2")) {
      playingSong = 2;
    } else if (inputString.equals("-2")) {
      playingSong = 0;
    } else if (inputString.equals("3")) {
      playingSong = 3;
    } else if (inputString.equals("-3")) {
      playingSong = 0;
    }
  }
}

void draw() {
  background(bg_img);

  for (int i = 0; i < 3; i++) {
    update(i, mouseX, mouseY);

    if ((i == 0 && playingSong == 1) || (i == 1 && playingSong == 2) || (i == 2 && playingSong == 3)) {
      fill(bt_pressed_color); // 연주 중인 곡에 해당하는 원
    } else if (CSbtOver[i]) {
      fill(bt_pressed_color); // 마우스가 위에 있는 원
    } else {
      fill(btDefaultColors[i]); // 기본 색상
    }

    noStroke();
    ellipse(CS_btX[i], CS_btY[i], btSize, btSize);
  }
}


boolean overCSButton(int x, int y) {
  float distance = dist(mouseX, mouseY, x, y);
  return distance <= btSize / 2;
}

void update(int index, int x, int y) {
  CSbtOver[index] = overCSButton(CS_btX[index], CS_btY[index]);
}

void mousePressed() {
  for (int i = 0; i < 3; i++) {
    if (CSbtOver[i]) {
      if (i == 0) {
        arduino.write('1');
      } else if (i == 1) {
        arduino.write('2');
      } else if (i == 2) {
        arduino.write('3');
      }
      // 추가 버튼에 대한 처리를 여기에 추가합니다.
    }
  }
}
