# Contexto
Você é um desenvolvedor Senior em Dart / Flutter.
Leia a análise da tarefa e o resumo do slice anterior, se houver.
Este é o slice 3/4 derivado de `docs/codex/recibo/recibo-26-05-15-2.md`.

## Análise da tarefa
- `docs/codex/recibo/recibo-26-05-15-2-analise.md`

## Continuidade
- Slice anterior: `docs/codex/recibo/recibo-26-05-15-2-parte_2-resumo.md`
- Antes de executar, confirme que a visualização em `AlertDialog` já usa o PDF real gerado pelo serviço do slice 1.

## Arquivos
- `pubspec.yaml`
- `pubspec.lock`
- `lib/features/pedido_page/presentation/pages/pedido_page.dart`
- `lib/features/pedido_page/presentation/viewmodels/pedido_page_view_model.dart`
- `lib/features/pedido_page/presentation/widgets/recibo_pedido.dart`
- `lib/features/pedido_page/presentation/widgets/cabecalho_app.dart`
- `lib/features/pedido_page/services/recibo_pdf_service.dart`
- Novo arquivo sugerido: `lib/features/pedido_page/services/recibo_documento_service.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- `test/features/pedido_page/presentation/pages/pedido_page_test.dart`
- `test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`
- `test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`

## Contratos de tela
- Contrato existente que deve ser lido antes da alteração:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Contrato que este slice deve atualizar:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Registrar no contrato:
  - impressão real substituindo o estado meramente preparatório;
  - uso do mesmo PDF A4 da prévia;
  - estados de processamento, sucesso e erro.

## Regras
- A impressão deve reutilizar o mesmo serviço/base de PDF do slice 1.
- Não criar um segundo layout de recibo apenas para impressão.
- Não mover regra de impressão para widgets pequenos quando ela puder ficar em serviço ou coordenação de tela.
- `PedidoPageViewModel` não deve acessar `BuildContext`.
- Se for necessário chamar API de plugin de impressão na camada de apresentação, separar validação/estado da chamada visual/plataforma.
- A ação `Imprimir` no recibo e, se aplicável, no cabeçalho devem executar o mesmo fluxo.
- Em caso de falha do plugin de impressão, exibir erro claro na UI sem quebrar a tela.
- Preservar a geração de PDF em `AlertDialog` implementada no slice anterior.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não misture etapas de outros slices.
- Não execute automaticamente o próximo slice.
- Não faça commit.
- Não criar `ReciboPage`, rota própria ou `Scaffold` novo.
- Não duplicar código de geração de PDF.

## Entregáveis
1. Impressão real implementada com o mesmo PDF A4.
2. Ação `Imprimir` conectada ao fluxo real.
3. Estados/feedbacks antigos de impressão preparatória substituídos ou compatibilizados sem regressão.
4. `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md` atualizado.
5. Testes cobrindo o acionamento do fluxo de impressão com serviço fake quando necessário.
6. Registrar no resumo do slice quais contratos de tela foram atualizados.
7. Rodar validações específicas.
8. Salvar resumo em `docs/codex/recibo/recibo-26-05-15-2-parte_3-resumo.md`.

# Descrição
- Implementar a impressão real do recibo a partir do mesmo PDF A4 usado na prévia.

## Objetivo
- Ao final deste slice, o usuário deve conseguir imprimir o recibo atual usando o PDF já padronizado no fluxo da feature.
