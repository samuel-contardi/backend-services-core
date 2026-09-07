namespace MonitoradorDeArquivos.Services
{

    public interface IFolderMonitorService
    {
        void IniciarMonitoramento();
        void PararMonitoramento();
    }
}