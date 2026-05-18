# Contexto
Você é um desenvolvedor Senior em Dart / Flutter.
Leia a análise da tarefa e o resumo do slice anterior, se houver.
Este é o slice 2/5 derivado de `docs/codex/pedido_page/pedido_page-26-05-15-1.md`.

## Análise da tarefa
- `docs/codex/pedido_page/pedido_page-26-05-15-1-analise.md`

## Continuidade
- Slice anterior: `docs/codex/pedido_page/pedido_page-26-05-15-1-parte_1-resumo.md`
- Leia o resumo do slice 1 antes de alterar arquivos.

## Arquivos
- `lib/features/pedido_page/presentation/pages/pedido_page.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- `lib/features/pedido_page/presentation/widgets/pedido_page_layout.dart`
- `test/features/pedido_page/presentation/pages/pedido_page_test.dart`

## Contratos de tela
- Contrato relacionado:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Contratos existentes que devem ser lidos antes da alteração:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Contratos que este slice deve criar, atualizar ou revisar:
  - Atualizar `pedido_page-contrato.md` com layout, regiões e regras responsivas.

## Regras
- Criar `PedidoPageLayout` como widget de composição.
- Definir slots ou parâmetros para:
  - cabeçalho;
  - recibo;
  - resumo.
- O layout deve suportar:
  - desktop amplo;
  - desktop estreito;
  - tablet/mobile quando aplicável.
- O resumo deve ficar abaixo do recibo na coluna principal, conforme planejamento de `resumo`.
- Evitar UI card dentro de card.
- Usar rolagem controlada quando a altura da janela não comportar todos os blocos.
- Criar testes de widget para ordem visual e ausência de overflow.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não misture etapas de outros slices.
- Não implemente lógica interna de cabeçalho, recibo ou resumo.
- Não implemente ViewModel neste slice.
- Não execute automaticamente o próximo slice.
- Não faça commit.

## Entregáveis
1. `PedidoPageLayout` criado.
2. `PedidoPage` usando o layout.
3. Testes de layout criados ou atualizados.
4. `pedido_page-contrato.md` atualizado.
5. Validações específicas executadas.
6. Salvar resumo em `docs/codex/pedido_page/pedido_page-26-05-15-1-parte_2-resumo.md`.

# Descrição
- Criar a estrutura visual responsiva da `PedidoPage` com slots para os blocos que serão integrados.

## Objetivo
- Ao final deste slice, a tela deve ter um layout estável para receber Cabeçalho, Recibo e Resumo sem overflow.
