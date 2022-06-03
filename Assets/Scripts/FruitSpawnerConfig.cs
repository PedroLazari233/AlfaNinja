using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FruitSpawnerConfig : MonoBehaviour
{
    Rigidbody temp;
    float drag;

    [SerializeField]
    GameObject oVRCamera;

    // Start is called before the first frame update
    public void SpawnerConfig(Rigidbody temp, Vector3 velocity, float angularVelocity, float force, float waitingTime, float drag, GameObject oVRCamera)
    {
        temp.velocity = velocity;
        temp.angularVelocity = new Vector3(Random.Range(-angularVelocity, angularVelocity), 0f, Random.Range(-angularVelocity, angularVelocity));


        //temp.useGravity = true;
        temp.AddForce(transform.up * force, ForceMode.Acceleration);

        Vector3 pos = temp.gameObject.transform.parent.position;
        //pos.x += Random.Range(-.5f, .5f);
        temp.gameObject.transform.position = pos;

        this.oVRCamera = oVRCamera;
        this.temp = temp;
        this.drag = drag;

        StartCoroutine(ActivateGravityAndDrag());
        
        //Invoke("ActivateGravityAndDrag", waitingTime);
        //yield return new WaitForSeconds(waitingTime);

    }

    IEnumerator ActivateGravityAndDrag()
    {
        while (true)
        {
            if (temp != null)
            {
                if (temp.gameObject.transform.position.y >= this.oVRCamera.transform.position.y)
                {
                    this.temp.useGravity = true;
                    this.temp.drag = this.drag;
                }
            }

            yield return new WaitForSeconds(.1f);
        }
        //this.temp.useGravity = true;
        //this.temp.drag = this.drag;
    }
}
