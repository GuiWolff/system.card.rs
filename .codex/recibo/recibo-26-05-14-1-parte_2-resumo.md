# Resumo do Slice 2/9 - Domínio e cálculos do recibo

## Escopo executado
- O slice foi aplicado conforme o prompt mestre `docs/codex/recibo/recibo-26-05-14-1.md`, que prevalece sobre a nomenclatura legada do arquivo do slice.
- A implementação permaneceu dentro de `lib/features/pedido_page/domain/`.
- Não foi criada ou evoluída `ReciboPage`, rota própria, `Scaffold` próprio ou entrada própria para recibo.
- Não houve alteração em `lib/main.dart`.
- Não foram implementados SQLite, repository, histórico, formulário final ou visualização final.

## O que foi feito
- Criados os modelos puros de domínio:
  - `ItemRecibo`;
  - `ResumoRecibo`;
  - `Recibo`.
- Implementado cálculo monetário usando centavos inteiros:
  - total do item por `quantidade * valorUnitarioCentavos`;
  - total do pedido pela soma dos totais dos itens;
  - valor a pagar na entrega por `totalPedidoCentavos - valorEntradaCentavos`.
- Implementadas validações básicas:
  - número do recibo obrigatório;
  - cliente obrigatório;
  - quantidade do item maior que zero;
  - descrição do item obrigatória;
  - valor unitário maior ou igual a zero;
  - valor de entrada maior ou igual a zero;
  - valor de entrada não pode ultrapassar o total do pedido.
- A decisão registrada no domínio foi bloquear entrada maior que o total do pedido.
- Os modelos foram exportados pelo barrel `lib/features/pedido_page/pedido_page.dart`.
- Criados testes de domínio em `test/features/pedido_page/domain/models/recibo_test.dart`.

## Arquivos alterados/criados
- Criado `lib/features/pedido_page/domain/models/item_recibo.dart`.
- Criado `lib/features/pedido_page/domain/models/resumo_recibo.dart`.
- Criado `lib/features/pedido_page/domain/models/recibo.dart`.
- Alterado `lib/features/pedido_page/pedido_page.dart`.
- Criado `test/features/pedido_page/domain/models/recibo_test.dart`.
- Revisado `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`.
- Criado `docs/codex/recibo/recibo-26-05-14-1-parte_2-resumo.md`.

## Validações executadas
- `flutter analyze`: passou, sem issues.
- `flutter test test/features/pedido_page/domain/models/recibo_test.dart`: passou, 7 testes.

## Impacto em UI
- Não houve impacto visual direto neste slice.
- A `PedidoPage` continua com a composição atual e o bloco inicial `ReciboPedido`.
- O impacto é contratual e de base de dados de tela: os próximos slices devem usar `Recibo`, `ItemRecibo` e `ResumoRecibo` como fonte das regras de cálculo e validação, evitando cálculo duplicado dentro de widgets.

## Contrato de tela
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md` foi revisado.
- O contrato agora registra os dados de domínio do recibo, itens e resumo.
- O contrato também registra as regras de cálculo em centavos inteiros e a validação de entrada maior que total.
- Foi mantida a orientação de que o recibo permanece integrado à `PedidoPage`, sem `ReciboPage` como tela independente.

## Próximos pontos para o Slice 3
- Adicionar SQLite embarcado compatível com Flutter Desktop dentro da feature `pedido_page`.
- Criar datasource `ReciboDatabase` em `lib/features/pedido_page/data/`.
- Definir schema inicial e migrations considerando os modelos de domínio criados neste slice.
- Manter a UI sem mudança visual direta, salvo ajuste mínimo exigido pela inicialização.
- Criar testes de banco em memória ou temporário conforme o arquivo do slice 3.
