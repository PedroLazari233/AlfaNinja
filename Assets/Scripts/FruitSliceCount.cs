using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public static class FruitSliceCount
{
    public static bool gameIsPaused = false;

    public static int numberOfSlices = 0;

    public static bool callAwardEnv = false, callAwardGov = false, callAwardSoc = false;

    // Update is called once per frame
    public static void AddSliceFruit()
    {
        numberOfSlices++;
    }

    public static void RestartSliceFruitCount()
    {
        numberOfSlices = 0;
    }
}
