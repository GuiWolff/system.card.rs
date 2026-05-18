# Contexto
Você é um desenvolvedor Senior em Dart / Flutter.
Leia a análise da tarefa e o resumo do slice anterior, se houver.
Este é o slice 1/4 derivado de `docs/codex/recibo/recibo-26-05-15-2.md`.

## Análise da tarefa
- `docs/codex/recibo/recibo-26-05-15-2-analise.md`

## Continuidade
- Este é o primeiro slice; não há resumo anterior.

## Arquivos
- `pubspec.yaml`
- `pubspec.lock`
- `lib/features/pedido_page/pedido_page.dart`
- `lib/features/pedido_page/domain/models/recibo.dart`
- `lib/features/pedido_page/domain/models/item_recibo.dart`
- `lib/features/pedido_page/domain/models/resumo_recibo.dart`
- `lib/features/pedido_page/domain/models/cabecalho_empresa.dart`
- Novo arquivo sugerido: `lib/features/pedido_page/services/recibo_pdf_service.dart`
- Teste sugerido: `test/features/pedido_page/services/recibo_pdf_service_test.dart`

## Contratos de tela
- Contrato existente que deve ser lido antes da alteração:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Este slice não altera UI diretamente.
- Como não há alteração de Page/View/Tela neste slice, não há contrato de tela a criar ou atualizar.
- Se durante a implementação o slice alterar UI, atualizar `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md` no mesmo slice.

## Regras
- Adicionar apenas dependências necessárias para geração de PDF.
- Preferir dependências consolidadas do ecossistema Flutter/Dart para PDF.
- Criar serviço dentro da feature real `pedido_page`, preferencialmente em `lib/features/pedido_page/services/`.
- O serviço deve gerar PDF em A4.
- O serviço deve receber dados prontos de domínio, como `Recibo` e `CabecalhoEmpresa`.
- O serviço não deve acessar `BuildContext`, widgets, SQLite, repository ou controllers de texto.
- Valores monetários devem continuar vindo do domínio em centavos inteiros.
- O PDF deve formatar valores e datas apenas para exibição.
- Acentuação deve ser preservada.
- O PDF deve ter fallback visual para logo ausente ou inválida.
- Não conectar ainda o serviço aos botões de UI.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não misture etapas de outros slices.
- Não execute automaticamente o próximo slice.
- Não faça commit.
- Não criar `ReciboPage`.
- Não alterar APIs públicas sem necessidade.
- Não remover os estados preparatórios atuais de impressão/PDF sem que os slices seguintes substituam o fluxo com segurança.

## Entregáveis
1. Dependência de geração de PDF adicionada e resolvida.
2. Serviço de PDF A4 criado dentro de `lib/features/pedido_page/`.
3. Serviço exportado pelo barrel `lib/features/pedido_page/pedido_page.dart`, se isso seguir o padrão atual do projeto.
4. Testes cobrindo geração básica do PDF, retorno de bytes não vazios, tamanho A4 e dados essenciais do recibo.
5. Justificar explicitamente no resumo do slice que não houve impacto em UI, salvo se algum widget for alterado.
6. Rodar validações específicas.
7. Salvar resumo em `docs/codex/recibo/recibo-26-05-15-2-parte_1-resumo.md`.

# Descrição
- Criar a base técnica de geração do documento PDF do recibo no formato A4.
- Esta etapa deve preparar o documento para ser reutilizado nos próximos slices por visualização, impressão, compartilhamento e salvamento.

## Objetivo
- Ao final deste slice, o projeto deve possuir uma forma testável e isolada de gerar o PDF A4 do recibo atual, sem ainda alterar o comportamento dos botões da tela.
