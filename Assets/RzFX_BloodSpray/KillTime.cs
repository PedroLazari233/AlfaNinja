using UnityEngine;

public class KillTime : MonoBehaviour {
	public float KillDelayTime = 10;

	private void Awake () {
		Destroy (gameObject, KillDelayTime);
	}
}