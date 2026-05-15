# Contexto
Você é um desenvolvedor Senior em Dart / Flutter.
Leia a análise da tarefa e o resumo do slice anterior, se houver.
Este é o slice 2/5 derivado de `docs/codex/cabecalho/cabecalho-26-05-14-1.md`.

## Análise da tarefa
- `docs/codex/cabecalho/cabecalho-26-05-14-1-analise.md`

## Continuidade
- Slice anterior: `docs/codex/cabecalho/cabecalho-26-05-14-1-parte_1-resumo.md`
- Antes de iniciar, leia o resumo do slice 1 e preserve o estado produzido por ele.

## Arquivos
- `lib/features/recibo/presentation/pages/recibo_page.dart`
- `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- `lib/features/recibo/presentation/viewmodels/recibo_page_view_model.dart`
- `lib/features/recibo/domain/models/cabecalho_empresa.dart`
- `test/features/recibo/presentation/viewmodels/recibo_page_view_model_test.dart`

## Contratos de tela
- Contrato relacionado:
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- Contratos existentes que devem ser lidos antes da alteração:
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- Contratos que este slice deve criar, atualizar ou revisar:
  - Revisar ou atualizar o contrato com os dados necessários do cabeçalho.
- Este slice impacta indiretamente UI porque define os dados que a tela deverá renderizar.

## Regras
- Modelar os dados do cabeçalho sem colocar regra de apresentação no model.
- Expor dados padrão da System Card - RS por ViewModel, factory ou composição simples da tela, conforme o padrão mais adequado ao estado atual do projeto.
- Dados mínimos:
  - logo ou referência de asset;
  - nome da empresa;
  - subtítulo;
  - Instagram;
  - WhatsApp;
  - telefone;
  - endereço;
  - ações disponíveis.
- Se criar ViewModel, ele não deve acessar `BuildContext`.
- Não depender de `TemaApp`, `TemaService`, `Rx` ou `Obx` sem confirmar que esses arquivos existem no worktree atual.
- Se o estado for estático neste momento, manter a solução simples e testável.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não misture etapas de outros slices.
- Não implemente o layout visual final do cabeçalho neste slice.
- Não implemente PDF ou impressão real.
- Não execute automaticamente o próximo slice.
- Não faça commit.

## Entregáveis
1. Modelo ou estrutura equivalente representando os dados do cabeçalho.
2. ViewModel ou fonte de dados testável para a `ReciboPage`.
3. Testes cobrindo os dados padrão do cabeçalho.
4. Criar ou atualizar `[nome-da-tela]-contrato.md` quando houver alteração em Page/View/Tela.
5. Registrar no resumo do slice quais contratos de tela foram criados, atualizados ou revisados.
6. Rodar validações específicas.
7. Salvar resumo em `docs/codex/cabecalho/cabecalho-26-05-14-1-parte_2-resumo.md`.

# Descrição
- Separar o conteúdo e os estados do cabeçalho antes da construção visual do widget.

## Objetivo
- Ao final deste slice, os dados do cabeçalho devem estar centralizados, testados e prontos para consumo pelo widget visual.
