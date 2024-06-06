package com.kerberos.lottie.utils;

import android.content.Context;
import android.content.SharedPreferences;

public class PreferencesHelper {
    private static final String PREFS_NAME = "app_prefs";
    private static final String USER_SETTING_KEY = "user_setting";

    private SharedPreferences sharedPreferences;

    public PreferencesHelper(Context context) {
        sharedPreferences = context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE);
    }

    public String getUserSetting() {
        return sharedPreferences.getString(USER_SETTING_KEY, "default_value");
    }

    public void setUserSetting(String setting) {
        SharedPreferences.Editor editor = sharedPreferences.edit();
        editor.putString(USER_SETTING_KEY, setting);
        editor.apply();
    }
}
