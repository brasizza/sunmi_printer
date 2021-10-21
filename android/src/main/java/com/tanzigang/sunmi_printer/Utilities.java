package com.tanzigang.sunmi_printer;

import android.graphics.Bitmap;

import java.util.ArrayList;

public class Utilities {
    public static int[] arrayListToIntList(ArrayList<Integer> list) {

        final int[] ints = new int[list.size()];

        for (Integer i = 0; i < list.size(); i++) {
            ints[i] = list.get(i);
        }

        return ints;
    }

    public static String[] arrayListToString(ArrayList<String> list) {

        final String[] strings = new String[list.size()];

        for (int i = 0; i < list.size(); i++) {
            strings[i] = list.get(i);
        }

        return strings;
    }

    public static Bitmap scaleDownBitmap(Bitmap realImage, float maxImageSize,
                                         boolean filter) {
        float ratio = Math.min(
                maxImageSize / realImage.getWidth(),
                maxImageSize / realImage.getHeight());
        int width = Math.round(ratio * realImage.getWidth());
        int height = Math.round(ratio * realImage.getHeight());

        Bitmap newBitmap = Bitmap.createScaledBitmap(realImage, width,
                height, filter);

        return newBitmap;
    }
}