package com.example.kotlin_login_app

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import android.widget.EditText

class LoginActivity : AppCompatActivity() {

//    private lateinit var binding: LoginActivityBinding

    lateinit var username : EditText
    lateinit var password: EditText
    lateinit var loginButton: Button



    override fun onCreate(savedInstanceState: Bundle?) {
//        binding = LoginActivityBinding.inflate(layoutInflater)
//        setContentView(binding.root)

        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_login)
    }

}