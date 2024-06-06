package com.kerberos.lottie.singletons;

public class DataManager {
    private static DataManager instance;
    private String userSetting;

    private DataManager() { }

    public static synchronized DataManager getInstance() {
        if (instance == null) {
            instance = new DataManager();
        }
        return instance;
    }

    public String getUserSetting() {
        return userSetting;
    }

    public void setUserSetting(String userSetting) {
        this.userSetting = userSetting;
    }
}
