using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DestroyFruit : MonoBehaviour
{
    private void OnCollisionEnter(Collision collision)
    {
        if (collision.gameObject.tag == "Destroyer")
        {
            gameObject.layer = 0;
            gameObject.tag = "Untagged";
            StartCoroutine(DestroyRestOfFruit(gameObject));
        }
    }

    IEnumerator DestroyRestOfFruit(GameObject go) {
        yield return new WaitForSeconds(1.5f);
        GameObject.Destroy(go);
    }
}
