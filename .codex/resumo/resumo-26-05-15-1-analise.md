# Análise da tarefa

## Pedido original
- Criar os slices para implementar o bloco visual de resumo financeiro baseado em `lib/resources/resumo.png`.
- O bloco deve ficar abaixo do widget de recibo, na coluna da tela.
- O bloco deve exibir `Total do Pedido`, `Valor Entrada` e `Valor a pagar na Entrega`.

## Feature correspondente
- Feature: `recibo`.
- Caminho provável: `lib/features/recibo/`.
- Justificativa: o resumo financeiro faz parte da tela principal de recibo da System Card - RS, junto dos dados do recibo, produtos/serviços e visualização do recibo.

## Arquivos relacionados
- Arquivos existentes:
  - `AGENTS.md`
  - `pubspec.yaml`
  - `lib/main.dart`
  - `test/widget_test.dart`
  - `lib/resources/tema.jpeg`
  - `lib/resources/recibo.png`
  - `lib/resources/resumo.png`
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- Arquivos de planejamento relacionados:
  - `docs/codex/cabecalho/cabecalho-26-05-14-1-analise.md`
  - `docs/codex/cabecalho/cabecalho-26-05-14-1.md`
  - `docs/codex/cabecalho/cabecalho-26-05-14-1-resumo.md`
- Arquivos esperados ou prováveis durante a implementação:
  - `lib/features/recibo/presentation/pages/recibo_page.dart`
  - `lib/features/recibo/presentation/widgets/resumo_pedido.dart`
  - `lib/features/recibo/presentation/widgets/recibo_form.dart`
  - `lib/features/recibo/presentation/widgets/produtos_servicos.dart`
  - `lib/features/recibo/presentation/viewmodels/recibo_page_view_model.dart`
  - `lib/features/recibo/domain/models/item_recibo.dart`
  - `lib/features/recibo/domain/models/resumo_pedido.dart`
  - `test/features/recibo/presentation/widgets/resumo_pedido_test.dart`
  - `test/features/recibo/presentation/viewmodels/recibo_page_view_model_test.dart`

## Estado atual
- O código de produção ainda está próximo do template padrão Flutter em `lib/main.dart`.
- `test/widget_test.dart` ainda testa o contador padrão do template.
- A pasta `lib/features/recibo/` ainda não possui código de tela, widgets, ViewModel ou models no worktree atual.
- Existe um contrato antecipado em `lib/features/recibo/presentation/pages/recibo_page-contrato.md`, criado para orientar a construção incremental da `ReciboPage`.
- `lib/resources/resumo.png` existe e tem 681x148 pixels, servindo como referência visual do bloco de resumo.
- `lib/resources/tema.jpeg` mostra o resumo abaixo da área de dados do recibo/produtos, dentro da coluna esquerda da tela.

## Estado esperado
- A `ReciboPage` deve ter uma coluna principal onde o widget de recibo/produtos aparece acima do bloco de resumo.
- O bloco de resumo deve ser composto por widgets Flutter, não por uma renderização direta de `resumo.png`.
- O resumo deve exibir:
  - `Total do Pedido`, derivado da soma dos itens/produtos do recibo;
  - `Valor Entrada`, informado pelo usuário ou pelo estado da tela;
  - `Valor a pagar na Entrega`, calculado a partir de `total do pedido - valor entrada`.
- Em largura ampla, o bloco pode seguir a referência visual de `resumo.png`, com os três campos distribuídos lado a lado.
- Em larguras estreitas, os campos devem empilhar ou quebrar linha sem overflow, preservando a posição do bloco abaixo do widget de recibo.
- Valores monetários devem usar duas casas decimais e formato pt-BR com vírgula decimal.

## Riscos e dependências
- A implementação do resumo depende da existência ou criação prévia da `ReciboPage` e do widget de recibo/produtos.
- Como os slices de cabeçalho/base ainda não possuem resumos de execução no worktree atual, o executor deve verificar se a tela real já existe antes de integrar o resumo.
- O cálculo do total deve ser derivado do estado real dos itens, evitando duplicar fonte de verdade entre UI, ViewModel e models.
- `Valor Entrada` pode exigir validação para impedir valores negativos, texto inválido ou entrada maior que o total, conforme o padrão adotado na tela.
- A atualização reativa do `Valor a pagar na Entrega` deve acontecer quando produtos, quantidades, valores unitários ou entrada forem alterados.
- O projeto cita estado reativo em `lib/observable/`, mas esses arquivos não existem no worktree atual; os slices devem verificar o estado real antes de depender deles.
- Há risco de overflow em mobile se o layout tentar manter os três campos lado a lado.
- Há risco de regressão se a implementação do resumo misturar regras de cálculo diretamente no widget visual.

## Contratos de tela
- Contratos existentes que devem ser lidos antes da alteração:
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- Contratos que precisam ser criados:
  - Nenhum novo contrato de Page/View/Tela é necessário, porque a tela impactada continua sendo `ReciboPage`.
- Contratos que precisam ser atualizados:
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- Há impacto em UI porque a tarefa adiciona um bloco visual novo abaixo do widget de recibo.

## Estratégia
- Separar primeiro os dados e regras de cálculo do resumo, para evitar cálculo monetário espalhado pela UI.
- Expor o resumo pelo ViewModel ou estado da tela, usando a estrutura reativa disponível no projeto quando existir.
- Criar o widget `ResumoPedido` como componente visual composto, posicionado abaixo do widget de recibo/produtos na `ReciboPage`.
- Adicionar testes específicos para cálculo, atualização do saldo e renderização responsiva.
- Atualizar o contrato da `ReciboPage` em cada slice que alterar comportamento visual, dados renderizados ou regras de interação.

## Decisão sobre slices
- Haverá slices.
- Motivos:
  - a tarefa altera múltiplas responsabilidades: cálculo, estado da tela, UI e testes;
  - o resumo depende do estado dos produtos/serviços e do valor de entrada;
  - há integração visual com a `ReciboPage`, abaixo do widget de recibo;
  - há risco de overflow e regressão em layout responsivo;
  - o estado atual do projeto ainda não contém a tela real no código, então a execução precisa ser incremental e compatível com slices anteriores.

## Validações recomendadas
- `flutter analyze`
- `flutter test`
- `flutter test test/features/recibo/presentation/viewmodels/recibo_page_view_model_test.dart`
- `flutter test test/features/recibo/presentation/widgets/resumo_pedido_test.dart`
- Verificação responsiva em larguras aproximadas de 390, 768, 1024 e 1366 pixels.
