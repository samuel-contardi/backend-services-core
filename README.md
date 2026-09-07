# Monitorador de Arquivos - Serviço Backend

Este repositório contém a implementação de um serviço de monitoramento de diretórios e automação de rotinas backend. O projeto foi arquitetado aplicando Clean Architecture, princípios SOLID e Injeção de Dependência para garantir testabilidade, sustentabilidade e alta coesão.

## Estrutura do Sistema

O sistema é composto pelos seguintes componentes técnicos:

### 1. Serviço de Monitoramento (.NET Worker Service)
Serviço executado em segundo plano responsável pelo rastreamento em tempo real de criação e exclusão de arquivos em diretórios configurados.
- **Arquitetura:** Separação clara entre a lógica de vigilância (`FolderMonitorService`) e o serviço de escrita de registros (`FileLoggerService`), desacoplados por meio de interfaces e unificados via Injeção de Dependência no `Worker`.
- **Recursividade:** Utilização da classe nativa `FileSystemWatcher` com suporte habilitado para subdiretórios (`IncludeSubdirectories = true`).

## Execução do Serviço

1. Abra a solução no Visual Studio.
2. Execute o projeto (`F5`). O serviço inicializará criando automaticamente o diretório raiz em `C:\TesteTecnico\PastaMonitorada`.
3. Adicione ou remova arquivos no diretório monitorado (incluindo subpastas).
4. Consulte os eventos registrados em tempo real no arquivo de log localizado em `C:\TesteTecnico\log_monitoramento.txt`.