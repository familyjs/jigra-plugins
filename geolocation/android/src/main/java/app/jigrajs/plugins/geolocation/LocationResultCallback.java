package app.jigrajs.plugins.geolocation;

import android.location.Location;

public interface LocationResultCallback {
  void success(Location location);
  void error(String message);
}
