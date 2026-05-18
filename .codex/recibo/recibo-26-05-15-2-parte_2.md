# Contexto
Você é um desenvolvedor Senior em Dart / Flutter.
Leia a análise da tarefa e o resumo do slice anterior, se houver.
Este é o slice 2/4 derivado de `docs/codex/recibo/recibo-26-05-15-2.md`.

## Análise da tarefa
- `docs/codex/recibo/recibo-26-05-15-2-analise.md`

## Continuidade
- Slice anterior: `docs/codex/recibo/recibo-26-05-15-2-parte_1-resumo.md`
- Antes de executar, confirme que o serviço de PDF A4 criado no slice 1 existe, está testado e gera bytes reutilizáveis.

## Arquivos
- `pubspec.yaml`
- `pubspec.lock`
- `lib/features/pedido_page/presentation/pages/pedido_page.dart`
- `lib/features/pedido_page/presentation/viewmodels/pedido_page_view_model.dart`
- `lib/features/pedido_page/presentation/widgets/recibo_pedido.dart`
- `lib/features/pedido_page/presentation/widgets/cabecalho_app.dart`
- `lib/features/pedido_page/services/recibo_pdf_service.dart`
- Novo arquivo sugerido: `lib/features/pedido_page/presentation/widgets/recibo_pdf_preview_dialog.dart`
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
  - ação `Gerar PDF` abrindo `AlertDialog`;
  - uso de PDF A4;
  - estados de carregamento/erro;
  - preservação da `PedidoPage` como tela real.

## Regras
- A ação `Gerar PDF` deve abrir uma visualização dentro de `AlertDialog`.
- O conteúdo do diálogo deve ter limites de largura e altura para não causar overflow.
- A prévia deve usar o PDF real gerado pelo serviço do slice 1.
- Não duplicar layout de PDF dentro do widget.
- `PedidoPageViewModel` pode coordenar estado/validação, mas não pode acessar `BuildContext`.
- A abertura de `showDialog` deve ficar na camada de apresentação.
- Se o recibo for inválido, usar as validações existentes do domínio/ViewModel e exibir mensagem sem abrir PDF inválido.
- Preservar os fluxos existentes de salvar, novo recibo, histórico e clientes.
- Atualizar o botão de `ReciboPedido` e, se aplicável, o botão de cabeçalho `GERAR PDF` para o mesmo fluxo.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não misture etapas de outros slices.
- Não execute automaticamente o próximo slice.
- Não faça commit.
- Não criar `ReciboPage`, rota própria ou `Scaffold` novo.
- Não colocar regra pesada de PDF dentro do `build`.
- Não usar `setState` para estado que já pertence à ViewModel.

## Entregáveis
1. Diálogo de prévia de PDF criado.
2. Ação `Gerar PDF` conectada ao diálogo.
3. Estados de erro/progresso preservados ou ajustados de forma reativa.
4. `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md` atualizado.
5. Testes de widget cobrindo abertura do `AlertDialog` ao gerar PDF.
6. Registrar no resumo do slice quais contratos de tela foram atualizados.
7. Rodar validações específicas.
8. Salvar resumo em `docs/codex/recibo/recibo-26-05-15-2-parte_2-resumo.md`.

# Descrição
- Integrar a geração de PDF ao fluxo visual da `PedidoPage`, exibindo o PDF A4 em um `AlertDialog` quando o usuário acionar `Gerar PDF`.

## Objetivo
- Ao final deste slice, o usuário deve conseguir gerar e visualizar o PDF A4 do recibo atual sem sair da `PedidoPage`.
