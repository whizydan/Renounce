package com.kerberos.lottie.activities

import android.os.Bundle
import android.widget.Toast
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import androidx.lifecycle.Observer
import com.google.android.material.button.MaterialButton
import com.kerberos.lottie.App
import com.kerberos.lottie.R
import com.kerberos.lottie.models.SettingsViewModel

class GetStartedActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContentView(R.layout.activity_main)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }
        var getStarted = findViewById<MaterialButton>(R.id.getStarted)
        var count = 0

        var settingsViewModel : SettingsViewModel = SettingsViewModel(this);
        settingsViewModel.userSetting.observe(this,object : Observer<String>{
            override fun onChanged(value: String) {
                Toast.makeText(this@GetStartedActivity, value, Toast.LENGTH_LONG).show()
            }
        })

        getStarted.setOnClickListener {
            settingsViewModel.setUserSetting("Current Count: $count")
            count ++
        }
    }
}