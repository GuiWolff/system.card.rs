# Contexto
Você é um desenvolvedor sênior em Dart/Flutter.
Leia a análise da tarefa e o resumo do slice anterior.
Este é o slice 2/7 derivado de `.codex/layout/layout-26-05-18-1.md`.

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
- Slice anterior: `.codex/layout/layout-26-05-18-1-parte_1-resumo.md`.
- Leia o resumo anterior e preserve o tema já aplicado.

## Arquivos
- `lib/features/pedido_page/presentation/pages/pedido_page.dart`.
- `lib/features/pedido_page/presentation/widgets/pedido_page_layout.dart`.
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
- Modernizar a estrutura da `PedidoPage` como área de trabalho de caixa empresarial.
- Preservar `PedidoPage` como tela inicial do app.
- Preservar slots e widgets principais: cabeçalho, recibo e resumo.
- Melhorar responsividade sem alterar callbacks, ViewModel, serviços ou persistência.
- Evitar hero, layout de marketing, gradientes decorativos e cards aninhados.
- Se extrair widgets privados, manter responsabilidade pequena e dentro da feature.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não misture etapas de outros slices.
- Não execute automaticamente o próximo slice.
- Não faça commit automaticamente.
- Não migrar ícones neste slice, exceto se algum ícone estiver diretamente no shell da Page.
- Não alterar formulário, tabela, cabeçalho, visualização ou dialogs internos.

## Entregáveis
1. `PedidoPage` e `PedidoPageLayout` com shell visual mais moderno, denso e responsivo.
2. Contrato `pedido_page-contrato.md` atualizado com o resultado do shell.
3. Testes da Page atualizados quando necessário.
4. Registrar no resumo do slice quais contratos de tela foram atualizados.
5. Rodar validações específicas conforme a skill aplicável.
6. Salvar resumo em `.codex/layout/layout-26-05-18-1-parte_2-resumo.md`.

# Descrição
- Este slice cuida apenas da moldura de trabalho: fundo, largura, espaçamentos, organização das seções e leitura geral da tela principal.

## Objetivo
- Ao final deste slice, a `PedidoPage` deve parecer uma área de trabalho empresarial moderna, preservando os componentes internos para modernização nos slices seguintes.
