# Tema, cores e mensagens

Use esta referência quando a alteração envolver UI visual, tema, cores, tipografia, contraste, superfícies ou mensagens de erro.

## Acesso padrão

```dart
final tema = Injecao.buscar<TemaApp>();
final cores = tema.cores;
final temaService = Injecao.buscar<TemaService>();
final textStyle = tema.estiloTexto;
```

## Regra principal

Escolha primeiro o contexto da superfície e depois a variação do texto.

- Fundo geral da tela: `tema.cores.backgroundPrimario`.
- Superfície destacada sobre o fundo principal: `tema.cores.backgroundSecundario`.
- Texto comum sobre fundo primário ou secundário: `tema.estiloTexto.bodyText.corTexto`.
- Texto sobre fundo de contraste primário: `tema.estiloTexto.bodyText.corContrastePrimaria`.
- Texto com hierarquia principal: `tema.estiloTexto.bodyText.primaria`.
- Texto com ênfase visual: `tema.estiloTexto.bodyText.corDestaque`.
- Ícones: `tema.cores.icons`.
- Sucesso e erro: `tema.cores.green` e `tema.cores.red`.

## Cores semânticas

- `primaria` (`#1C4779`): cor principal da identidade visual. Use em elementos principais, títulos, destaques institucionais e componentes que carregam a marca.
- `destaque` (`#F28C28`): cor de atenção visual. Use em números importantes, indicadores, badges, status e trechos de destaque.
- `contrastePrimaria`: cor para texto ou ícone sobre superfície forte ou primária.
- `textoComum`: cor base de leitura comum, adaptada ao tema claro ou escuro.
- `backgroundPrimario`: fundo base da tela.
- `backgroundSecundario`: superfície acima do fundo principal, como cards, containers e seções elevadas.
- `icons`: cor semântica padrão para ícones.
- `texto`: cor geral de leitura adaptada ao tema.
- `isDark`: indica modo escuro e influencia contraste, texto e fundos.
- `temaEscuroMedio`: ajusta a intensidade do fundo escuro.

## Estilos de texto

Os getters como `headlineBold`, `bodyText`, `buttonText`, `labelText` e `cardTitle` entregam a base tipográfica e variações de cor. Use a variação semântica em vez de criar `TextStyle` solto.

- `corTexto`: leitura normal em `backgroundPrimario` ou `backgroundSecundario`.
- `corContrastePrimaria`: leitura sobre fundo forte ou primário.
- `primaria`: hierarquia visual ligada à marca.
- `corDestaque`: ênfase visual sem trocar a base tipográfica.

## Mensagens de erro

- Use `ArgoSnackbar` para exibir mensagens de erro na UI.
- Não crie mecanismos paralelos de snackbar/toast sem necessidade.

## Evite

- `Colors.*` direto em widgets de negócio.
- Hexadecimais repetidos no widget.
- Contraste decidido manualmente em cada tela.
- Texto sobre superfície forte sem `corContrastePrimaria`.
- Variações visuais que ignorem modo escuro.
