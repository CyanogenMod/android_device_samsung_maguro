package com.cyanogenmod.settings.device;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;

public class Startup extends BroadcastReceiver {

    @Override
    public void onReceive(final Context context, final Intent bootintent) {
        GammaTuningPreference.restore(context);
        GeneralFragmentActivity.restore(context);
        if (Hspa.isSupported()) {
            Hspa.restore(context);
        }
    }
}
