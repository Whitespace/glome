// A simple example of using Processing's noise() function to draw LED clouds
// https://github.com/scanlime/fadecandy/blob/master/examples/processing/grid8x8_noise_simple/grid8x8_noise_simple.pde
// Copyright Micah Scott
@LXCategory("Form")
public class Clouds extends LXPattern {
    
  public final CompoundParameter speed = new CompoundParameter("speed", 50, 1, 500)
    .setDescription("Speed of the clouds");

  public final CompoundParameter noisiness = new CompoundParameter("noisiness", 500, 5, 1000)
    .setDescription("Noisiness of the background");

  public final CompoundParameter saturation_one = new CompoundParameter("saturation_one", 0.5, 0.0, 1.0)
    .setDescription("saturation_one");

  public final CompoundParameter saturation_two = new CompoundParameter("saturation_two", 100, 0, 100)
    .setDescription("saturation_two");

  public final CompoundParameter zoom = new CompoundParameter("zoom", 10, 1, 100)
    .setDescription("Look into the clouds");


  public Clouds(LX lx) {
    super(lx);
    //addParameter("axis", this.axis);
    //addParameter("pos", this.pos);
    addParameter("speed", this.speed);
    addParameter("noisiness", this.noisiness);
    addParameter("saturation_one", this.saturation_one);
    addParameter("saturation_two", this.saturation_two);
    addParameter("zoom", this.zoom);
  }
  
  public void run(double deltaMs) {
    float speed = this.speed.getValuef() / 1000000;
    float noisiness = this.noisiness.getValuef();
    float saturation_one = this.saturation_one.getValuef();
    float saturation_two = this.saturation_two.getValuef();
    float zoom = this.zoom.getValuef() / 1000;

    float hue = (noise(millis() * speed) * 200) % 360;
    float dx = millis() * speed;

    for (LXPoint p : model.points) {
      float n = noisiness * (noise(dx + p.x * zoom, p.y * zoom, p.z * zoom) * saturation_one);

      colors[p.index] = LXColor.hsb(hue, saturation_two, n); 
    }
  }
}
