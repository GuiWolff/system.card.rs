# Contrato de tela: ReciboPage

## Nome da tela
- `ReciboPage`

## Objetivo da tela
- Servir como tela principal do app de recibos da System Card - RS em Flutter Desktop.
- Permitir criar, editar, salvar, carregar e visualizar recibos.
- Persistir o histórico de recibos localmente em SQLite embarcado.
- Exibir formulário, produtos/serviços, resumo financeiro, visualização do recibo e acesso ao histórico.

## Estado atual da tela
- A tela ainda não existe em `lib/features/recibo/presentation/pages/recibo_page.dart`.
- O app atual inicia na `PedidoPage`, que reserva um encaixe temporário para a área de recibo.
- O contrato foi criado no planejamento do cabeçalho e agora foi revisado para cobrir a feature completa de recibo.
- Não há ViewModel, domínio, repository, SQLite ou widgets da feature implementados.

## Estado esperado após a tarefa
- A tela deve existir e ser a entrada principal do app.
- O cabeçalho deve seguir a referência `lib/resources/cabecalho.png`.
- O formulário editável deve seguir a referência `lib/resources/recibo.png`.
- A visualização do documento deve seguir a referência `lib/resources/visualizacao.png`.
- O usuário deve conseguir preencher dados, adicionar/remover produtos, calcular totais, salvar no SQLite, consultar histórico e carregar recibos anteriores.
- A tela deve continuar funcional quando a janela desktop for redimensionada.

## Estados visuais possíveis
- Estado inicial:
  - formulário vazio ou com recibo novo sugerido;
  - tabela de itens vazia ou com linha de inclusão;
  - resumo zerado;
  - visualização refletindo o estado atual.
- Estado de edição:
  - campos preenchidos;
  - itens editáveis;
  - resumo recalculado automaticamente.
- Estado salvo:
  - indicação de que o recibo atual está persistido;
  - ações de carregar, duplicar, excluir e novo disponíveis conforme contexto.
- Estado com alterações não salvas:
  - a tela deve preservar o recibo em edição e evitar perda acidental de dados.
- Estado de carregamento:
  - histórico ou recibo específico sendo carregado do SQLite.
- Estado de salvamento:
  - ação de salvar em andamento.
- Estado de erro:
  - mensagem clara para falhas de validação, banco, salvar, carregar ou excluir.
- Estado de histórico aberto:
  - painel/dialog com lista pesquisável de recibos.
- Estado desktop amplo:
  - formulário/resumo e visualização podem ficar lado a lado.
- Estado desktop estreito:
  - seções devem empilhar ou rolar sem overflow horizontal.

## Dados necessários para renderização
- Dados do cabeçalho:
  - logo/asset ou fallback;
  - nome `SYSTEM CARD - RS`;
  - subtítulo `Sistemas de Identificação`;
  - Instagram `@systemcards`;
  - WhatsApp `51 998020198`;
  - telefone `51 30551025`;
  - endereço `Rua 20 de Setembro, 528 - Centro - Guaíba - RS`.
- Dados do recibo:
  - id interno;
  - número do recibo;
  - data de recebimento;
  - data de entrega;
  - cliente;
  - telefone;
  - observações;
  - data de criação;
  - data de atualização.
- Dados dos produtos/serviços:
  - id interno;
  - ordem;
  - quantidade;
  - descrição;
  - valor unitário em centavos;
  - valor total em centavos.
- Dados do resumo:
  - total do pedido em centavos;
  - valor de entrada em centavos;
  - valor a pagar na entrega em centavos.
- Dados do histórico:
  - lista de recibos salvos;
  - termo de pesquisa;
  - estados de carregamento, erro e lista vazia.

## Ações do usuário disponíveis
- Criar novo recibo.
- Editar número, datas, cliente, telefone e observações.
- Adicionar produto/serviço.
- Editar quantidade, descrição e valor unitário.
- Remover produto/serviço.
- Limpar todos os produtos/serviços.
- Informar valor de entrada.
- Salvar recibo.
- Abrir histórico.
- Pesquisar histórico.
- Carregar recibo salvo.
- Duplicar recibo salvo.
- Excluir recibo salvo com confirmação.
- Preparar impressão.
- Preparar geração de PDF.
- Abrir mais opções.

