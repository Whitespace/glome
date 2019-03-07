// Random sparkles
@LXCategory("Form")
public class Sparkle extends LXPattern {
  
  public final CompoundParameter rate = new CompoundParameter("rate", 10, 0, 100)
    .setDescription("Sparkle motion");

  public Sparkle(LX lx) {
    super(lx);
    addParameter("rate", this.rate);
  }
  
  public void run(double deltaMs) {
    float rate = this.rate.getValuef();

    for (LXPoint p : model.points) {
      if (random(0,100) < rate) {
        colors[p.index] = LXColor.hsb(0, 0, random(0, 100));
      } else {
        colors[p.index] = LXColor.hsb(0, 0, 0);
      }
    }
  }
}
