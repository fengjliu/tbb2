
namespace LoveDance.Client.Common
{
    /// <summary>
    /// ���绷��;
    /// </summary>
	public enum NetworkType : byte
    {
        None = 0,
        _Wifi = 1,
        _2G = 2,
        _3G = 3,
        _4G = 4,
        MAX
    }

    /// <summary>
    /// �����Ƿ񵯿��ϵͳ��������;
    /// </summary>
	public enum DownLoadTipsSetting : byte
    {
        OnlyWifi = 0,
        AllNetWorkType = 1,
    }

    /// <summary>
    /// ���������״̬;
    /// </summary>
	public enum AssetState : byte
    {
        Waitting,		//�ȴ�������;
        DownLoading,	//������;
		LocalLoading,	//���ؼ�����;
        Finish,			//������ػ����;
        HasRelease,		//�ѱ��ͷ�;
    }

    /// <summary>
    /// �������;
    /// </summary>
	public enum DownLoadOrderType : byte
    {
        Head,           //�������;
        AfterRunning,   //����"������"֮��;
    }
}