## Regras de interação
- A visualização deve sempre refletir os mesmos dados do formulário.
- Totais devem ser recalculados quando itens ou valor de entrada mudarem.
- Valores monetários devem ser manipulados como centavos inteiros no domínio e persistência.
- Datas devem ser persistidas em formato ISO-8601 e exibidas em formato brasileiro.
- Campos obrigatórios devem ser validados antes de salvar.
- Excluir recibo deve exigir confirmação.
- Carregar outro recibo com alterações não salvas deve exigir decisão clara do usuário ou preservar estado conforme regra implementada.
- Listas de produtos e histórico devem usar builder quando houver risco de crescimento.
- ViewModel/Controller não deve acessar `BuildContext`.
- Widgets não devem concentrar regra de negócio ou persistência.

## Dependências da tela
- `MaterialApp` em `lib/main.dart`.
- Assets em `lib/resources/`.
- `ReciboPageViewModel`.
- Modelos de domínio da feature `recibo`.
- `ReciboRepository`.
- Implementação SQLite do repository.
- Datasource SQLite embarcado para Desktop.
- Widgets da feature:
  - cabeçalho;
  - formulário;
  - tabela de produtos/serviços;
  - resumo;
  - visualização;
  - histórico.

## Widgets principais
- `ReciboPage`
- `CabecalhoApp` ou widget equivalente de cabeçalho.
- `ReciboFormulario`
- `ProdutosServicosTabela`
- `ResumoReciboCard`
- `VisualizacaoRecibo`
- `HistoricoRecibosPainel`

## ViewModel/Controller relacionado
- Esperado: `ReciboPageViewModel`.
- Responsabilidades:
  - manter estado do recibo em edição;
  - manter lista de itens;
  - calcular resumo;
  - validar dados;
  - coordenar salvar, carregar, listar, pesquisar, duplicar e excluir;
  - expor estados de carregamento, salvamento e erro;
  - preparar ações de imprimir e gerar PDF.
- O ViewModel não deve acessar `BuildContext`.

## Pontos que cada slice precisa preservar
- Slice 1:
  - criar a base da feature sem implementar persistência ou UI completa.
- Slice 2:
  - manter domínio puro, sem Flutter e sem SQLite.
- Slice 3:
  - criar SQLite versionado sem acoplar UI.
- Slice 4:
  - usar repository transacional e DTOs isolados.
- Slice 5:
  - concentrar estado na ViewModel sem regra visual.
- Slice 6:
  - construir formulário e tabela responsivos.
- Slice 7:
  - renderizar visualização a partir dos mesmos dados do formulário.
- Slice 8:
  - implementar histórico e ações sem criar Page nova desnecessária.
- Slice 9:
  - revisar integração, responsividade, testes e contrato final.

## Pendências conhecidas
- A `ReciboPage` ainda não existe.
- A infraestrutura SQLite ainda não existe.
- Não há logo isolado disponível no estado atual do projeto.
- O tema customizado citado no `AGENTS.md` não existe no worktree atual.
- Impressão e geração real de PDF podem exigir dependências e devem ser tratadas como integração futura se não forem definidas nos slices.
- Os testes iniciais do app agora validam a abertura da `PedidoPage`; a implementação própria da `ReciboPage` continua pendente.

## Continuidade esperada para os próximos slices
- Executar primeiro `docs/codex/recibo/recibo-26-05-14-1-parte_1.md`.
- O orquestrador deve executar um slice por sessão, criar o resumo do slice, encerrar a sessão e abrir nova sessão limpa para o próximo.
- Este contrato deve ser atualizado sempre que a tela, estados visuais, dados renderizados ou regras de interação forem alterados.

