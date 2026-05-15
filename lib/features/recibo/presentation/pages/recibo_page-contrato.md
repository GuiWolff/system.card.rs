# Contrato de tela: ReciboPage

## Nome da tela
- `ReciboPage`

## Objetivo da tela
- Servir como tela principal do app de recibos da System Card - RS.
- Exibir um cabeçalho responsivo com identidade da empresa, contatos e ações principais.
- Futuramente, acomodar os campos do recibo, lista de produtos/serviços, resumo financeiro e visualização do recibo conforme `lib/resources/tema.jpeg`.

## Estado atual da tela
- A tela ainda não existe no código atual.
- O app ainda inicia no template padrão Flutter com contador em `lib/main.dart`.
- Este contrato foi criado antecipadamente para orientar a implementação incremental da tela.

## Estado esperado após a tarefa
- A tela deve existir em `lib/features/recibo/presentation/pages/recibo_page.dart`.
- O topo da tela deve renderizar um cabeçalho responsivo inspirado em `lib/resources/cabecalho.png`.
- O cabeçalho deve ser composto por widgets Flutter, não por uma imagem única.
- A tela deve ser preparada para receber os demais blocos do recibo sem quebrar o layout do cabeçalho.

## Estados visuais possíveis
- Desktop/largura ampla:
  - logomarca, nome e subtítulo à esquerda;
  - contatos no centro;
  - botões de ação à direita.
- Tablet/largura intermediária:
  - identidade preservada;
  - contatos e ações podem quebrar linha de forma controlada.
- Mobile/largura estreita:
  - identidade, contatos e ações empilhados;
  - endereço pode quebrar linha;
  - botões devem manter área de toque adequada e não gerar overflow.
- Ações habilitadas:
  - botões disponíveis para toque/clique.
- Ações desabilitadas:
  - botões visualmente desabilitados quando a ação não estiver disponível.
- Ações em andamento:
  - estado visual de carregamento deve ser previsto quando impressão ou PDF forem assíncronos.
- Falha ou ausência de asset de logo:
  - a tela deve manter layout estável com fallback visual ou pendência documentada.

## Dados necessários para renderização
- Dados de identidade:
  - asset da logomarca;
  - nome da empresa: `SYSTEM CARD - RS`;
  - subtítulo: `Sistemas de Identificação`;
  - rótulo semântico da logomarca.
- Dados de contato:
  - Instagram: `@systemcards`;
  - WhatsApp: `51 998020198`;
  - telefone: `51 30551025`;
  - endereço: `Rua 20 de Setembro, 528 - Centro - Guaíba - RS`.
- Dados de ação:
  - ação `IMPRIMIR`;
  - ação `GERAR PDF`;
  - ação `MAIS OPÇÕES`;
  - estado habilitado/desabilitado;
  - estado de carregamento;
  - callbacks correspondentes.
- Dados de layout:
  - largura disponível;
  - espaçamentos por breakpoint;
  - tamanhos mínimo e máximo da logomarca;
  - regra de quebra dos contatos e botões.

## Ações do usuário disponíveis
- Acionar impressão.
- Gerar PDF.
- Abrir menu de mais opções.
- Futuramente, preencher dados do recibo e manipular produtos/serviços.

## Regras de interação
- A tela deve delegar ações para ViewModel ou callbacks, sem concentrar regra de negócio dentro do widget visual do cabeçalho.
- O cabeçalho deve permanecer acessível por mouse, toque e teclado quando aplicável.
- Botões devem ter rótulos claros e semântica adequada.
- O menu "MAIS OPÇÕES" deve abrir sem deslocar incoerentemente o restante do cabeçalho.
- Textos longos, especialmente o endereço, devem quebrar linha em vez de extrapolar a largura.

## Dependências da tela
- `MaterialApp` em `lib/main.dart`.
- Assets em `lib/resources/`.
- `ThemeData`/`ColorScheme` existente ou estrutura de tema que vier a ser criada.
- `ReciboPageViewModel`, se o estado da tela for centralizado em ViewModel.
- `CabecalhoApp` como widget de cabeçalho.

## Widgets principais
- `ReciboPage`
- `CabecalhoApp`
- Widget de identidade do cabeçalho.
- Widget de contatos do cabeçalho.
- Widget de ações do cabeçalho.
- Futuramente, seções de dados do recibo, produtos/serviços, resumo e visualização.

## ViewModel/Controller relacionado
- Esperado: `ReciboPageViewModel`.
- Responsabilidades prováveis:
  - expor dados padrão do cabeçalho;
  - controlar disponibilidade das ações;
  - receber comandos de imprimir, gerar PDF e abrir opções;
  - futuramente controlar dados do recibo.
- O ViewModel não deve acessar `BuildContext`.

## Pontos que cada slice precisa preservar
- Slice 1:
  - criar a tela base sem implementar funcionalidades fora do escopo;
  - manter arquitetura vertical feature-first.
- Slice 2:
  - centralizar dados do cabeçalho de forma testável;
  - não colocar regra visual no model.
- Slice 3:
  - manter o cabeçalho composto por widgets responsivos;
  - evitar usar o print como imagem final.
- Slice 4:
  - manter ações desacopladas por callbacks ou ViewModel;
  - não implementar PDF/impressão reais fora do escopo.
- Slice 5:
  - preservar responsividade, acessibilidade e testes;
  - registrar pendências reais.

## Pendências conhecidas
- Não há logo isolado disponível no estado atual do projeto.
- O tema customizado citado em documentos antigos não existe no worktree atual.
- As funcionalidades reais de impressão e PDF ainda não existem.
- Os campos do recibo e a visualização completa ainda não fazem parte desta tarefa.

## Continuidade esperada para os próximos slices
- Executar primeiro `docs/codex/cabecalho/cabecalho-26-05-14-1-parte_1.md`.
- Atualizar este contrato sempre que uma alteração de slice mudar estado visual, dados renderizados ou regras de interação da `ReciboPage`.
