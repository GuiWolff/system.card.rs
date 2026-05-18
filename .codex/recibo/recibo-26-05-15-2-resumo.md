# Resumo geral da tarefa

## Tarefa solicitada
- Gerar PDF do recibo em tamanho A4.
- Visualizar o PDF gerado em um `AlertDialog`.
- Implementar impressão usando a mesma geração de PDF.
- Implementar compartilhamento por e-mail, WhatsApp ou salvamento no Explorer com escolha de caminho.
- Abrir popup de opções no momento do compartilhamento.

## Arquivos de prompt criados
- `docs/codex/recibo/recibo-26-05-15-2-analise.md`
- `docs/codex/recibo/recibo-26-05-15-2.md`
- `docs/codex/recibo/recibo-26-05-15-2-parte_1.md`
- `docs/codex/recibo/recibo-26-05-15-2-parte_2.md`
- `docs/codex/recibo/recibo-26-05-15-2-parte_3.md`
- `docs/codex/recibo/recibo-26-05-15-2-parte_4.md`
- `docs/codex/recibo/recibo-26-05-15-2-resumo.md`

## Lista de slices
- Slice 1/4: `docs/codex/recibo/recibo-26-05-15-2-parte_1.md`
- Slice 2/4: `docs/codex/recibo/recibo-26-05-15-2-parte_2.md`
- Slice 3/4: `docs/codex/recibo/recibo-26-05-15-2-parte_3.md`
- Slice 4/4: `docs/codex/recibo/recibo-26-05-15-2-parte_4.md`

## Ordem correta de execução
1. Executar `docs/codex/recibo/recibo-26-05-15-2-parte_1.md`.
2. Criar o resumo `docs/codex/recibo/recibo-26-05-15-2-parte_1-resumo.md`.
3. Executar `docs/codex/recibo/recibo-26-05-15-2-parte_2.md`.
4. Criar o resumo `docs/codex/recibo/recibo-26-05-15-2-parte_2-resumo.md`.
5. Executar `docs/codex/recibo/recibo-26-05-15-2-parte_3.md`.
6. Criar o resumo `docs/codex/recibo/recibo-26-05-15-2-parte_3-resumo.md`.
7. Executar `docs/codex/recibo/recibo-26-05-15-2-parte_4.md`.
8. Criar o resumo `docs/codex/recibo/recibo-26-05-15-2-parte_4-resumo.md`.

## Validações esperadas
- `flutter pub get` quando dependências forem adicionadas ou alteradas.
- `flutter analyze` ao final de cada slice que alterar código Dart/Flutter.
- Testes específicos dos serviços de PDF, impressão e compartilhamento.
- `flutter test test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`
- `flutter test test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`
- `flutter test test/features/pedido_page/presentation/pages/pedido_page_test.dart`
- `flutter test` no fechamento do slice 4, caso o impacto acumulado seja amplo.

## Contratos de tela criados, atualizados ou revisados
- Atualizado:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Lido como referência, sem criação de tela nova:
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- Nenhum contrato novo foi criado porque a tarefa deve continuar usando a `PedidoPage` real.

## Observações importantes para continuidade
- A implementação deve permanecer em `lib/features/pedido_page/`.
- Não criar `ReciboPage`, rota própria ou feature paralela.
- O PDF A4 deve ser a fonte comum para visualização, impressão, compartilhamento e salvamento.
- A `PedidoPageViewModel` não deve acessar `BuildContext`.
- O popup de compartilhamento deve deixar claro quando a plataforma abrir a folha de compartilhamento do sistema em vez de direcionar diretamente para WhatsApp ou e-mail.
- O primeiro arquivo a executar é `docs/codex/recibo/recibo-26-05-15-2-parte_1.md`.
