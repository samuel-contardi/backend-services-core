# Serviços de Backend e Integração de Sistemas

Este repositório contém a implementação de um ecossistema de microsserviços e scripts de integração divididos em três camadas operacionais: monitoramento de arquivos (C#), manipulação de dados relacionais avançada (PostgreSQL) e integração de APIs em sistemas legados (VB6). O projeto foi desenhado focando em boas práticas de engenharia, resiliência e adaptação multiplataforma.

## 📂 Estrutura do Repositório

```text
/
├── src/
│   └── MonitoradorDeArquivos/    # Worker Service em .NET (C#)
├── database/
│   └── script_postgresql.sql     # DDL, DML e PL/pgSQL
├── VB6/
│   └── frmProdutos.frm           # Formulário de consumo de API
└── README.md                     # Documentação principal
```

---

## Módulo 1: Monitoramento Automático (.NET Worker Service)
Serviço executado em segundo plano responsável pelo rastreamento em tempo real de criação e exclusão de arquivos em diretórios locais.

*   **Arquitetura:** Aplicação de *Clean Architecture* e *Injeção de Dependência*, separando a lógica de vigilância (`FolderMonitorService`) da persistência de logs (`FileLoggerService`).
*   **Tecnologia:** Utilização nativa do `FileSystemWatcher` com recursividade para subdiretórios (`IncludeSubdirectories = true`).
*   **Como testar:** 
    1. Abra a solução no Visual Studio e execute (F5). 
    2. O serviço criará automaticamente a pasta `C:\TesteTecnico\PastaMonitorada`. 
    3. Crie ou delete arquivos nela e verifique o registro no arquivo `C:\TesteTecnico\log_monitoramento.txt`.

---

## Módulo 2: Busca Otimizada e Banco de Dados (PostgreSQL)
Estrutura relacional contendo a modelagem de clientes e rotinas internas do banco de dados otimizadas para processamento de alto desempenho.

*   **Implementação:** Criação da tabela `clientes` e de uma *Function* em **PL/pgSQL** (`fn_buscar_clientes_por_nome`).
*   **Regra de Negócio:** A função recebe um termo parcial e utiliza o operador `ILIKE` para realizar uma busca *case-insensitive* (ignorando maiúsculas e minúsculas), retornando todos os registros correspondentes no formato de tabela.
*   **Como testar:**
    1. Execute o arquivo `database/script_postgresql.sql` no pgAdmin ou DBeaver. O script é autossuficiente e fará a carga inicial dos dados.
    2. Execute a instrução no final do arquivo: `SELECT * FROM fn_buscar_clientes_por_nome('silv');`.

---

## Módulo 3: Integração REST em Ambiente Legado (VB6)
Módulo desenvolvido para consumir dados de fornecedores externos via internet.

*   **Tecnologia:** Consumo da API pública FakeStore usando chamadas assíncronas/síncronas através da biblioteca nativa do Windows (`MSXML2.ServerXMLHTTP.6.0`).
*   **Solução Arquitetural:** Como ambientes legados não possuem *parsers* de JSON nativos e as bibliotecas JS de terceiros (MSScriptControl) falham em sistemas operacionais 64-bits modernos, a conversão do JSON foi desenhada utilizando **Expressões Regulares (VBScript.RegExp)**, garantindo estabilidade e compatibilidade universal.
*   **Como testar:**
    1. O código fonte no arquivo `VB6/frmProdutos.frm` contém a interface gráfica configurada.
    2. A lógica pode ser executada ou emulada em ambientes compatíveis com VBA/VB6, bastando adicionar um controle `ListView` à interface.