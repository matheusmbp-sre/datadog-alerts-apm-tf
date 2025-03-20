Datadog Alerts APM com Terraform

Objetivo

Este repositório contém módulos reutilizáveis do Terraform para criar alertas APM no Datadog. O objetivo é facilitar o monitoramento de múltiplas linguagens e frameworks como aiohttp, fastapi, flask, etc., possibilitando a gestão de serviços críticos de maneira automatizada.

Referências:

https://www.datadoghq.com/blog/managing-datadog-with-terraform/ 

https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/monitor

Operadores Disponíveis: 

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

--------------------------------------------------------------------------------------------------------------------------------------------------

Configurações:

Export as seguintes variáveis de ambiente:

```
$ export DATADOG_API_KEY="<your_api_key>"
$ export DATADOG_APP_KEY="<your_app_key>"
```
Navegue até o diretório do operador desejado (ex: flask.resquest/) e abra o arquivo (terraform.tfvars) e altere com suas prefências as seguintes variáveis: env, service.name, notification e thresholds para os alertas :

- environment              = "<your-environment>"
- service_name             = "<your-service.name>"
- notification_channels    = "@example@gmail.com.br"
- error_critical_threshold = 5
- error_recovery_threshold = 2
- request_critical_threshold = 100
- request_recovery_threshold = 50

Após alterar o arquivo (terraform.tfvars) rode os seguintes comandos:

``` 
terraform init
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars"
```

Se ocorrer tudo bem, a saída no datadog deve ser semelhante a imagem abaixo:

![image](https://github.com/user-attachments/assets/f5f86443-dbaf-436d-b7df-29227c9e6f6f)



