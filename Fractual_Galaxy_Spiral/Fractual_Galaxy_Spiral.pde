int numParticles = 500;  // Number of particles in the galaxy
float angleOffset = 0;    // Offset for rotation animation
float spiralFactor = 0.1; // Factor controlling the tightness of the spiral
float speed = 0.015;       // Speed of particle rotation
float fractalFactor = 0.02; // Factor controlling fractal detail

void setup() {
  size(1000, 600);
  noStroke();
}

void draw() {
  background(10, 10, 30);  // Dark background for galaxy effect

  translate(width / 2, height / 2);  // Move the origin to the center

  // Update angle offset for rotation animation
  angleOffset += speed;

  // Draw each particle
  for (int i = 0; i < numParticles; i++) {
    // Calculate angle and distance for each particle based on index
    float angle = i * spiralFactor + angleOffset;
    float distance = sqrt(i) * fractalFactor * 300;

    // Calculate x and y positions using polar coordinates
    float x = cos(angle) * distance;
    float y = sin(angle) * distance;

    // Sinusoidal oscillation for a wavy effect on distance
    float wave = sin(angle * 5 + frameCount * 0.02) * 10;
    x += cos(angle) * wave;
    y += sin(angle) * wave;

    // Set color gradient from purple to blue to white
    float hue = map(i, 0, numParticles, 200, 360);
    float brightness = map(distance, 0, 400, 255, 100);
    fill(colorFromHue(hue), brightness, 255, 150);

    // Draw particle
    ellipse(x, y, 4, 4);
  }
}

// Helper function to generate colors based on hue
color colorFromHue(float hue) {
  float r, g, b;
  hue = hue % 360; // Ensure hue wraps around within [0, 360]
  if (hue < 120) {
    r = 255 - (hue / 120) * 255;
    g = (hue / 120) * 255;
    b = 0;
  } else if (hue < 240) {
    hue -= 120;
    r = 0;
    g = 255 - (hue / 120) * 255;
    b = (hue / 120) * 255;
  } else {
    hue -= 240;
    r = (hue / 120) * 255;
    g = 0;
    b = 255 - (hue / 120) * 255;
  }
  return color(r, g, b);
}
