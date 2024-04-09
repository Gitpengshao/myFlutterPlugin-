package com.example.batterylevel

import android.os.Bundle
import android.util.Log
import android.widget.TextView
import com.google.android.material.snackbar.Snackbar
import androidx.appcompat.app.AppCompatActivity
import androidx.navigation.findNavController
import androidx.navigation.ui.AppBarConfiguration
import androidx.navigation.ui.navigateUp
import androidx.navigation.ui.setupActionBarWithNavController
import com.example.batterylevel.databinding.ActivityLoginBinding

class LoginActivity : AppCompatActivity() {

    private lateinit var appBarConfiguration: AppBarConfiguration
    private lateinit var binding: ActivityLoginBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_login)
        var textView = findViewById<TextView>(R.id.text_id)
        var loginTag = intent.getStringExtra("loginTag")
        Log.d(loginTag, "loginTag")
        textView.text = loginTag
        textView.setOnClickListener {
            BatterylevelPlugin.resultMethod?.success("登录页返回flutter")
            finish()
        }

    }

}