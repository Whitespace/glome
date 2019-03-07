/** 
 * Welcome to the Glome!
 */

// Global constants
final static String PIXEL_FILE = "./data/pixels.json";
final static boolean DOES_TOM_LOVE_CATS = true;

// Static reference to applet
static PApplet applet;

// Internals
heronarts.lx.studio.LXStudio lx;
LXModel glome;

void setup() {
  // Processing setup, constructs the window and the LX instance
  size(800, 720, P3D);
  applet = this;
  glome = buildGlome();

  lx = new heronarts.lx.studio.LXStudio(this, glome, MULTITHREADED);
  lx.ui.setResizable(RESIZABLE);
}

// https://github.com/heronarts/LXStudio/wiki/Mapping-Outputs
void initialize(final heronarts.lx.studio.LXStudio lx, heronarts.lx.studio.LXStudio.UI ui) {
  final String ARTNET_IP = "192.168.1.50";
  try {
    // Construct a new DatagramOutput object
    LXDatagramOutput output = new LXDatagramOutput(lx);

    // manually send each panel to the pixlite
    //   each panel is either 468 or 390 pixels
    //   DMX takes 512 bytes per universe
    //   512/3 = RGB 170 pixels
    // so split each panel into groups of 170 or fewer pixels, and send their colors on a single universe
    // we do this by computing which pixels to send on each universe and creating a Datagram object, which will pull the colors for us
    //
    // we can just precompute everything and inline it
    int currentPixelIndex = 0;
    final int[] counts = {170,170,128,170,170,128,170,170,128,170,170,128,170,170,128,170,170,128,170,170,50,170,170,50,170,170,50,170,170,50};
    for (int universeIndex = 0; universeIndex < counts.length; ++universeIndex) {
      int count = counts[universeIndex];

      // generate an array of length count with the pixel indices to send on this universe
      int[] pixelIndices = new int[count];
      for (int i = 0; i < count; ++i) {
        pixelIndices[i] = i + currentPixelIndex;
      }
      ArtNetDatagram strip = new ArtNetDatagram(pixelIndices, universeIndex);
      strip.setAddress(ARTNET_IP);
      output.addDatagram(strip);

      applet.println("[ArtNet] sending pixels " + currentPixelIndex + " through " + (currentPixelIndex + count) + " on universe " + universeIndex);
      currentPixelIndex += count;
    }

    // Add the datagram output to the LX engine
    lx.addOutput(output);
  } catch (Exception x) {
    x.printStackTrace();
  }}

void onUIReady(heronarts.lx.studio.LXStudio lx, heronarts.lx.studio.LXStudio.UI ui) {
  // Add custom UI components here
}

void draw() {
  // All is handled by LX Studio
}

// Configuration flags
final static boolean MULTITHREADED = true;
final static boolean RESIZABLE = true;

// Helpful global constants
final static float INCHES = 1;
final static float IN = INCHES;
final static float FEET = 12 * INCHES;
final static float FT = FEET;
final static float CM = IN / 2.54;
final static float MM = CM * .1;
final static float M = CM * 100;
final static float METER = M;
