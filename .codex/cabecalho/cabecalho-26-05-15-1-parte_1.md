# Contexto
Você é um desenvolvedor Senior em Dart / Flutter.
Leia a análise da tarefa e o resumo do slice anterior, se houver.
Este é o slice 1/6 derivado de `docs/codex/cabecalho/cabecalho-26-05-15-1.md`.

## Análise da tarefa
- `docs/codex/cabecalho/cabecalho-26-05-15-1-analise.md`

## Continuidade
- Este é o primeiro slice. Não há resumo anterior.

## Arquivos
- `pubspec.yaml`
- `lib/features/pedido_page/domain/models/cabecalho_empresa.dart`
- `lib/features/pedido_page/data/repositories/cabecalho_preferencias_repository.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- `test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`
- Novo teste específico para persistência do cabeçalho, se fizer sentido no padrão do projeto.

## Contratos de tela
- Contrato relacionado:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Contratos existentes que devem ser lidos antes da alteração:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Contratos que este slice deve criar, atualizar ou revisar:
  - Revisar `pedido_page-contrato.md` com os dados persistentes do cabeçalho.

## Regras
- Não alterar UI neste slice.
- Manter `CabecalhoEmpresa.systemCardRs()` como fallback padrão.
- Representar o logo salvo como base64 opcional, sem remover o fallback visual atual.
- Persistir dados do cabeçalho em `SharedPreferences`.
- Não salvar bytes de imagem em arquivo neste slice; o requisito é base64 em `SharedPreferences`.
- Definir chaves de preferência estáveis e isoladas.
- Se criar parser/serialização, cobrir casos de dados ausentes ou inválidos.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não misture etapas de outros slices.
- Não implemente o editor visual.
- Não implemente cadastro de clientes.
- Não execute automaticamente o próximo slice.
- Não faça commit.

## Entregáveis
1. Modelo de cabeçalho preparado para dados editáveis e logo base64.
2. Repository/service de `SharedPreferences` para carregar, salvar e restaurar padrão.
3. Testes de fallback, persistência e remoção de logo.
4. Revisar `pedido_page-contrato.md`.
5. Registrar no resumo do slice quais contratos de tela foram criados, atualizados ou revisados.
6. Rodar validações específicas.
7. Salvar resumo em `docs/codex/cabecalho/cabecalho-26-05-15-1-parte_1-resumo.md`.

# Descrição
- Preparar a persistência dos dados editáveis do cabeçalho sem modificar a interface.

## Objetivo
- Ao final deste slice, os dados editáveis do cabeçalho devem ter uma fonte persistente testável baseada em `SharedPreferences`, pronta para ser conectada à ViewModel.
