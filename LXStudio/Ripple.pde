// Random sparkles
@LXCategory("Form")
public class Ripple extends LXPattern {
  public final CompoundParameter centerIndex = new CompoundParameter("centerIndex", 0, 0, model.points.length - 1)
    .setDescription("speed");

  public final CompoundParameter speed = new CompoundParameter("speed", 0.5, 0, 1)
    .setDescription("speed");

  public final CompoundParameter thickness = new CompoundParameter("thickness", 10, 0, 100)
    .setDescription("thickness");

  public Ripple(LX lx) {
    super(lx);
    addParameter("speed", this.speed);
    addParameter("centerIndex", this.centerIndex);
    addParameter("thickness", this.thickness);
  }
  
  public void run(double deltaMs) {
    LXPoint center = model.points[(int)this.centerIndex.getValuef()];

    int t = millis();
    int finish = 100;

    float speed = this.speed.getValuef();
    float thickness = this.thickness.getValuef();

    float r = t / 10 * speed % finish;

    int white = LXColor.hsb(0, 0, 100);
    int black = LXColor.hsb(0, 0, 0);


    for (LXPoint p : model.points) {
      float distance = dist(center.x, center.y, center.z, p.x, p.y, p.z);

      if (r + thickness >= distance && distance >= r - thickness) {
        colors[p.index] = white;
      } else {
        colors[p.index] = black;
      }
    }
  }
}
