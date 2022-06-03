using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

[RequireComponent(typeof(Rigidbody))]
public class SwordCutter : MonoBehaviour
{
    public Material tanInterior, limInterior, peraInterior, caraInterior, larLimaInterior;

    public TextMesh textFruitSliceCount;

    [SerializeField]
    FruitSpawner fruitSpawner;

    [SerializeField]
    AwardsManager awardsManager;

    [SerializeField]
    PauseMenuManager pauseMenuManager;

    [SerializeField]
    AudioClip splashFruit;

    public AudioSource audioSource;

    private void OnCollisionEnter(Collision collision)
    {
        if (collision.collider.gameObject != null && collision.collider.gameObject.GetComponent<SplashEffect>() != null)
        {
            GameObject victim = collision.collider.gameObject;

            Material interior;

            if (victim.layer == 6 || victim.tag.Equals("Fruit") || victim.layer == 7 || victim.tag.Equals("FruitAward"))
            {
                audioSource = victim.GetComponent<AudioSource>();
                audioSource.PlayOneShot(splashFruit);

                victim.GetComponent<SplashEffect>().playButton();
                FruitSliceCount.AddSliceFruit();
                Debug.Log("Count: " + FruitSliceCount.numberOfSlices);
                textFruitSliceCount.text = FruitSliceCount.numberOfSlices.ToString();
                if (victim.layer == 7 || victim.tag.Equals("FruitAward"))
                {
                    if (FruitSliceCount.callAwardEnv == false)
                    {
                        FruitSliceCount.callAwardEnv = true;
                        StartCoroutine(awardsManager.ResumeGameEnvironment());
                    }
                    else if (FruitSliceCount.callAwardGov == false)
                    {
                        Debug.Log("Gov Award - Sliced");
                        FruitSliceCount.callAwardGov = true;
                        StartCoroutine(awardsManager.ResumeGameGovernance());
                    }
                    else if (FruitSliceCount.callAwardSoc == false)
                    {
                        FruitSliceCount.callAwardSoc = true;
                        StartCoroutine(awardsManager.ResumeGameSocial());
                    }

                }

                interior = SelectInteriorMaterial(victim);

                GameObject[] pieces = BLINDED_AM_ME.MeshCut.Cut(victim, transform.position, transform.forward, interior);

                pieces[1].gameObject.layer = LayerMask.NameToLayer("Piece");
                pieces[0].gameObject.layer = LayerMask.NameToLayer("Piece");

                pieces[0].gameObject.tag = "Piece";
                pieces[1].gameObject.tag = "Piece";

                pieces[0].gameObject.AddComponent<DestroyFruit>();
                pieces[1].gameObject.AddComponent<DestroyFruit>();

                if (!pieces[1].GetComponent<Rigidbody>())
                {
                    pieces[1].AddComponent<Rigidbody>();
                    pieces[1].GetComponent<Rigidbody>().useGravity = true;
                    MeshCollider temp = pieces[1].AddComponent<MeshCollider>();
                    temp.convex = true;
                }
                if (pieces[0].GetComponent<Rigidbody>().useGravity == false)
                {
                    pieces[0].GetComponent<Rigidbody>().useGravity = true;
                    //MeshCollider temp = pieces[0].AddComponent<MeshCollider>();
                    //temp.convex = true;
                }

                victim.layer = 0;
                victim.tag = "Untagged";

            }

            if (victim.layer == 8 || victim.tag.Equals("RestartButton"))
            {

                audioSource = victim.GetComponent<AudioSource>();
                audioSource.PlayOneShot(splashFruit);

                victim.GetComponent<SplashEffect>().playButton();

                interior = SelectInteriorMaterial(victim);

                GameObject[] pieces = BLINDED_AM_ME.MeshCut.Cut(victim, transform.position, transform.forward, interior);

                pieces[1].gameObject.layer = LayerMask.NameToLayer("Piece");
                pieces[0].gameObject.layer = LayerMask.NameToLayer("Piece");

                pieces[0].gameObject.tag = "Piece";
                pieces[1].gameObject.tag = "Piece";

                pieces[0].gameObject.AddComponent<DestroyFruit>();
                pieces[1].gameObject.AddComponent<DestroyFruit>();

                if (!pieces[1].GetComponent<Rigidbody>())
                {
                    pieces[1].AddComponent<Rigidbody>();
                    pieces[1].GetComponent<Rigidbody>().useGravity = true;
                    MeshCollider temp = pieces[1].AddComponent<MeshCollider>();
                    temp.convex = true;
                }
                if (pieces[0].GetComponent<Rigidbody>().useGravity == false)
                {
                    pieces[0].GetComponent<Rigidbody>().useGravity = true;
                    //MeshCollider temp = pieces[0].AddComponent<MeshCollider>();
                    //temp.convex = true;
                }

                victim.layer = 0;
                victim.tag = "Untagged";

                StartCoroutine(RestartApplication());

            }
        }
    }

    IEnumerator RestartApplication()
    {
        yield return new WaitForSecondsRealtime(1);
        FruitSliceCount.numberOfSlices = 0;
        FruitSliceCount.callAwardGov = false;
        FruitSliceCount.callAwardEnv = false;
        FruitSliceCount.callAwardSoc = false;
        SceneManager.LoadScene("FruitsFlying");
        FruitSliceCount.gameIsPaused = false;
        pauseMenuManager.pauseMenu.SetActive(false);
        StartCoroutine(fruitSpawner.SpawnFruit());
        StartCoroutine(fruitSpawner.SpawnFruitAward());
    }

    Material SelectInteriorMaterial(GameObject gameObject)
    {
        if(gameObject.name == "OrangeWholeSlice(Clone)" || gameObject.name == "OrangeWholeSliceAward(Clone)")
        {
            return caraInterior;
        }
        else if(gameObject.name == "OrangePeraWholeSlice(Clone)" || gameObject.name == "OrangePeraWholeSliceAward(Clone)")
        {
            return peraInterior;
        }
        else if(gameObject.name == "OrangeLimaWholeSlice(Clone)" || gameObject.name == "OrangeLimaWholeSliceAward(Clone)")
        {
            return larLimaInterior;
        }
        else if (gameObject.name == "LimonWhole(Clone)" || gameObject.name == "LimonWholeAward(Clone)" || gameObject.name == "LimonWholeResumeButton" || gameObject.name == "LimonWholeResumeButton(Clone)")
        {
            return limInterior;
        }
        else if (gameObject.name == "TangerinaWholeSlice(Clone)" || gameObject.name == "TangerinaWholeSliceAward(Clone)" || gameObject.name == "TangerinaWholeSlice")
        {
            return tanInterior;
        }
        else
        {
            return null;
        }
    }

}
