package app.web.jigrajs.plugins.preferences;

public class PreferencesConfiguration implements Cloneable {

    static final PreferencesConfiguration DEFAULTS;

    static {
        DEFAULTS = new PreferencesConfiguration();
        DEFAULTS.group = "JigraStorage";
    }

    String group;

    @Override
    public PreferencesConfiguration clone() throws CloneNotSupportedException {
        return (PreferencesConfiguration) super.clone();
    }
}
