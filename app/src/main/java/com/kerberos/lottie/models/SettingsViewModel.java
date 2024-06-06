package com.kerberos.lottie.models;

import android.app.Activity;
import android.app.Application;

import androidx.lifecycle.LiveData;
import androidx.lifecycle.MutableLiveData;
import androidx.lifecycle.ViewModel;

import com.kerberos.lottie.utils.PreferencesHelper;

public class SettingsViewModel extends ViewModel {
    private MutableLiveData<String> userSetting = new MutableLiveData<>();
    private PreferencesHelper preferencesHelper;

    public SettingsViewModel(Activity application) {
        preferencesHelper = new PreferencesHelper(application.getApplicationContext());
        userSetting.setValue(preferencesHelper.getUserSetting());
    }

    public LiveData<String> getUserSetting() {
        return userSetting;
    }

    public void setUserSetting(String setting) {
        preferencesHelper.setUserSetting(setting);
        userSetting.setValue(setting);
    }
}
