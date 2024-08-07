package app.jigrajs.plugins.applauncher;

import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.net.Uri;
import com.getjigra.JSObject;
import com.getjigra.Logger;
import com.getjigra.Plugin;
import com.getjigra.PluginCall;
import com.getjigra.PluginMethod;
import com.getjigra.annotation.JigraPlugin;
import com.getjigra.util.InternalUtils;

@JigraPlugin(name = "AppLauncher")
public class AppLauncherPlugin extends Plugin {

  @PluginMethod
  public void canOpenUrl(PluginCall call) {
    String url = call.getString("url");
    if (url == null) {
      call.reject("Must supply a url");
      return;
    }

    Context ctx = this.getActivity().getApplicationContext();
    final PackageManager pm = ctx.getPackageManager();

    JSObject ret = new JSObject();
    try {
      InternalUtils.getPackageInfo(pm, url, PackageManager.GET_ACTIVITIES);
      ret.put("value", true);
      call.resolve(ret);
      return;
    } catch (PackageManager.NameNotFoundException e) {
      Logger.error(getLogTag(), "Package name '" + url + "' not found!", null);
    }

    ret.put("value", false);
    call.resolve(ret);
  }

  @PluginMethod
  public void openUrl(PluginCall call) {
    String url = call.getString("url");
    if (url == null) {
      call.reject("Must provide a url to open");
      return;
    }

    JSObject ret = new JSObject();
    final PackageManager manager = getContext().getPackageManager();
    Intent launchIntent = new Intent(Intent.ACTION_VIEW);
    launchIntent.setData(Uri.parse(url));

    try {
      getActivity().startActivity(launchIntent);
      ret.put("completed", true);
    } catch (Exception ex) {
      launchIntent = manager.getLaunchIntentForPackage(url);
      try {
        getActivity().startActivity(launchIntent);
        ret.put("completed", true);
      } catch (Exception expgk) {
        ret.put("completed", false);
      }
    }
    call.resolve(ret);
  }
}
