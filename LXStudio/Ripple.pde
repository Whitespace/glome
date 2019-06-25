// Random sparkles
@LXCategory("Form")
public class Ripple extends LXPattern {
  public final CompoundParameter duration = new CompoundParameter("duration", 1000, 100, 5000)
    .setDescription("duration (ms)");

  public final CompoundParameter thickness = new CompoundParameter("thickness", 10, 1, 80)
    .setDescription("thickness");

  public Ripple(LX lx) {
    super(lx);
    addParameter("duration", this.duration);
    addParameter("thickness", this.thickness);
  }

  private final int black = LXColor.hsb(0, 0, 0);
  private float previous_t = 0;
  private LXPoint center = model.points[(int)random(model.points.length - 1)];
  private float jitter = random(500);

  public void run(double deltaMs) {
    // constants
    float radiusFudgeFactor = 0.05; // radius is in global units, so we need to scale it so a pulse travels the whole glome in 1000ms at 1 speed by default

    // parameters
    float pulseDuration = this.duration.getValuef(); // + jitter;
    float pulseThickness = this.thickness.getValuef();

    // computed values
    float t = millis() % pulseDuration;
    float radius = t * radiusFudgeFactor;
    float pulseBrightness = t / pulseDuration;
    float easedPulseBrightness = 1 - pow(pulseBrightness, 3);

    // new pulse detected
    if (t < previous_t) {
      center = model.points[(int)random(model.points.length - 1)];
      jitter = random(500);
    }

    for (LXPoint p : model.points) {
      float distanceToCenter = dist(center.x, center.y, center.z, p.x, p.y, p.z);
      float distanceToRadius = abs(distanceToCenter - radius + pulseThickness); // pulse is eased on both sides
      //float distanceToRadius = distanceToCenter - radius + pulseThickness; // pulse is eased on back side only; front is solid

      if (distanceToRadius < pulseThickness) {
        float proximityToPulseCenter = distanceToRadius / pulseThickness;
        float easedPulseThickness = 1 - pow(proximityToPulseCenter, 3);

        colors[p.index] = LXColor.hsb(0, 0, 100 * easedPulseThickness * easedPulseBrightness);
      } else {
        colors[p.index] = black;
      }
    }

    previous_t = t;
  }
}
