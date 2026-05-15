# Contexto
Você é um desenvolvedor Senior em Dart / Flutter.
Leia a análise desta tarefa antes de executar qualquer alteração.
Esta tarefa foi dividida em 5 slices.

## Análise da tarefa
- `docs/codex/cabecalho/cabecalho-26-05-14-1-analise.md`

## Objetivo geral
- Implementar, em etapas pequenas, o cabeçalho responsivo da tela de recibo da System Card - RS, usando `lib/resources/cabecalho.png` e `lib/resources/tema.jpeg` como referências visuais.
- O cabeçalho deve ser composto por widgets Flutter, conter identidade, contatos e ações, e respeitar as diretrizes do `AGENTS.md`.

## Arquivos principais envolvidos
- Existentes:
  - `AGENTS.md`
  - `pubspec.yaml`
  - `lib/main.dart`
  - `test/widget_test.dart`
  - `lib/resources/cabecalho.png`
  - `lib/resources/tema.jpeg`
- Esperados durante a execução:
  - `lib/features/recibo/presentation/pages/recibo_page.dart`
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
  - `lib/features/recibo/presentation/widgets/cabecalho_app.dart`
  - `lib/features/recibo/presentation/viewmodels/recibo_page_view_model.dart`
  - `lib/features/recibo/domain/models/cabecalho_empresa.dart`
  - `test/features/recibo/presentation/widgets/cabecalho_app_test.dart`
  - `test/features/recibo/presentation/viewmodels/recibo_page_view_model_test.dart`

## Contratos de tela
- Contrato relacionado:
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- Contratos existentes que devem ser lidos antes da alteração:
  - Nenhum contrato pré-existente foi encontrado para `ReciboPage`.
- Contratos que cada slice deve criar, atualizar ou revisar:
  - Slice 1: ler e revisar `recibo_page-contrato.md` ao criar a tela base.
  - Slice 2: revisar `recibo_page-contrato.md` para manter os dados necessários do cabeçalho alinhados ao modelo.
  - Slice 3: atualizar `recibo_page-contrato.md` com comportamento visual e responsivo do cabeçalho.
  - Slice 4: atualizar `recibo_page-contrato.md` com estados e regras das ações do cabeçalho.
  - Slice 5: revisar `recibo_page-contrato.md` após validações finais.

## Slices da tarefa

### Slice 1/5 - Estrutura base da tela
Arquivo: `docs/codex/cabecalho/cabecalho-26-05-14-1-parte_1.md`
Resumo esperado: `docs/codex/cabecalho/cabecalho-26-05-14-1-parte_1-resumo.md`

Atividades:
1. Criar a estrutura vertical da feature `recibo`.
2. Criar `ReciboPage` mínima e substituir o contador do template como tela inicial.
3. Registrar assets necessários em `pubspec.yaml`.
4. Atualizar o teste inicial para validar que a tela real abre.
5. Revisar o contrato de tela.

Validações:
- `flutter analyze`
- `flutter test`

### Slice 2/5 - Dados do cabeçalho
Arquivo: `docs/codex/cabecalho/cabecalho-26-05-14-1-parte_2.md`
Resumo esperado: `docs/codex/cabecalho/cabecalho-26-05-14-1-parte_2-resumo.md`

Atividades:
1. Modelar os dados necessários do cabeçalho.
2. Criar ou ajustar ViewModel da tela para expor identidade, contatos e ações.
3. Adicionar testes para os dados padrão do cabeçalho.
4. Revisar o contrato com os dados renderizados.

Validações:
- `flutter analyze`
- `flutter test test/features/recibo/presentation/viewmodels/recibo_page_view_model_test.dart`

### Slice 3/5 - Widget visual responsivo
Arquivo: `docs/codex/cabecalho/cabecalho-26-05-14-1-parte_3.md`
Resumo esperado: `docs/codex/cabecalho/cabecalho-26-05-14-1-parte_3-resumo.md`

Atividades:
1. Criar `CabecalhoApp` como widget composto.
2. Implementar layout desktop, tablet e mobile sem renderizar o print como imagem única.
3. Integrar o cabeçalho à `ReciboPage`.
4. Criar testes de widget para conteúdo e ausência de overflow em larguras representativas.
5. Atualizar o contrato da tela.

Validações:
- `flutter analyze`
- `flutter test test/features/recibo/presentation/widgets/cabecalho_app_test.dart`

### Slice 4/5 - Ações do cabeçalho
Arquivo: `docs/codex/cabecalho/cabecalho-26-05-14-1-parte_4.md`
Resumo esperado: `docs/codex/cabecalho/cabecalho-26-05-14-1-parte_4-resumo.md`

Atividades:
1. Conectar os botões "IMPRIMIR", "GERAR PDF" e "MAIS OPÇÕES" a callbacks ou estado do ViewModel.
2. Implementar estados habilitado, desabilitado e feedback temporário sem criar fluxo completo de PDF/impressão fora do escopo.
3. Testar acionamento dos botões e menu.
4. Atualizar o contrato da tela com as regras de interação.

Validações:
- `flutter analyze`
- `flutter test test/features/recibo/presentation/widgets/cabecalho_app_test.dart`
- `flutter test`

### Slice 5/5 - Fechamento responsivo e validação
Arquivo: `docs/codex/cabecalho/cabecalho-26-05-14-1-parte_5.md`
Resumo esperado: `docs/codex/cabecalho/cabecalho-26-05-14-1-parte_5-resumo.md`

Atividades:
1. Revisar responsividade, acessibilidade, semântica e consistência visual.
2. Garantir que os testes do template antigo foram substituídos por testes coerentes com a nova tela.
3. Rodar validações finais.
4. Atualizar o contrato e o resumo final do fechamento.

Validações:
- `flutter analyze`
- `flutter test`

## Regras gerais
- Executar apenas um slice por vez.
- Nunca executar slices em paralelo.
- Nunca avançar para o próximo slice sem o resumo do slice atual.
- Se um resumo de slice já existir e estiver válido, não repetir esse slice.
- Cada slice deve considerar o estado atualizado do código produzido pelo slice anterior.
- Cada slice que alterar UI deve criar ou atualizar o respectivo `[nome-da-tela]-contrato.md`.
- Preservar alterações existentes no worktree.
- Não fazer commit automaticamente.
- Seguir `AGENTS.md`, mantendo português pt-BR, UTF-8 e arquitetura vertical feature-first.
- Não assumir que arquivos citados em documentos antigos existem no worktree atual. Verificar antes de importar ou depender deles.
- Não renderizar `cabecalho.png` como cabeçalho final inteiro. A imagem deve ser referência visual.

## Resultado esperado
- Ao final dos 5 slices, o app deve iniciar em uma tela de recibo com cabeçalho responsivo da System Card - RS.
- O cabeçalho deve exibir identidade, contatos e ações de forma acessível, testável e sem overflow.
- A implementação deve ter contrato de tela atualizado e validações registradas nos resumos dos slices.
