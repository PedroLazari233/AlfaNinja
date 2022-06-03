using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AwardsManager : MonoBehaviour
{
    [SerializeField]
    GameObject eSGEnvironmental, eSGSocial, eSGGovernance, orangeRestartButton;

    [SerializeField]
    Animator eSGEnvironmentalAnimator, eSGSocialAnimator, eSGGovernanceAnimator;

    bool callAwardEnv = false, callAwardGov = false, callAwardSoc = false;

    [SerializeField]
    FruitSpawner spawner;

    [SerializeField]
    GameObject finalPanel;

    [SerializeField]
    GameObject initializationMenu;

    private void Awake()
    {
        initializationMenu.SetActive(true);
    }

    private void Start()
    {
        StartCoroutine(spawner.SpawnFruit());
    }

    // Update is called once per frame
    void Update()
    {
        if(callAwardEnv == false && FruitSliceCount.numberOfSlices > 50 && FruitSliceCount.numberOfSlices < 59)
        {
            callAwardEnv = true;
            spawner.flagSpawnFruit = false;
            spawner.flagSpawnFruitAward = true;
            StartCoroutine(spawner.SpawnFruitAward());
        }
        else if (callAwardGov == false && FruitSliceCount.numberOfSlices > 100 && FruitSliceCount.numberOfSlices < 109)
        {
            Debug.Log("Gov Award");
            callAwardGov = true;
            spawner.flagSpawnFruit = false;
            spawner.flagSpawnFruitAward = true;
            StartCoroutine(spawner.SpawnFruitAward());
        }
        else if (callAwardSoc == false && FruitSliceCount.numberOfSlices > 150)
        {
            callAwardSoc = true;
            spawner.flagSpawnFruit = false;
            spawner.flagSpawnFruitAward = true;
            StartCoroutine(spawner.SpawnFruitAward());
        }
    }

    public IEnumerator ResumeGameEnvironment()
    {
        spawner.flagSpawnFruitAward = false;
        eSGEnvironmental.SetActive(true);
        yield return new WaitForSecondsRealtime(3);
        eSGEnvironmentalAnimator.SetBool("GoToWall", true);
        yield return new WaitForSecondsRealtime(3);
        spawner.flagSpawnFruit = true;
        StartCoroutine(spawner.SpawnFruit());
    }

    public IEnumerator ResumeGameGovernance()
    {
        Debug.Log("Gov Award - Animation");
        spawner.flagSpawnFruitAward = false;
        eSGGovernance.SetActive(true);
        yield return new WaitForSecondsRealtime(3);
        eSGGovernanceAnimator.SetBool("GoToWallGovernance", true);
        yield return new WaitForSecondsRealtime(3);
        spawner.flagSpawnFruit = true;
        StartCoroutine(spawner.SpawnFruit());
    }

    public IEnumerator ResumeGameSocial()
    {
        spawner.flagSpawnFruitAward = false;
        eSGSocial.SetActive(true);
        yield return new WaitForSecondsRealtime(3);
        eSGSocialAnimator.SetBool("GoToWallSocial", true);
        yield return new WaitForSecondsRealtime(3);
        finalPanel.SetActive(true);
        yield return new WaitForSecondsRealtime(10);
        orangeRestartButton.SetActive(true);
    }
}
