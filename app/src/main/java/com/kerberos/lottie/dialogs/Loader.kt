package com.kerberos.lottie.dialogs

import android.app.Dialog
import android.content.Context
import android.os.Bundle
import com.kerberos.lottie.R

class Loader(private var context: Context, private var cancellable: Boolean) : Dialog(context) {
    init {
        setCancelable(cancellable)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.loader)
    }
}