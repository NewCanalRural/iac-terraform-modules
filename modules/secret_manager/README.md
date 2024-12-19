# Módulo `secret_manager`

Este módulo cria e gerencia segredos no Google Cloud Secret Manager.

## Uso
```
module "secret-manager" {
  source      = "github.com/seu-usuario/gcp-modules//modules/secret_manager?ref=v1.0.0"
  version     = "~> 0.5"

  name        = var.name
  project_id  = var.project_id
  secret_data = var.secret
  labels      = var.labels
}
```

## Variáveis

| Nome                      | Tipo                                                                 | Padrão  | Obrigatório | Descrição                                                                    |
| ------------------------- | -------------------------------------------------------------------- | ------- | ----------- | ---------------------------------------------------------------------------- |
| name                      | string                                                               | n/a     | sim         | O nome do segredo a ser criado.                                              |
| project_id                | string                                                               | n/a     | sim         | O ID do projeto para gerenciar os recursos do Secret Manager.                |
| labels                    | map(string)                                                          | {}      | não         | O mapa de rótulos a serem adicionados ao segredo definido.                   |
| user_managed_replication  | list(object({<br>location = string,<br>kms_key_name = string,<br>})) | []      | não         | Parâmetros de replicação gerenciados pelo usuário para o segredo definido.   |
| automatic_replication     | object({<br>kms_key_name = optional(string, null)<br>})              | {}      | não         | Parâmetros de replicação automática para o segredo definido.                 |

## Outputs

| Nome        | Descrição                                        |
| ----------- | ------------------------------------------------ |
| id          | O ID do segredo criado                           |
| name        | O nome do segredo criado                         |
| project_id  | O ID do projeto GCP onde o segredo foi criado    |
| version     | A versão do segredo criado                       |