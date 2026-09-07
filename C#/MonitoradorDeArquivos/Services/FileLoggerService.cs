using System;
using System.IO;

namespace MonitoradorDeArquivos.Services
{

    public class FileLoggerService : ILoggerService
    {
        private readonly string _caminhoArquivo;

        public FileLoggerService(string caminhoArquivo)
        {
            _caminhoArquivo = caminhoArquivo;
        }

        public void Log(string mensagem)
        {

            string logFormatado = $"[{DateTime.Now:dd/MM/yyyy HH:mm:ss}] {mensagem}{Environment.NewLine}";


            File.AppendAllText(_caminhoArquivo, logFormatado);
        }
    }
}