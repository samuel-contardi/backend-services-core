using System.IO; 

namespace MonitoradorDeArquivos.Services
{
    public class FolderMonitorService : IFolderMonitorService
    {
        private readonly ILoggerService _logger; 
        private readonly string _pastaMonitorada;
        private FileSystemWatcher _watcher; 

 
        public FolderMonitorService(ILoggerService logger, string pastaMonitorada)
        {
            _logger = logger;
            _pastaMonitorada = pastaMonitorada;
        }

        public void IniciarMonitoramento()
        {

            Directory.CreateDirectory(_pastaMonitorada);

            _watcher = new FileSystemWatcher(_pastaMonitorada);


            _watcher.IncludeSubdirectories = true;


            _watcher.Created += AoModificarArquivo;
            _watcher.Deleted += AoModificarArquivo;


            _watcher.EnableRaisingEvents = true;

            _logger.Log("Serviço de monitoramento iniciado.");
        }

        private void AoModificarArquivo(object sender, FileSystemEventArgs e)
        {

            _logger.Log($"Arquivo {e.ChangeType}: {e.Name}");
        }

        public void PararMonitoramento()
        {
            if (_watcher != null)
            {
                _watcher.EnableRaisingEvents = false;
                _watcher.Dispose(); 
            }
            _logger.Log("Serviço de monitoramento parado.");
        }
    }
}