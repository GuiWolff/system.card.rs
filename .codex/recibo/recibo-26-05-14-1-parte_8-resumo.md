# Resumo do Slice 8/9 - Histórico e ações dentro da PedidoPage

## O que foi feito
- O slice 8 foi executado conforme o prompt mestre `docs/codex/recibo/recibo-26-05-14-1.md`.
- Não foi criada ou evoluída `ReciboPage`.
- Não foi criada rota própria, `Scaffold` próprio, entrada própria para recibo ou `ReciboPageViewModel`.
- `lib/main.dart` não foi alterado.
- Foi criado `HistoricoRecibosPainel` como widget integrado à feature `pedido_page`.
- O bloco `ReciboPedido` passou a expor ações de salvar, novo recibo, abrir histórico, imprimir e gerar PDF.
- O histórico é aberto em `Dialog` dentro do fluxo da `PedidoPage`, preservando o recibo em edição enquanto o painel é aberto ou fechado.
- O painel lista recibos persistidos, permite pesquisar por número, cliente ou telefone e oferece ações de carregar, duplicar e excluir.
- A exclusão pelo painel exige confirmação visual antes de chamar a ViewModel.
- `PedidoPageViewModel` passou a expor `duplicarRecibo`, `prepararImpressao`, `prepararGeracaoPdf` e `ultimaAcaoRecibo`.
- As ações de imprimir e gerar PDF ficaram apenas como estado/feedback, sem exportação real e sem integração real com impressora.
- Foi feito ajuste responsivo pontual em `VisualizacaoRecibo` para evitar overflow nos rótulos de totais em larguras compactas.

## Arquivos alterados/criados
- Criado `lib/features/pedido_page/presentation/widgets/historico_recibos_painel.dart`.
- Alterado `lib/features/pedido_page/presentation/widgets/recibo_pedido.dart`.
- Alterado `lib/features/pedido_page/presentation/viewmodels/pedido_page_view_model.dart`.
- Alterado `lib/features/pedido_page/presentation/widgets/visualizacao_recibo.dart`.
- Alterado `lib/features/pedido_page/pedido_page.dart`.
- Alterado `test/features/pedido_page/presentation/pages/pedido_page_test.dart`.
- Alterado `test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`.
- Alterado `test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`.
- Alterado `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`.
- Criado `docs/codex/recibo/recibo-26-05-14-1-parte_8-resumo.md`.

## Validações executadas
- `flutter analyze`: passou, sem issues.
- `flutter test test/features/pedido_page/presentation/pages/pedido_page_test.dart`: passou, 6 testes.
- `flutter test`: passou, 36 testes.
- Validação adicional executada: `flutter test test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`: passou, 8 testes.
- Validação adicional executada: `flutter test test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`: passou, 2 testes.

## Impacto em UI
- O bloco de recibo agora exibe uma barra de ações com:
  - `Salvar`;
  - `Novo recibo`;
  - `Histórico`;
  - `Imprimir`;
  - `Gerar PDF`.
- O painel de histórico é exibido como diálogo pesquisável, com lista em builder e ações por recibo.
- Carregar um recibo pelo histórico atualiza a mesma fonte de verdade `reciboEmEdicao`; por isso formulário, tabela, resumo e visualização passam a refletir o recibo carregado.
- Duplicar um recibo carrega uma cópia sem ids e marca o estado como não salvo.
- Imprimir e gerar PDF exibem feedback de preparação, sem executar exportação.

## Contrato de tela
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md` foi atualizado.
- O contrato passou a registrar:
  - `HistoricoRecibosPainel` integrado à `PedidoPage`;
  - ações conectadas à `PedidoPageViewModel`;
  - fluxo de carregar recibo atualizando formulário, tabela, resumo e visualização;
  - duplicação sem ids;
  - confirmação de exclusão;
  - impressão e PDF como preparação de estado, sem implementação real.

## Próximos pontos para o Slice 9
- Revisar a integração completa da `PedidoPage` com recibo, histórico e visualização.
- Validar explicitamente que não existe Page/rota independente de recibo criada por esta tarefa.
- Fazer validação manual de persistência após reinicialização no desktop, se o ambiente permitir.
- Revisar responsividade e acessibilidade do conjunto `PedidoPage` + recibo + histórico.
- Fechar pendências de contrato e validações finais sem implementar PDF ou impressão real fora de escopo.
