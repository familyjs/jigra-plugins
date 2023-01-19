package app.web.jigrajs.plugins.keyboard;

import android.os.Handler;
import android.os.Looper;
import com.getjigra.JSObject;
import com.getjigra.Plugin;
import com.getjigra.PluginCall;
import com.getjigra.PluginMethod;
import com.getjigra.annotation.JigraPlugin;

@JigraPlugin(name = "Keyboard")
public class KeyboardPlugin extends Plugin {

    private Keyboard implementation;

    @Override
    public void load() {
        execute(
            () -> {
                boolean resizeOnFullScreen = getConfig().getBoolean("resizeOnFullScreen", false);
                implementation = new Keyboard(getActivity(), resizeOnFullScreen);
                implementation.setKeyboardEventListener(this::onKeyboardEvent);
            }
        );
    }

    @PluginMethod
    public void show(final PluginCall call) {
        execute(
            () ->
                new Handler(Looper.getMainLooper())
                    .postDelayed(
                        () -> {
                            implementation.show();
                            call.resolve();
                        },
                        350
                    )
        );
    }

    @PluginMethod
    public void hide(final PluginCall call) {
        execute(
            () -> {
                if (!implementation.hide()) {
                    call.reject("Can't close keyboard, not currently focused");
                } else {
                    call.resolve();
                }
            }
        );
    }

    @PluginMethod
    public void setAccessoryBarVisible(PluginCall call) {
        call.unimplemented();
    }

    @PluginMethod
    public void setStyle(PluginCall call) {
        call.unimplemented();
    }

    @PluginMethod
    public void setResizeMode(PluginCall call) {
        call.unimplemented();
    }

    @PluginMethod
    public void getResizeMode(PluginCall call) {
        call.unimplemented();
    }

    @PluginMethod
    public void setScroll(PluginCall call) {
        call.unimplemented();
    }

    void onKeyboardEvent(String event, int size) {
        JSObject kbData = new JSObject();
        switch (event) {
            case Keyboard.EVENT_KB_WILL_SHOW:
            case Keyboard.EVENT_KB_DID_SHOW:
                String data = "{ 'keyboardHeight': " + size + " }";
                bridge.triggerWindowJSEvent(event, data);
                kbData.put("keyboardHeight", size);
                notifyListeners(event, kbData);
                break;
            case Keyboard.EVENT_KB_WILL_HIDE:
            case Keyboard.EVENT_KB_DID_HIDE:
                bridge.triggerWindowJSEvent(event);
                notifyListeners(event, kbData);
                break;
        }
    }

    @Override
    protected void handleOnDestroy() {
        implementation.setKeyboardEventListener(null);
    }
}
