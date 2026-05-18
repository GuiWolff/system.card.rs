# Contexto
Você é um desenvolvedor sênior em Dart/Flutter.
Leia a análise da tarefa e o resumo do slice anterior, se houver.
Este é o slice 1/7 derivado de `.codex/layout/layout-26-05-18-1.md`.

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
- Este é o primeiro slice; não há resumo anterior.

## Arquivos
- `lib/utils/tema.dart`.
- `lib/main.dart`, somente se necessário.
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`.
- `test/widget_test.dart`.
- `test/features/pedido_page/presentation/pages/pedido_page_test.dart`.

## Contratos de tela
- Ler antes da alteração:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`.
- Atualizar neste slice:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`.
- Não criar contrato novo; a tela impactada continua sendo `PedidoPage`.

## Regras
- Modernizar o tema global com aparência de software empresarial de caixa, usando Material 3 e os padrões locais.
- Preservar cores semânticas e modo claro/escuro.
- Preferir ajustes em `TemaCores`, `TemaEstiloTexto`, `TemaMedidas` e temas de componentes já centralizados.
- Não alterar widgets da feature neste slice, salvo se um teste exigir adaptação mínima ao tema.
- Não adicionar pacote `fluent_ui`.
- Não remover dependências neste slice.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não misture etapas de outros slices.
- Não execute automaticamente o próximo slice.
- Não faça commit automaticamente.
- Não altere regra de negócio, ViewModel, repository, PDF, impressão, compartilhamento ou SQLite.

## Entregáveis
1. Tema global ajustado para superfícies, controles, bordas, densidade e tipografia mais compatíveis com uma aplicação de caixa empresarial moderna.
2. Contrato `pedido_page-contrato.md` atualizado com o resultado visual do slice.
3. Testes ajustados apenas se quebrarem por expectativa legítima de tema.
4. Registrar no resumo do slice quais contratos de tela foram atualizados.
5. Rodar validações específicas conforme a skill aplicável.
6. Salvar resumo em `.codex/layout/layout-26-05-18-1-parte_1-resumo.md`.

# Descrição
- Este slice cria a base visual compartilhada. O objetivo é preparar o app para que os próximos slices modernizem as áreas da tela sem repetir tokens de cor, raio, borda, sombra, texto e controle em cada widget.

## Objetivo
- Ao final deste slice, o tema deve oferecer uma base visual mais atual, densa e operacional, sem alterar o fluxo funcional da `PedidoPage`.
