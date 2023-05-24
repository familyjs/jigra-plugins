package app.jigrajs.plugins.actionsheet;

import com.getjigra.JSArray;
import com.getjigra.JSObject;
import com.getjigra.Logger;
import com.getjigra.Plugin;
import com.getjigra.PluginCall;
import com.getjigra.PluginMethod;
import com.getjigra.annotation.JigraPlugin;
import java.util.List;
import org.json.JSONException;
import org.json.JSONObject;

@JigraPlugin(name = "ActionSheet")
public class ActionSheetPlugin extends Plugin {

    private ActionSheet implementation = new ActionSheet();

    @PluginMethod
    public void showActions(final PluginCall call) {
        String title = call.getString("title");
        JSArray options = call.getArray("options");
        if (options == null) {
            call.reject("Must supply options");
            return;
        }
        if (getActivity().isFinishing()) {
            call.reject("App is finishing");
            return;
        }

        try {
            List<Object> optionsList = options.toList();
            ActionSheetOption[] actionOptions = new ActionSheetOption[optionsList.size()];
            for (int i = 0; i < optionsList.size(); i++) {
                JSObject o = JSObject.fromJSONObject((JSONObject) optionsList.get(i));
                String titleOption = o.getString("title", "");
                actionOptions[i] = new ActionSheetOption(titleOption);
            }
            implementation.setTitle(title);
            implementation.setOptions(actionOptions);
            implementation.setCancelable(false);
            implementation.setOnSelectedListener(
                index -> {
                    JSObject ret = new JSObject();
                    ret.put("index", index);
                    call.resolve(ret);
                    implementation.dismiss();
                }
            );
            implementation.show(getActivity().getSupportFragmentManager(), "jigraModalsActionSheet");
        } catch (JSONException ex) {
            Logger.error("JSON error processing an option for showActions", ex);
            call.reject("JSON error processing an option for showActions", ex);
        }
    }
}
