using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SetCameraTransform : MonoBehaviour {

	private Camera camera;
	private Renderer renderer;

	void Start () {
		camera = GameObject.Find("Main Camera").GetComponent<Camera>();
		renderer = GetComponent<Renderer>();
	}
	
	void Update () {
		if(!camera || !renderer) return;
		renderer.material.SetVector("_CameraAngle", new Vector4(camera.transform.eulerAngles.x, camera.transform.eulerAngles.y, camera.transform.eulerAngles.z, 0));
		renderer.material.SetVector("_CameraPosition", new Vector4(camera.transform.position.x, camera.transform.position.y, camera.transform.position.z, 1));
	}
}
