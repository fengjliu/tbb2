using UnityEngine;

/// <summary>
/// �����ڿ���UI����Coroutine��
/// �ýű��������UIMgr.DestroyAllUI()����ֹͣ���иýű�������Coroutine��
/// </summary>
public class UICoroutine : MonoBehaviour 
{
	private static UICoroutine mInstance = null;

	public static UICoroutine uiCoroutine
	{
		get
		{
			return mInstance;
		}
	}

	void Awake()
	{
		DontDestroyOnLoad(gameObject);

		mInstance = this;
	}

	void OnDestroy()
	{
		mInstance = null;
	}

	/// <summary>
	/// ��ʼ��
	/// </summary>
	public static void InitUICoroutine()
	{
		GameObject go = new GameObject();
		if (go != null)
		{
			go.name = "_UICoroutine";
			go.AddComponent<UICoroutine>();
		}
		else
		{
			Debug.LogError("Init UICoroutine faild. GameObjet can not be null.");
		}
	}
}
