package app.web.jigrajs.plugins.screenreader;

import com.getjigra.JSObject;
import com.getjigra.Plugin;
import com.getjigra.PluginCall;
import com.getjigra.PluginMethod;
import com.getjigra.annotation.JigraPlugin;

@JigraPlugin(name = "ScreenReader")
public class ScreenReaderPlugin extends Plugin {

    public static final String EVENT_STATE_CHANGE = "stateChange";
    private ScreenReader screenReader;

    @Override
    public void load() {
        screenReader = new ScreenReader(getContext());
        screenReader.addStateChangeListener(
            enabled -> {
                JSObject ret = new JSObject();
                ret.put("value", enabled);
                notifyListeners(EVENT_STATE_CHANGE, ret);
            }
        );
    }

    @Override
    protected void handleOnDestroy() {
        screenReader.removeAllListeners();
    }

    @SuppressWarnings("unused")
    @PluginMethod
    public void isEnabled(PluginCall call) {
        JSObject ret = new JSObject();
        ret.put("value", screenReader.isEnabled());
        call.resolve(ret);
    }

    @SuppressWarnings("unused")
    @PluginMethod
    public void speak(PluginCall call) {
        String value = call.getString("value");
        String language = call.getString("language", "en");
        screenReader.speak(value, language);
        call.resolve();
    }
}
