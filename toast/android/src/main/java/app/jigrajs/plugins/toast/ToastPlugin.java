package app.jigrajs.plugins.toast;

import com.getjigra.Plugin;
import com.getjigra.PluginCall;
import com.getjigra.PluginMethod;
import com.getjigra.annotation.JigraPlugin;

@JigraPlugin(name = "Toast")
public class ToastPlugin extends Plugin {

    @PluginMethod
    public void show(PluginCall call) {
        String text = call.getString("text");
        if (text == null) {
            call.reject("Must provide text");
            return;
        }

        String durationType = call.getString("duration", "short");

        int duration = android.widget.Toast.LENGTH_SHORT;
        if ("long".equals(durationType)) {
            duration = android.widget.Toast.LENGTH_LONG;
        }
        String position = call.getString("position", "bottom");
        Toast.show(getContext(), text, duration, position);

        call.resolve();
    }
}
