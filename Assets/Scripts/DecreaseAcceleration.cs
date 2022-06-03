using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DecreaseAcceleration : MonoBehaviour
{
    Rigidbody temp;

    [SerializeField]
    float force = 50f;

    int count = 0;

    // Start is called before the first frame update
    void Start()
    {
        temp = gameObject.GetComponent<Rigidbody>();
    }

    // Update is called once per frame
    void LateUpdate()
    {
        /*if(gameObject.name == "LimonWhole(Clone)")
        {
            //Debug.Log(temp.velocity.y);
        }
        
        if (temp.velocity.y < 0f)
        {
            if(count == 0)
            {
                Debug.Log(temp.velocity.y);
                temp.AddForce(transform.up * force, ForceMode.Acceleration);
                //temp.AddForce(new Vector3(0f, force, 0f));
                count++;
            }
            


        }*/

    }

    IEnumerator DesaccelerateFruit()
    {

        yield return new WaitForSeconds(1f);
    }
}
