using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FruitsVelocityControl : MonoBehaviour
{
    [SerializeField]
    Vector3 velocity = new Vector3();

    [SerializeField]
    Vector3 slowdown = new Vector3();

    [SerializeField]
    float mass = 0f;

    [SerializeField]
    float drag = 0f;

    [SerializeField]
    Vector3 angularVelocity = new Vector3();

    // Start is called before the first frame update

    public void SetVelocity(Rigidbody temp)
    {
        temp.drag = drag;
        temp.mass = mass;
        temp.angularVelocity = angularVelocity;
        temp.velocity = velocity;
        StartCoroutine(SlowdownFruit(temp));
    }

    IEnumerator SlowdownFruit(Rigidbody temp)
    {
        while (true)
        {
            temp.velocity -= new Vector3(0f, (temp.velocity.y - slowdown.y*Time.deltaTime), 0f);
            yield return new WaitForSeconds(1f);
        }
    }
}
