# Contexto
Você é um desenvolvedor sênior em Dart/Flutter.
Leia a análise da tarefa e o resumo do slice anterior.
Este é o slice 3/7 derivado de `.codex/layout/layout-26-05-18-1.md`.

## Análise da tarefa
- `.codex/layout/layout-26-05-18-1-analise.md`

## Regras e skills aplicáveis
- Leia `AGENTS.md`.
- Leia `.codex/rules/RULE.md`.
- Leia as skills e referências listadas na análise antes de alterar código.
- Use `.codex/skills/argo-flutter-dev/SKILL.md`.
- Use `.codex/skills/argo-flutter-dev/references/tema.md`.
- Se houver conflito entre este slice e uma regra ou skill aplicável, pare e reporte o bloqueio.

## Continuidade
- Slice anterior: `.codex/layout/layout-26-05-18-1-parte_2-resumo.md`.
- Leia os resumos anteriores e preserve tema e shell já aplicados.

## Arquivos
- `lib/features/pedido_page/presentation/widgets/cabecalho_app.dart`.
- `lib/features/pedido_page/presentation/widgets/cabecalho_editor_dialog.dart`.
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`.
- `test/features/pedido_page/presentation/widgets/cabecalho_app_test.dart`.
- `test/features/pedido_page/presentation/pages/pedido_page_test.dart`.

## Contratos de tela
- Ler antes da alteração:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`.
- Atualizar neste slice:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`.
- Não criar contrato novo; `CabecalhoApp` e `CabecalhoEditorDialog` são partes da `PedidoPage`.

## Regras
- Modernizar cabeçalho e editor com visual empresarial compacto.
- Preservar dados, callbacks, persistência de cabeçalho, logo, feedback e responsividade.
- `FaIcon` só pode ser usado para:
  - `FontAwesomeIcons.instagram`;
  - `FontAwesomeIcons.whatsapp`.
- Migrar todos os demais ícones do cabeçalho e editor para `Icon` com `Icons.*`.
- Atualizar testes para procurar `FaIcon` somente em Instagram/WhatsApp e `Icon` nos demais casos.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não misture etapas de outros slices.
- Não execute automaticamente o próximo slice.
- Não faça commit automaticamente.
- Não alterar ViewModel, repository, PDF, impressão, compartilhamento ou SQLite.
- Não remover assets SVG ou `font_awesome_flutter`.

## Entregáveis
1. `CabecalhoApp` modernizado e com regra de ícones correta.
2. `CabecalhoEditorDialog` modernizado e com regra de ícones correta.
3. Testes do cabeçalho atualizados.
4. Contrato `pedido_page-contrato.md` atualizado.
5. Registrar no resumo do slice quais contratos de tela foram atualizados.
6. Rodar validações específicas conforme a skill aplicável.
7. Salvar resumo em `.codex/layout/layout-26-05-18-1-parte_3-resumo.md`.

# Descrição
- Este slice trabalha somente na identificação da empresa e no diálogo de edição do cabeçalho, que são a primeira leitura visual do app.

## Objetivo
- Ao final deste slice, cabeçalho e editor devem ter aparência mais atual e usar `FaIcon` exclusivamente para as marcas WhatsApp e Instagram.
