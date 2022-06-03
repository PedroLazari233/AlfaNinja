using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FruitSpawner : MonoBehaviour
{
    public bool flagSpawnFruit = true, flagSpawnFruitAward = false;

    [SerializeField]
    GameObject oVRCamera;

    [SerializeField]
    GameObject[] fruitPrefab;

    [SerializeField]
    GameObject[] fruitPrefabAward;

    [SerializeField]
    Transform[] fruitSpawnerPos;

    [SerializeField]
    Vector3 velocity = new Vector3();

    [SerializeField]
    Vector3 slowdown = new Vector3();

    [SerializeField]
    float mass = 0f;

    [SerializeField]
    float drag = 0f;

    [SerializeField]
    float force;

    [SerializeField]
    float angularVelocity = 5f;

    [SerializeField]
    float waitingTime  = 5f;

    [SerializeField]
    GameObject initializationMenu;

    private void Start()
    {
        flagSpawnFruitAward = false;
    }
    private void Update()
    {
        Debug.Log("Flag Spawn Fruit Award: " + flagSpawnFruitAward);
    }

    public IEnumerator SpawnFruit()
    {
        yield return new WaitForSeconds(2f);
        if(initializationMenu.GetComponent<Animator>().enabled == false)
        {
            initializationMenu.GetComponent<Animator>().enabled = true;
            yield return new WaitForSeconds(2f);
        }
        while (flagSpawnFruit && !FruitSliceCount.gameIsPaused)
        {
            int typeOfSpawner = Random.Range(1, 11);

            if(typeOfSpawner == 1 || typeOfSpawner == 2 || typeOfSpawner == 3)
            {
                int numberOfSeparatelySpawns = Random.Range(1, 7);

                for (int j = 1; j < numberOfSeparatelySpawns; j ++)
                {
                    if(flagSpawnFruit == false)
                    {
                        break;
                    }
                    int parentRandom = Random.Range(0, fruitPrefab.Length);
                    GameObject fruit = Instantiate(fruitPrefab[Random.Range(0, fruitPrefab.Length)], fruitSpawnerPos[parentRandom]);

                    Rigidbody tempSeparately = fruit.GetComponent<Rigidbody>();

                    fruit.AddComponent<DestroyFruit>();
                    fruit.AddComponent<FruitSpawnerConfig>();
                    fruit.GetComponent<FruitSpawnerConfig>().SpawnerConfig(tempSeparately, velocity, angularVelocity, force, waitingTime, drag, oVRCamera);

                    yield return new WaitForSeconds(.7f);
                }

                yield return new WaitForSeconds(1f);
            }
            else
            {
                int numberOfInterations = Random.Range(1, 6);

                List<Transform> fruitSpawnerParents = new List<Transform>();
                fruitSpawnerParents.Add(fruitSpawnerPos[0]);
                fruitSpawnerParents.Add(fruitSpawnerPos[1]);
                fruitSpawnerParents.Add(fruitSpawnerPos[2]);
                fruitSpawnerParents.Add(fruitSpawnerPos[3]);
                fruitSpawnerParents.Add(fruitSpawnerPos[4]);

                for (int i = 1; i <= numberOfInterations; i++)
                {
                    int random = Random.Range(0, (fruitSpawnerParents.Count));

                    //Debug.Log(fruitSpawnerParents[random].name);

                    GameObject fruit = Instantiate(fruitPrefab[Random.Range(0, fruitPrefab.Length)], fruitSpawnerParents[random]);
                    Rigidbody tempUnited = fruit.GetComponent<Rigidbody>();

                    fruitSpawnerParents.Remove(fruitSpawnerParents[random]);

                    fruit.AddComponent<DestroyFruit>();
                    fruit.AddComponent<FruitSpawnerConfig>();
                    fruit.GetComponent<FruitSpawnerConfig>().SpawnerConfig(tempUnited, velocity, angularVelocity, force, waitingTime, drag, oVRCamera);
                }

                yield return new WaitForSeconds(1f);
            }
            
            
        }
    }

    public IEnumerator SpawnFruitAward()
    {
        yield return new WaitForSeconds(2f);
        while (flagSpawnFruitAward && !FruitSliceCount.gameIsPaused)
        {
            
            int parentRandom = Random.Range(0, fruitPrefabAward.Length);
            GameObject fruit = Instantiate(fruitPrefabAward[Random.Range(0, fruitPrefabAward.Length)], fruitSpawnerPos[parentRandom]);

            Rigidbody tempSeparately = fruit.GetComponent<Rigidbody>();

            fruit.AddComponent<DestroyFruit>();
            fruit.AddComponent<FruitSpawnerConfig>();
            fruit.GetComponent<FruitSpawnerConfig>().SpawnerConfig(tempSeparately, velocity, angularVelocity, force, waitingTime, drag, oVRCamera);

            yield return new WaitForSeconds(5f);


        }
    }
}
