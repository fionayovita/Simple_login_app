package com.example.kotlin_login_app

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.os.Handler
import android.os.Looper

class FirstScreen : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_first_screen)

        Handler(Looper.getMainLooper())
        startActivity(Intent(this@FirstScreen, LoginActivity::class.java))
        finish()
        splashTimeOut
    }

    companion object {
        private const val splashTimeOut: Long = 3000
    }
}