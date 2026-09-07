using Microsoft.Extensions.Hosting;
using System.Threading;
using System.Threading.Tasks;
using MonitoradorDeArquivos.Services;

namespace MonitoradorDeArquivos
{
    public class Worker : BackgroundService
    {

        private readonly IFolderMonitorService _monitorService;


        public Worker()
        {

            ILoggerService logger = new FileLoggerService(@"C:\TesteTecnico\log_monitoramento.txt");


            _monitorService = new FolderMonitorService(logger, @"C:\TesteTecnico\PastaMonitorada");
        }

  
        protected override Task ExecuteAsync(CancellationToken stoppingToken)
        {

            _monitorService.IniciarMonitoramento();


            return Task.CompletedTask;
        }

  
        public override Task StopAsync(CancellationToken cancellationToken)
        {

            _monitorService.PararMonitoramento();

            return base.StopAsync(cancellationToken);
        }
    }
}