# Contexto
Você é um desenvolvedor Senior em Dart / Flutter.
Leia a análise da tarefa e o resumo do slice anterior, se houver.
Este é o slice 4/4 derivado de `docs/codex/layout/layout-26-05-15-2.md`.

## Análise da tarefa
- `docs/codex/layout/layout-26-05-15-2-analise.md`

## Continuidade
- Slice anterior: `docs/codex/layout/layout-26-05-15-2-parte_3-resumo.md`
- Antes de alterar, leia os resumos dos slices anteriores e preserve os ajustes já concluídos.

## Arquivos
- `lib/features/pedido_page/presentation/widgets/clientes_painel.dart`
- `lib/features/pedido_page/presentation/widgets/recibo_pedido.dart`
- `lib/features/pedido_page/presentation/widgets/recibo_compartilhamento_dialog.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page.dart`
- `lib/features/pedido_page/presentation/viewmodels/pedido_page_view_model.dart`
- `lib/features/pedido_page/services/recibo_compartilhamento_service.dart`
- `lib/features/pedido_page/pedido_page.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- `test/features/pedido_page/presentation/widgets/clientes_painel_test.dart`
- `test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`
- `test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`
- `test/features/pedido_page/presentation/pages/pedido_page_test.dart`
- `test/features/pedido_page/services/recibo_compartilhamento_service_test.dart`

## Contratos de tela
- Ler antes da alteração:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Atualizar neste slice:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Não criar novo contrato. O impacto visual continua na `PedidoPage`.

## Regras
- Adicionar campo `E-mail` ao cadastro de clientes no `ClientesPainel`.
- Manter estado local temporário via `TextEditingController`, seguindo o padrão atual do painel.
- Usar `TextInputType.emailAddress`, `Icons.email_outlined` ou ícone equivalente do tema para o campo de e-mail.
- Atualizar assinatura de `ClientesPainel.onCadastrar` para incluir e-mail de forma compatível com o slice 3.
- Exibir e-mail na lista de clientes quando preenchido, sem poluir visualmente quando vazio.
- Permitir pesquisa por e-mail usando repository/viewModel já preparados no slice 3.
- Ao selecionar cliente, preservar nome, telefone e e-mail no estado necessário para compartilhamento.
- Integrar o e-mail cadastrado ao fluxo de compartilhamento por e-mail quando a API permitir:
  - se a solução continuar usando `share_plus` e folha do sistema, registrar que não há garantia de destinatário obrigatório;
  - se usar `mailto`, não prometer anexo PDF quando a plataforma não suportar;
  - o PDF gerado deve continuar sendo o mesmo arquivo A4 já usado por prévia, impressão e salvamento.
- Não remover a opção `E-mail` atual do popup de compartilhamento.
- Atualizar feedbacks/testes para deixar claro quando o compartilhamento por e-mail usa fallback do sistema.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não misture etapas de outros slices.
- Não alterar schema SQLite neste slice; isso pertence ao slice 3.
- Não executar automaticamente nenhum novo slice.
- Não faça commit.

## Entregáveis
1. `ClientesPainel` com campo de e-mail.
2. Lista/pesquisa/seleção de cliente considerando e-mail.
3. Compartilhamento por e-mail usando o e-mail cadastrado quando tecnicamente viável, com fallback documentado.
4. Testes de widget, ViewModel, Page e service atualizados.
5. Barrel público atualizado, se algum tipo novo precisar ser exportado.
6. Contrato `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md` atualizado.
7. Rodar validações específicas e `flutter test` no fechamento.
8. Salvar resumo em `docs/codex/layout/layout-26-05-15-2-parte_4-resumo.md`.

# Descrição
- Este slice expõe o e-mail no cadastro visual de clientes e conecta o dado ao fluxo de compartilhamento, respeitando limitações reais das APIs de plataforma.

## Objetivo
- Ao final deste slice, o usuário deve conseguir cadastrar e-mail no cliente e usar essa informação no fluxo de compartilhamento por e-mail, sem quebrar os fluxos existentes de PDF, WhatsApp e salvamento.
