# Contexto
Você é um desenvolvedor Senior em Dart / Flutter.
Leia a análise da tarefa e o resumo do slice anterior, se houver.
Este é o slice 5/9 derivado de `docs/codex/recibo/recibo-26-05-14-1.md`.

## Análise da tarefa
- `docs/codex/recibo/recibo-26-05-14-1-analise.md`

## Continuidade
- Slice anterior: `docs/codex/recibo/recibo-26-05-14-1-parte_4-resumo.md`

## Arquivos
- `lib/features/recibo/presentation/viewmodels/recibo_page_view_model.dart`
- `lib/features/recibo/domain/models/recibo.dart`
- `lib/features/recibo/domain/models/item_recibo.dart`
- `lib/features/recibo/domain/repositories/recibo_repository.dart`
- `lib/features/recibo/presentation/pages/recibo_page.dart`
- `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- `test/features/recibo/presentation/viewmodels/recibo_page_view_model_test.dart`

## Contratos de tela
- Contrato relacionado:
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- Contratos existentes que devem ser lidos antes da alteração:
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- Contratos que este slice deve criar, atualizar ou revisar:
  - Atualizar o contrato com estados da tela, fluxos de salvar/carregar e regras de cálculo.

## Protocolo do orquestrador
- Iniciar este slice em uma sessão limpa na raiz do projeto.
- Ler o resumo do slice 4 antes de qualquer alteração.
- Executar somente as atividades deste arquivo.
- Ao finalizar, criar `docs/codex/recibo/recibo-26-05-14-1-parte_5-resumo.md`.
- Parar após criar o resumo. O orquestrador deve encerrar a sessão e limpar o contexto antes do slice 6.

## Regras
- Criar `ReciboPageViewModel` sem acesso a `BuildContext`.
- Se `lib/observable/` existir neste momento, preferir o estado reativo do projeto. Se não existir, usar padrão simples e local como `ChangeNotifier`/`ValueNotifier`, sem criar infraestrutura global desnecessária.
- Estados mínimos:
  - recibo em edição;
  - lista de itens;
  - resumo calculado;
  - valor de entrada;
  - histórico carregado;
  - carregando;
  - salvando;
  - erro;
  - recibo atual salvo ou não salvo.
- Comandos mínimos:
  - iniciar novo recibo;
  - atualizar campos;
  - adicionar item;
  - remover item;
  - atualizar item;
  - limpar itens;
  - salvar;
  - carregar recibo;
  - listar/pesquisar histórico;
  - excluir recibo.
- A visualização futura deve consumir o mesmo estado do formulário.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não misture etapas de outros slices.
- Não implemente formulário completo neste slice.
- Não implemente visualização final neste slice.
- Não execute automaticamente o próximo slice.
- Não faça commit.

## Entregáveis
1. `ReciboPageViewModel` criado.
2. Integração mínima da `ReciboPage` com ViewModel, se necessária para manter compilação.
3. Testes de estado, cálculo e fluxo com repository fake.
4. Contrato de tela atualizado.
5. Validações executadas.
6. Resumo salvo em `docs/codex/recibo/recibo-26-05-14-1-parte_5-resumo.md`.

# Descrição
- Criar a camada de estado da tela, isolando UI de domínio e persistência.

## Objetivo
- Ao final deste slice, a tela deve ter uma ViewModel testável pronta para alimentar o formulário, o resumo, a visualização e o histórico.
