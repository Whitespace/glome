// Random sparkles
@LXCategory("Form")
public class RandomNoise extends LXPattern {
  public final CompoundParameter hue = new CompoundParameter("hue", 10, 0, 360)
    .setDescription("Hue");

  public final CompoundParameter saturation = new CompoundParameter("saturation", 10, 0, 100)
    .setDescription("Saturation");

  public final CompoundParameter brightness = new CompoundParameter("brightness", 10, 0, 100)
    .setDescription("Brightness");

  public RandomNoise(LX lx) {
    super(lx);
    addParameter("hue", this.hue);
    addParameter("saturation", this.saturation);
    addParameter("brightness", this.brightness);
  }
  
  public void run(double deltaMs) {
    float hue = this.hue.getValuef();
    float saturation = this.saturation.getValuef();
    float brightness = this.brightness.getValuef();
    
    for (LXPoint p : model.points) {
      int c = LXColor.hsb(hue, saturation, brightness);
      colors[p.index] = c;
    }
  }
}
