// Random sparkles
@LXCategory("Form")
public class Ripple extends LXPattern {
  public final CompoundParameter speed = new CompoundParameter("speed", 1, 0, 2)
    .setDescription("speed");

  public final CompoundParameter duration = new CompoundParameter("duration", 1000, 100, 5000)
    .setDescription("duration (ms)");

  public final CompoundParameter thickness = new CompoundParameter("thickness", 3, 1, 80)
    .setDescription("thickness");

  public final CompoundParameter centerIndex = new CompoundParameter("centerIndex", 0, 0, model.points.length - 1)
    .setDescription("centerIndex");

  public final CompoundParameter quantity = new CompoundParameter("quantity", 1, 1, 100)
    .setDescription("quantity");

  public Ripple(LX lx) {
    super(lx);
    addParameter("duration", this.duration);
    addParameter("speed", this.speed);
    addParameter("thickness", this.thickness);

    addParameter("centerIndex", this.centerIndex);
    //addParameter("quantity", this.quantity);
  }

  private final int black = LXColor.hsb(0, 0, 0);
  
  public void run(double deltaMs) {
    // constants
    float radiusFudgeFactor = 0.25; // radius is in global units, so we need to scale it so a pulse travels the whole glome in 1000ms at 1 speed by default

    // parameters
    LXPoint center = model.points[(int)this.centerIndex.getValuef()];
    float pulseSpeed = this.speed.getValuef();
    float pulseDuration = this.duration.getValuef();
    float pulseThickness = this.thickness.getValuef();

    // computed values
    float t = millis() % pulseDuration;
    float radius = t * pulseSpeed * radiusFudgeFactor;
    float pulseBrightness = 1 - t / pulseDuration; // should move from linear to http://gizma.com/easing/#quad3

    for (LXPoint p : model.points) {
      float distanceToCenter = dist(center.x, center.y, center.z, p.x, p.y, p.z);
      float distanceToRadius = abs(distanceToCenter - radius);

      if (distanceToRadius < pulseThickness) {
        float proximityToPulseCenter = distanceToRadius / pulseThickness;
        float linearEasing = 1 - proximityToPulseCenter;

        colors[p.index] = LXColor.hsb(0, 0, 100 * linearEasing * pulseBrightness);
      } else {
        colors[p.index] = black;
      }
    }
  }
}
