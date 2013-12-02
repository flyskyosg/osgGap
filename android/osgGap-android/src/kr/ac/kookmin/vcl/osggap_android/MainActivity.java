package kr.ac.kookmin.vcl.osggap_android;

import org.apache.cordova.Config;
import org.apache.cordova.DroidGap;

import android.app.Activity;
import android.os.Bundle;

public class MainActivity extends DroidGap {

	
	public static Activity _activity;
	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		
		_activity = this;
		super.loadUrl(Config.getStartUrl());
	}

	

}
