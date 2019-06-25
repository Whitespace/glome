import heronarts.lx.model.*;
import java.util.Collections;
import java.util.List;

LXModel buildGlome() {
  return new Glome();
}

public static class Glome extends LXModel {
  
  public Glome() {
    super(new Fixture());
  }
  
  public static class Fixture extends LXAbstractFixture {
    Fixture() {
      try {
        JSONObject file = applet.loadJSONObject("pixels2.json");
        JSONArray panels = file.getJSONArray("Pixels");
        for (int i = 0; i < panels.size(); ++i) {
          JSONArray panel = panels.getJSONArray(i);
            for (int j = 0; j < panel.size(); ++j) {
              JSONObject pixel = panel.getJSONObject(j);
              float x = pixel.getFloat("x");
              float y = pixel.getFloat("y");
              float z = pixel.getFloat("z");
              addPoint(new LXPoint(x, y, z));
            }
        }
      } catch (NullPointerException x) {
        println("Fuck my life");
      }
    }
  }
}
