# Resumo do Slice 5/9 - Estado do recibo na PedidoPageViewModel

## O que foi feito
- O slice foi executado conforme o prompt mestre `docs/codex/recibo/recibo-26-05-14-1.md`.
- Não foi criada `ReciboPageViewModel`.
- Não foi criada ou evoluída `ReciboPage`, rota própria, `Scaffold` próprio ou entrada própria para recibo.
- A `PedidoPageViewModel` foi evoluída como dona do estado de composição entre recibo, itens, resumo e histórico.
- O recibo em edição passou a ser a fonte de verdade principal da ViewModel.
- Os totais temporários já usados pelo `ReciboPedido` e pelo resumo da `PedidoPage` agora são derivados dos modelos de domínio `Recibo`, `ItemRecibo` e `ResumoRecibo`.
- O `ReciboRepository` foi integrado ao fluxo de estado da `PedidoPageViewModel`, sem acesso a `BuildContext`.
- A `PedidoPage` passou a criar a ViewModel padrão com `ReciboRepositorySqlite(ReciboDatabase.desktop())` quando nenhuma ViewModel é injetada.
- Foram adicionados estados reativos para histórico, carregamento, salvamento, erro e recibo salvo/não salvo.
- Foram adicionados comandos de edição de recibo, edição de itens, salvar, carregar, listar/pesquisar histórico e excluir recibo.
- Foram criados testes de estado e fluxo com repository fake.

## Arquivos alterados/criados
- Alterado `lib/features/pedido_page/presentation/viewmodels/pedido_page_view_model.dart`.
- Alterado `lib/features/pedido_page/presentation/pages/pedido_page.dart`.
- Alterado `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`.
- Alterado `test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`.
- Criado `docs/codex/recibo/recibo-26-05-14-1-parte_5-resumo.md`.

## Validações executadas
- `flutter test test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`: passou, 6 testes.
- `flutter analyze`: passou, sem issues.

## Impacto em UI
- Não houve mudança visual direta neste slice.
- A justificativa é que a alteração foi de estado e integração com repository: o `ReciboPedido` e o resumo temporário continuam exibindo os mesmos indicadores e textos.
- O impacto é estrutural para UI futura: formulário, tabela, visualização e histórico agora podem consumir a mesma `PedidoPageViewModel` sem duplicar regra de cálculo ou acessar SQLite diretamente.

## Contrato de tela
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md` foi atualizado.
- O contrato agora registra:
  - `reciboEmEdicao` como fonte de verdade;
  - estados de histórico, carregamento, salvamento, erro e recibo salvo/não salvo;
  - comandos públicos da ViewModel para edição, persistência e histórico;
  - integração da `PedidoPage` com `ReciboRepositorySqlite`;
  - ausência de mudança visual direta no slice 5.

## Próximos pontos para o Slice 6
- Implementar o formulário "Dados do Recibo" dentro do bloco `ReciboPedido`.
- Implementar a tabela "Produtos / Serviços" dentro da composição da `PedidoPage`.
- Conectar os campos e ações da UI aos comandos já expostos pela `PedidoPageViewModel`.
- Manter o resumo da `PedidoPage` alimentado pela mesma fonte de dados do recibo.
- Atualizar o contrato com os novos estados visuais e regras de interação do formulário e da tabela.
