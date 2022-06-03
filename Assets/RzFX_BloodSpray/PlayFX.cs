using UnityEngine;
using System.Collections;

public class PlayFX : MonoBehaviour {
	public Transform effectToPlay; 
	public Vector3 effectPos;
//	public Transform attach; 


	void OnMouseDown() {
		StartCoroutine(PlayEffect());
	}

	public void playButton()
    {
		StartCoroutine(PlayEffect());
	}

	 IEnumerator PlayEffect() {		
        yield return new WaitForSeconds(0.2f);


//		Vector3 effectPos =  attach.transform.position;
//		effectPos = gameObject.transform.position;


		Transform effect = Instantiate ( effectToPlay, effectPos, Quaternion.identity ) as Transform;	

    }
		

}
