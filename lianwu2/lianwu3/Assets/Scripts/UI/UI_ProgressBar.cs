using UnityEngine;

public class UI_ProgressBar : MonoBehaviour
{
    [SerializeField] UISprite m_Sprite = null;
    [SerializeField] float m_nNormalTime = 0;

    private float m_nHideWaittingTime = 0;
    private bool m_isPlaying = false;//�Ƿ����ڲ��Ŷ���Ч��;
    private float m_nCurPct = 0;//��ǰ�ٷֱ�;
    private float m_nSpeed = 0;//ÿ����������ٶ�;
    private float m_nMaxScaleX = 0;//��󳤶�scale;

    private float m_nTargetPct = 0;//Ŀ��ٷֱ�;
    private float m_nEachPct = 0;//����ٷֱ�;

    /// <summary>
    /// ��ʼ��������;
    /// </summary>
    public void InitProgressBar(float nHideWaittingTime)
    {
        m_nHideWaittingTime = nHideWaittingTime;

        m_nMaxScaleX = m_Sprite.transform.localScale.x;
        ResetPercent();
    }

    public void ResetPercent()
    {
        m_isPlaying = false;
        m_nCurPct = 0;
        m_nTargetPct = 0;
        m_nSpeed = 0;
        SetPercent(0);
    }

    /// <summary>
    /// ���õ�ǰ�ٷֱȵļ��;
    /// </summary>
    public void SetPercentCount(int nCount)
    {
        if (nCount == 0)
        {
            m_nEachPct = 0;
        }
        else
        {
            m_nEachPct = (float)1 / (float)nCount;
        }
    }

    /// <summary>
    /// ���������ӵ���һ���׶�;
    /// </summary>
    public void MoveNextPercent()
    {
        m_nTargetPct += m_nEachPct;
        PlayAniToTarget();
    }
    
    /// <summary>
    /// �ⲿ�������õ�ǰ����;
    /// </summary>
    /// <param name="nPct">100Ϊmax�Ľ���</param>
    public void SetTargetPercent(int nPct)
    {
        m_nTargetPct = (float)nPct / (float)100;
        PlayAniToTarget();
    }

    private void PlayAniToTarget()
    {
        if (m_nTargetPct > 1)
        {
            return;
        }

        float nAniPct = m_nTargetPct - m_nCurPct;//���;
        if (m_nTargetPct == 1)//������õ�ֵ����100,����max��;//���ٽ�������Ч��;
        {
            if (m_nHideWaittingTime == 0)//����100ʱ��,����û�н����ӳ�ʱ��;
            {
                SetPercent(1);
                m_isPlaying = false;//ֱ����������,�����ж���;
            }
            else
            {
                m_nSpeed = nAniPct / m_nHideWaittingTime;
            }
        }
        else
        {
            m_nSpeed = nAniPct / m_nNormalTime;//�̶�ʱ�� �����ǰ�ٶ�;
        }

        m_isPlaying = true;//��ʼ���Ŷ���Ч��;
    }

    /// <summary>
    /// �ڲ�������ʾ;
    /// </summary>
    /// <param name="nPct">1Ϊmax�Ľ���</param>
    private void SetPercent(float nPct)
    {
        if (nPct == 0)
        {
            nPct = 0.01f;
        }
        if(nPct > 1)
        {
            nPct = 1;
        }
        m_Sprite.transform.localScale = new Vector3((float)(m_nMaxScaleX * nPct), m_Sprite.transform.localScale.y, m_Sprite.transform.localScale.z);
    }
        
    void Update ()
    {
        if(!m_isPlaying)
        {
            return;
        }
        m_nCurPct += Time.deltaTime * m_nSpeed;
        if (m_nCurPct >= m_nTargetPct)
        {
            m_nCurPct = m_nTargetPct;
            m_isPlaying = false;//����Ŀ��ֵֹͣ����;
        }
        SetPercent(m_nCurPct);
	}
}
