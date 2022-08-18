package app.web.jigrajs.plugins.haptics;

import app.web.jigrajs.plugins.haptics.arguments.HapticsImpactType;
import app.web.jigrajs.plugins.haptics.arguments.HapticsNotificationType;
import com.getjigra.Plugin;
import com.getjigra.PluginCall;
import com.getjigra.PluginMethod;
import com.getjigra.annotation.JigraPlugin;

@JigraPlugin(name = "Haptics")
public class HapticsPlugin extends Plugin {

    private Haptics implementation;

    @Override
    public void load() {
        implementation = new Haptics(getContext());
    }

    @PluginMethod
    public void vibrate(PluginCall call) {
        int duration = call.getInt("duration", 300);
        implementation.vibrate(duration);
        call.resolve();
    }

    @PluginMethod
    public void impact(PluginCall call) {
        implementation.performHaptics(HapticsImpactType.fromString(call.getString("style")));
        call.resolve();
    }

    @PluginMethod
    public void notification(PluginCall call) {
        implementation.performHaptics(HapticsNotificationType.fromString(call.getString("type")));
        call.resolve();
    }

    @PluginMethod
    public void selectionStart(PluginCall call) {
        implementation.selectionStart();
        call.resolve();
    }

    @PluginMethod
    public void selectionChanged(PluginCall call) {
        implementation.selectionChanged();
        call.resolve();
    }

    @PluginMethod
    public void selectionEnd(PluginCall call) {
        implementation.selectionEnd();
        call.resolve();
    }
}
