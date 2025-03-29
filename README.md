Datadog Alerts APM com Terraform

Objetivo

Este repositório contém módulos reutilizáveis do Terraform para criar alertas APM no Datadog. O objetivo é facilitar o monitoramento de múltiplas linguagens e frameworks como aiohttp, fastapi, flask, etc., possibilitando a gestão de serviços críticos de maneira automatizada.

Referências:

https://www.datadoghq.com/blog/managing-datadog-with-terraform/ 

https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/monitor

Operadores Disponíveis: 

O que é um Operador?

Um Operador é um módulo do Terraform que define a forma como os alertas APM são configurados e monitorados no Datadog. Cada operador é responsável por um tipo específico de aplicação ou framework e define métricas e alertas específicos para cada um.

Atualmente, os seguintes operadores estão configurados:

- aiohttp

- fastapi

- flask.request

Cada pasta de operador contém:

- main.tf: Definição dos recursos e monitores do Datadog

- variables.tf: Variáveis utilizadas no módulo

- terraform.tfvars: Variáveis personalizadas para cada aplicação


Os módulos criam os seguintes alertas no Datadog:

- Anomalia de Latência (Latency): 
   - Detecta mudanças anormais na latência das requisições (Percentil 75).

- Anomalia Watchdog (Watchdog Anomaly): 
   - Detecta eventos incomuns utilizando o monitoramento Watchdog.

- Aumento na Porcentagem de Erros (Increased error percentage): 
   - Dispara quando a porcentagem de erros excede o limite crítico configurado.

- Aumento no Número de Requisições (Increased number of requests/s): 
   - Dispara quando o número de requisições por segundo excede o limite crítico configurado.

--------------------------------------------------------------------------------------------------------------------------------------------------

Requisitos :

- Terraform >= 1.0.0

- Credenciais da API e App Key do Datadog com permissão para gerenciar monitores.

- Uma conta ativa no Datadog com permissões para criar monitores.

--------------------------------------------------------------------------------------------------------------------------------------------------

Configurações:

1. Clonando o Repositório do GitHub
Primeiro, clone o repositório para a sua máquina local:
```
git clone https://github.com/matheusmbp-sre/datadog-alerts-apm-tf.git
cd datadog-alerts-apm-tf
```

2. Configurando as Credenciais do Datadog

Export as seguintes variáveis de ambiente:

```
$ export DATADOG_API_KEY="<your_api_key>"
$ export DATADOG_APP_KEY="<your_app_key>"
```

3. Editando o Arquivo terraform.tfvars

Navegue até o diretório do operador desejado (ex: flask.resquest/) e abra o arquivo (terraform.tfvars) e altere com suas prefências as seguintes variáveis: env, service.name, notification e thresholds para os alertas :

- environment              = " <your-environment> "
- service_name             = " <your-service.name> "
- notification_channels    = "@example@gmail.com.br"
- error_critical_threshold = 5
- error_recovery_threshold = 2
- request_critical_threshold = 100
- request_recovery_threshold = 50

4- Executando o Terraform

Após alterar o arquivo (terraform.tfvars) rode os seguintes comandos:

``` 
terraform init
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars"
```
5. Verificando os Alertas Criados no Datadog

Se ocorrer tudo bem, a saída no monitors do Datadog deve ser semelhante a imagem abaixo:

![image](https://github.com/user-attachments/assets/f5f86443-dbaf-436d-b7df-29227c9e6f6f)

7.  Destruir os Recursos (se necessário)

Para remover os recursos criados, basta executar:

```
terraform destroy -var-file="terraform.tfvars"
```
---------------------------------------------------------------------------------------------------

Conclusão

Este projeto fornece uma maneira eficiente de automatizar a criação de alertas APM no Datadog usando Terraform. Ele foi desenvolvido para garantir a padronização e o fácil gerenciamento de monitoramentos em aplicações críticas, utilizando conceitos modernos de IaC (Infraestrutura como Código) e versionamento dos códigos.


