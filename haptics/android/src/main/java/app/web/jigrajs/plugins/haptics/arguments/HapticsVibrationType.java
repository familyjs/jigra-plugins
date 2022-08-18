package app.web.jigrajs.plugins.haptics.arguments;

public interface HapticsVibrationType {
    long[] getTimings();

    int[] getAmplitudes();

    long[] getOldSDKPattern();
}
