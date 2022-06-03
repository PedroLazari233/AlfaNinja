using UnityEngine;
using UnityEditor;
using System.Collections;

[CustomEditor(typeof(CurvedText))]
public class CurvedTextEditor : Editor
{
#if UNITY_EDITOR
	public override void OnInspectorGUI()
	{
		DrawDefaultInspector();
	}
#endif
}
