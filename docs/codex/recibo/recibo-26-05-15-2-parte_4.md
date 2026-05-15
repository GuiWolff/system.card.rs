# Contexto
Você é um desenvolvedor Senior em Dart / Flutter.
Leia a análise da tarefa e o resumo do slice anterior, se houver.
Este é o slice 4/4 derivado de `docs/codex/recibo/recibo-26-05-15-2.md`.

## Análise da tarefa
- `docs/codex/recibo/recibo-26-05-15-2-analise.md`

## Continuidade
- Slice anterior: `docs/codex/recibo/recibo-26-05-15-2-parte_3-resumo.md`
- Antes de executar, confirme que geração, prévia e impressão já usam a mesma base de PDF A4.

## Arquivos
- `pubspec.yaml`
- `pubspec.lock`
- `lib/features/pedido_page/presentation/pages/pedido_page.dart`
- `lib/features/pedido_page/presentation/viewmodels/pedido_page_view_model.dart`
- `lib/features/pedido_page/presentation/widgets/recibo_pedido.dart`
- `lib/features/pedido_page/services/recibo_pdf_service.dart`
- Novo arquivo sugerido: `lib/features/pedido_page/services/recibo_compartilhamento_service.dart`
- Novo arquivo sugerido: `lib/features/pedido_page/presentation/widgets/recibo_compartilhamento_dialog.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- `test/features/pedido_page/presentation/pages/pedido_page_test.dart`
- `test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`
- Testes específicos do serviço de compartilhamento/salvamento, quando viável.

## Contratos de tela
- Contrato existente que deve ser lido antes da alteração:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Contrato que este slice deve atualizar:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Registrar no contrato:
  - popup de compartilhamento;
  - opções de e-mail, WhatsApp e salvar arquivo;
  - limitações/fallbacks por plataforma;
  - estados de sucesso, cancelamento e erro.

## Regras
- Criar uma ação visível de compartilhamento no fluxo do recibo, sem remover ações existentes.
- Ao acionar compartilhamento, abrir popup com opções claras.
- As opções mínimas são:
  - `E-mail`;
  - `WhatsApp`;
  - `Salvar arquivo`.
- Todas as opções devem reutilizar o PDF A4 gerado pelo mesmo serviço/base dos slices anteriores.
- Para e-mail e WhatsApp, usar a melhor integração compatível com Flutter e registrar fallback quando a plataforma não permitir direcionar aplicativo específico.
- Para salvar arquivo, permitir escolha de caminho no desktop usando o seletor já disponível no projeto ou dependência adequada.
- Evitar uso incondicional de `dart:io` em código executado na Web.
- Se o usuário cancelar o seletor de arquivo ou compartilhamento, tratar como cancelamento, não como erro.
- O nome do arquivo deve ser previsível, por exemplo `recibo-[numero].pdf`, sanitizando caracteres inválidos.
- Preservar validação do recibo antes de gerar/compartilhar.
- Atualizar o contrato da `PedidoPage` e criar resumo final do slice.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não misture etapas de outros slices.
- Não execute automaticamente nenhum próximo slice.
- Não faça commit.
- Não criar `ReciboPage`, rota própria ou `Scaffold` novo.
- Não duplicar código de geração de PDF.
- Não prometer envio direto por WhatsApp/e-mail se a API usada abrir apenas a folha de compartilhamento do sistema.

## Entregáveis
1. Popup de compartilhamento criado e conectado.
2. Opções de e-mail, WhatsApp e salvar arquivo implementadas com fallbacks claros.
3. Salvamento com escolha de caminho implementado onde a plataforma permitir.
4. Estados de sucesso, erro e cancelamento tratados.
5. `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md` atualizado.
6. Testes de widget cobrindo abertura do popup e seleção das opções com fakes quando necessário.
7. Registrar no resumo do slice quais contratos de tela foram atualizados.
8. Rodar validações específicas e fechamento amplo.
9. Salvar resumo em `docs/codex/recibo/recibo-26-05-15-2-parte_4-resumo.md`.

# Descrição
- Implementar a etapa final do fluxo de documento: compartilhar o PDF por canais disponíveis e salvar em arquivo com caminho escolhido.

## Objetivo
- Ao final deste slice, o usuário deve conseguir abrir um popup de compartilhamento e escolher entre e-mail, WhatsApp ou salvar o PDF em um caminho escolhido, usando o mesmo PDF A4 já validado nos slices anteriores.
