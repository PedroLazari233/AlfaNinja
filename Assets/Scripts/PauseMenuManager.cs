using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PauseMenuManager : MonoBehaviour
{
    [SerializeField]
    public GameObject pauseMenu;

    [SerializeField]
    public GameObject tangerineRestartButton;

    [SerializeField]
    FruitSpawner fruitSpawner;

    // Update is called once per frame
    void Update()
    {
        if (OVRInput.GetDown(OVRInput.Button.One) || OVRInput.GetDown(OVRInput.Button.Three) || Input.GetKeyDown(KeyCode.Space) || Input.GetKeyDown(KeyCode.M))
        {
            FruitSliceCount.gameIsPaused = !FruitSliceCount.gameIsPaused;
            PauseGame();
        }
    }
    void PauseGame()
    {
        if (FruitSliceCount.gameIsPaused)
        {
            pauseMenu.SetActive(true);
        }
        else
        {
            ResumeApplication();
        }
    }

    IEnumerator Waiting()
    {
        yield return new WaitForSecondsRealtime(1);
    }

    void ResumeApplication()
    {
        FruitSliceCount.gameIsPaused = false;
        pauseMenu.SetActive(false);
        StartCoroutine(fruitSpawner.SpawnFruit());
        if (fruitSpawner.flagSpawnFruitAward == true)
        {
            StartCoroutine(fruitSpawner.SpawnFruitAward());
        }
    }

}