## Atualização de planejamento - Resumo financeiro
- Tarefa relacionada: `docs/codex/resumo/resumo-26-05-15-1.md`.
- Referência visual: `lib/resources/resumo.png`.
- Tela impactada: `ReciboPage`.
- Widget esperado: `ResumoPedido`, posicionado abaixo do widget de recibo/produtos na coluna principal da tela.
- O resumo deve ser composto por widgets Flutter e não deve renderizar `resumo.png` como imagem final única.
- O bloco deve exibir:
  - `Total do Pedido`;
  - `Valor Entrada`;
  - `Valor a pagar na Entrega`.
- `Total do Pedido` deve ser derivado da soma dos itens/produtos do recibo.
- `Valor Entrada` deve vir do estado da tela e ser validado como valor monetário.
- `Valor a pagar na Entrega` deve ser calculado a partir de `total do pedido - valor entrada`.
- Os valores devem usar duas casas decimais e formatação pt-BR.
- Em largura ampla, os três campos podem ficar lado a lado como na referência visual.
- Em mobile, os campos devem empilhar ou quebrar linha sem overflow horizontal.
- O cálculo monetário deve ficar no model, ViewModel ou controller equivalente, não dentro do `build` do widget.
- O `ReciboPageViewModel` ou controller equivalente deve expor total, entrada, saldo de entrega, estado de validação e valores formatados.
- O contrato deve ser revisado nos slices de resumo sempre que mudarem dados renderizados, estados visuais ou regras de interação.
- Pendência conhecida: confirmar a regra definitiva para `Valor Entrada` maior que `Total do Pedido`.
- Continuidade: executar `docs/codex/resumo/resumo-26-05-15-1-parte_1.md` quando a base da `ReciboPage` e do widget de recibo/produtos estiver disponível.

## Revisão do resumo financeiro - Slices 1/4 e 2/4
- A implementação real do app segue concentrada em `lib/features/pedido_page/`, com a `PedidoPage` como tela agregadora atual.
- Não foi criada `ReciboPage` nem estrutura paralela em `lib/features/recibo/` para o resumo.
- O cálculo do resumo usa os modelos reais `ItemRecibo`, `ResumoRecibo` e `Recibo` da feature `pedido_page`.
- Regra consolidada:
  - entrada vazia ou inválida digitada na UI deve virar `0` centavos;
  - entrada zero é válida;
  - entrada negativa é inválida;
  - entrada maior que o total do pedido é inválida.
- O estado equivalente ao `ReciboPageViewModel` é `PedidoPageViewModel`, que expõe o resumo financeiro, os valores formatados e a validação de entrada.
- O contrato visual definitivo do bloco deve ser mantido também em `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`, porque esta é a Page real no worktree atual.

## Revisão do resumo financeiro - Slice 3/4
- O widget real do resumo foi implementado como `ResumoPedido` dentro da feature `pedido_page`.
- O bloco visual foi integrado abaixo do recibo/produtos na composição da `PedidoPage`.
- `ResumoPedido` renderiza o título `RESUMO`, os três campos financeiros e o destaque verde no saldo de entrega, sem usar `resumo.png` como imagem final.
- O campo `Valor Entrada` é editável quando recebe callback da Page/ViewModel e exibe a mensagem de validação vinda do estado.
- A responsividade do bloco é documentada no contrato real da `PedidoPage`.

## Revisão do resumo financeiro - Slice 4/4
- A implementação final do resumo financeiro ficou na `PedidoPage`, que é a tela real do app no worktree atual.
- Não foi criada `ReciboPage`, rota própria ou ViewModel paralela para este escopo.
- `ResumoPedido` está abaixo de `ReciboPedido` no `PedidoPageLayout` e consome a mesma `PedidoPageViewModel` usada pelo formulário/tabela.
- O resumo calcula indiretamente por domínio e ViewModel; o widget visual não recalcula total nem saldo.
- Os testes finais passaram com `flutter analyze` e `flutter test`.
- Pendência real mantida: confirmar em ciclo futuro se o valor de entrada deve ser editável em dois pontos da tela ou somente no resumo financeiro.
