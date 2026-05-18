# Resumo do slice 1/4 - Modelo e cálculo do resumo

## O que foi feito
- A estrutura real do projeto foi confirmada em `lib/features/pedido_page/`, não em `lib/features/recibo/`.
- Foi preservado o domínio existente `ItemRecibo`, `ResumoRecibo` e `Recibo`, evitando duplicar modelos em uma feature paralela.
- O cálculo do resumo segue centralizado em `ResumoRecibo.calcular`, com total derivado dos itens e saldo derivado de `total do pedido - valor entrada`.
- Foram adicionados testes de domínio para entrada vazia tratada como zero, entrada zero, entrada válida, entrada negativa e entrada maior que o total.

## Contratos de tela
- Revisados:
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`;
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`.
- Houve impacto indireto em UI porque o contrato do resumo financeiro define os dados que serão exibidos no bloco visual.
- Não houve alteração visual neste slice.

## Validações
- `flutter analyze`: passou, sem issues.
- `flutter test test/features/pedido_page/domain/models/recibo_test.dart`: passou.
- `flutter test test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`: passou.

## Continuidade
- O próximo slice deve expor o resumo e a validação pela ViewModel real da tela, mantendo a UI sem regra de cálculo no `build`.
