# Desafio Técnico - Programador Backend Sênior

Este repositório contém a resolução do teste técnico para a vaga de Programador Backend Sênior. O projeto foi estruturado focando em boas práticas de engenharia de software, incluindo Clean Architecture, Princípios SOLID e Injeção de Dependência.

## 🏗️ Estrutura da Entrega

O desafio foi dividido em três frentes tecnológicas:

### 1. C# (.NET Worker Service)
Serviço desenvolvido para rodar em segundo plano monitorando a criação e deleção de arquivos em um diretório específico.
- **Arquitetura:** O projeto separa a responsabilidade de monitoramento (`FolderMonitorService`) da responsabilidade de gravação de logs (`FileLoggerService`), conectadas via Injeção de Dependência no `Worker` principal.
- **Tecnologia:** Utiliza a classe nativa `FileSystemWatcher` configurada para monitorar também subdiretórios (`IncludeSubdirectories = true`).
- **Limitação de API Mapeada:** O código documenta a limitação nativa da API do Windows onde a exclusão de um diretório pai não emite eventos individuais para os arquivos internos, exigindo a simulação de um cache de estado para cenários reais.

### 2. PostgreSQL
*(O script SQL será adicionado na próxima etapa do teste).*

### 3. VB6
*(A estrutura de código em texto puro do VB6 será adicionada na próxima etapa).*

## 🚀 Como testar a aplicação em C#

1. Abra a solução no Visual Studio.
2. Execute o projeto (F5). O serviço criará automaticamente a estrutura de pastas necessária em `C:\TesteTecnico\PastaMonitorada`.
3. Crie ou delete arquivos dentro deste diretório (ou em subpastas).
4. Verifique o arquivo de registro gerado em `C:\TesteTecnico\log_monitoramento.txt`.