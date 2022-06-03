using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SplashEffect : MonoBehaviour
{
	public Transform effectToPlay;
	Vector3 effectPos;
	public void playButton()
	{
		Transform effect = Instantiate(effectToPlay, gameObject.transform.position, Quaternion.identity) as Transform;
		//StartCoroutine(PlayEffect());
	}

	IEnumerator PlayEffect()
	{
		yield return new WaitForSeconds(0.2f);


		//		Vector3 effectPos =  attach.transform.position;
		//		effectPos = gameObject.transform.position;


		Transform effect = Instantiate(effectToPlay, gameObject.transform.position, Quaternion.identity) as Transform;

	}
}
