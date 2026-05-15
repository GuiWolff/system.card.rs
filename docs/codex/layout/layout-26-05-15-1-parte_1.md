# Contexto
Você é um desenvolvedor Senior em Dart / Flutter.
Leia a análise da tarefa e o resumo do slice anterior, se houver.
Este é o slice 1/5 derivado de `docs/codex/layout/layout-26-05-15-1.md`.

## Análise da tarefa
- `docs/codex/layout/layout-26-05-15-1-analise.md`

## Continuidade
- Este é o primeiro slice. Não há resumo anterior.

## Arquivos
- `lib/main.dart`
- `lib/utils/tema.dart`
- `test/widget_test.dart`
- `test/features/pedido_page/presentation/pages/pedido_page_test.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`

## Contratos de tela
- Ler antes de alterar:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Atualizar ou revisar neste slice:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Não criar novo contrato de tela.

## Regras
- Usar as imagens em `lib/resources/*` como referência de paleta e linguagem visual.
- Alinhar a paleta principal do tema à identidade:
  - `primaria`: laranja da marca, próximo de `#f7900a`;
  - `destaque`: azul de seções/títulos, próximo de `#0c78ce`;
  - `green`: verde para sucesso, ações positivas e valores favoráveis.
- Preservar suporte claro/escuro já previsto em `TemaApp`.
- Conectar `MaterialApp` ao tema customizado existente, preferindo `TemaApp.temaClaro()` e `TemaApp.temaEscuro()` se isso bastar.
- Não introduzir injeção global nova se o projeto ainda não usa esse padrão em `main.dart`.
- Evitar espalhar hexadecimais em widgets. Este slice deve concentrar tokens no tema.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não misture etapas de outros slices.
- Não execute automaticamente o próximo slice.
- Não faça commit.
- Não alterar ViewModel, repositories ou serviços neste slice.
- Não modificar layout interno de cabeçalho, formulário, tabela, resumo ou visualização neste slice, salvo ajustes mínimos exigidos pelo tema.

## Entregáveis
1. `TemaApp`/`TemaCores` alinhados à paleta visual das referências.
2. `main.dart` usando o tema customizado do projeto.
3. Testes ajustados apenas quando a troca de tema afetar o ambiente de renderização.
4. Atualizar ou revisar `pedido_page-contrato.md` com a decisão de tema.
5. Registrar no resumo do slice quais contratos de tela foram atualizados ou revisados.
6. Rodar validações específicas.
7. Salvar resumo em `docs/codex/layout/layout-26-05-15-1-parte_1-resumo.md`.

# Descrição
- Este slice cria a base visual para os demais: tema, cor, contraste, tipografia e conexão do app ao tema correto.
- A intenção é que os próximos slices consigam usar `Theme.of(context)` e estilos semânticos sem repetir decisões de cor.

## Objetivo
- Ao final deste slice, o app deve estar usando a identidade visual centralizada no tema, sem mudança funcional nos fluxos de pedido/recibo.

## Validações
- `flutter analyze`
- `flutter test test/widget_test.dart`
- `flutter test test/features/pedido_page/presentation/pages/pedido_page_test.dart`
