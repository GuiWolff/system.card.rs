import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TemaApp {
  const TemaApp({this.isDark = false, this.temaEscuroMedio = true});

  final bool isDark;
  final bool temaEscuroMedio;

  TemaCores get cores =>
      TemaCores(isDark: isDark, temaEscuroMedio: temaEscuroMedio);

  TemaEstiloTexto get estiloTexto => TemaEstiloTexto(cores);

  ThemeData get themeData => _criarThemeData();

  static ThemeData temaClaro() => const TemaApp().themeData;

  static ThemeData temaEscuro({bool temaEscuroMedio = true}) =>
      TemaApp(isDark: true, temaEscuroMedio: temaEscuroMedio).themeData;

  ThemeData _criarThemeData() {
    final temaCores = cores;
    final brightness = isDark ? Brightness.dark : Brightness.light;
    final colorScheme =
        ColorScheme.fromSeed(
          seedColor: temaCores.primaria,
          brightness: brightness,
        ).copyWith(
          primary: temaCores.primaria,
          onPrimary: temaCores.contrastePrimaria,
          primaryContainer: temaCores.containerPrimario,
          onPrimaryContainer: temaCores.textoPrimarioContainer,
          secondary: temaCores.destaque,
          onSecondary: temaCores.contrasteDestaque,
          secondaryContainer: temaCores.containerDestaque,
          onSecondaryContainer: temaCores.textoDestaqueContainer,
          tertiary: temaCores.green,
          onTertiary: temaCores.contrasteSucesso,
          tertiaryContainer: temaCores.containerSucesso,
          onTertiaryContainer: temaCores.textoSucessoContainer,
          surface: temaCores.backgroundSecundario,
          onSurface: temaCores.texto,
          surfaceContainerLowest: temaCores.backgroundPrimario,
          surfaceContainerLow: temaCores.surfaceBaixa,
          surfaceContainer: temaCores.backgroundSecundario,
          surfaceContainerHigh: temaCores.surfaceAlta,
          surfaceContainerHighest: temaCores.surfaceMaisAlta,
          outline: temaCores.outline,
          outlineVariant: temaCores.borda,
          shadow: temaCores.sombraBase,
          error: temaCores.red,
          onError: temaCores.contrasteErro,
        );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      shadowColor: temaCores.sombraBase,
      scaffoldBackgroundColor: temaCores.backgroundPrimario,
      fontFamily: TemaTipografia.familiaFonte,
      fontFamilyFallback: TemaTipografia.familiasReserva,
      textTheme: estiloTexto.materialTextTheme,
      visualDensity: VisualDensity.compact,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      hoverColor: temaCores.hover,
      focusColor: temaCores.foco,
      highlightColor: temaCores.pressionado,
      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: temaCores.backgroundSecundario,
        foregroundColor: temaCores.texto,
        titleTextStyle: estiloTexto.titleBold.corTexto,
      ),
      cardTheme: CardThemeData(
        color: temaCores.backgroundSecundario,
        elevation: 0,
        margin: EdgeInsets.zero,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(TemaMedidas.raioCard),
          side: BorderSide(color: temaCores.borda),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: temaCores.borda,
        thickness: 1,
        space: 1,
      ),
      iconTheme: IconThemeData(color: temaCores.icons, size: 20),
      inputDecorationTheme: _inputDecorationTheme(temaCores),
      filledButtonTheme: _filledButtonTheme(temaCores),
      outlinedButtonTheme: _outlinedButtonTheme(temaCores),
      textButtonTheme: _textButtonTheme(temaCores),
      checkboxTheme: _checkboxTheme(temaCores),
      dialogTheme: _dialogTheme(temaCores),
      popupMenuTheme: _popupMenuTheme(temaCores),
      menuTheme: _menuTheme(temaCores),
      listTileTheme: _listTileTheme(temaCores),
      chipTheme: _chipTheme(temaCores),
      dataTableTheme: _dataTableTheme(temaCores),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: isDark ? TemaCores.neutro900 : TemaCores.verdeProfundo,
        contentTextStyle: estiloTexto.bodyText.base.copyWith(
          color: TemaCores.conteudoSobreDestaque,
        ),
        behavior: SnackBarBehavior.floating,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(TemaMedidas.raioControle),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: temaCores.destaque,
        linearTrackColor: temaCores.surfaceBaixa,
      ),
    );
  }

  InputDecorationTheme _inputDecorationTheme(TemaCores temaCores) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(TemaMedidas.raioControle),
      borderSide: BorderSide(color: temaCores.borda),
    );

    return InputDecorationTheme(
      filled: true,
      fillColor: temaCores.campo,
      hintStyle: estiloTexto.bodyText.base.copyWith(
        color: temaCores.textoSutil,
      ),
      labelStyle: estiloTexto.labelText.corTexto,
      prefixIconColor: temaCores.icons,
      suffixIconColor: temaCores.icons,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      constraints: const BoxConstraints(minHeight: TemaMedidas.alturaControle),
      border: border,
      enabledBorder: border,
      focusedBorder: border.copyWith(
        borderSide: BorderSide(color: temaCores.primaria, width: 1.4),
      ),
      errorBorder: border.copyWith(
        borderSide: BorderSide(color: temaCores.red, width: 1.2),
      ),
      focusedErrorBorder: border.copyWith(
        borderSide: BorderSide(color: temaCores.red, width: 1.4),
      ),
    );
  }

  FilledButtonThemeData _filledButtonTheme(TemaCores temaCores) {
    return FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size(
          TemaMedidas.larguraMinimaControle,
          TemaMedidas.alturaControle,
        ),
        backgroundColor: temaCores.primaria,
        disabledBackgroundColor: temaCores.primaria.withValues(alpha: 0.42),
        foregroundColor: temaCores.contrastePrimaria,
        disabledForegroundColor: temaCores.contrastePrimaria.withValues(
          alpha: 0.72,
        ),
        padding: TemaMedidas.paddingControle,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.compact,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(TemaMedidas.raioControle),
        ),
        textStyle: estiloTexto.buttonText.base,
      ),
    );
  }

  OutlinedButtonThemeData _outlinedButtonTheme(TemaCores temaCores) {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(
          TemaMedidas.larguraMinimaControle,
          TemaMedidas.alturaControle,
        ),
        backgroundColor: temaCores.backgroundSecundario,
        foregroundColor: temaCores.texto,
        disabledForegroundColor: temaCores.textoSutil,
        side: BorderSide(color: temaCores.outline),
        padding: TemaMedidas.paddingControle,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.compact,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(TemaMedidas.raioControle),
        ),
        textStyle: estiloTexto.buttonText.base,
      ),
    );
  }

  TextButtonThemeData _textButtonTheme(TemaCores temaCores) {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: temaCores.primaria,
        disabledForegroundColor: temaCores.textoSutil,
        padding: TemaMedidas.paddingControleCompacto,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.compact,
        textStyle: estiloTexto.labelText.base,
      ),
    );
  }

  CheckboxThemeData _checkboxTheme(TemaCores temaCores) {
    return CheckboxThemeData(
      checkColor: WidgetStateProperty.all(temaCores.contrastePrimaria),
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return temaCores.textoSutil.withValues(alpha: 0.36);
        }

        if (states.contains(WidgetState.selected)) {
          return temaCores.primaria;
        }

        return Colors.transparent;
      }),
      side: BorderSide(color: temaCores.outline),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(TemaMedidas.raioCheckbox),
      ),
    );
  }

  DialogThemeData _dialogTheme(TemaCores temaCores) {
    return DialogThemeData(
      backgroundColor: temaCores.backgroundSecundario,
      surfaceTintColor: Colors.transparent,
      elevation: 8,
      shadowColor: temaCores.sombra,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(TemaMedidas.raioPainel),
        side: BorderSide(color: temaCores.borda),
      ),
      titleTextStyle: estiloTexto.titleBold.corTexto,
      contentTextStyle: estiloTexto.bodyText.corTexto,
    );
  }

  PopupMenuThemeData _popupMenuTheme(TemaCores temaCores) {
    return PopupMenuThemeData(
      color: temaCores.backgroundSecundario,
      surfaceTintColor: Colors.transparent,
      elevation: 6,
      shadowColor: temaCores.sombra,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(TemaMedidas.raioControle),
        side: BorderSide(color: temaCores.borda),
      ),
      textStyle: estiloTexto.bodyText.corTexto,
    );
  }

  MenuThemeData _menuTheme(TemaCores temaCores) {
    return MenuThemeData(
      style: MenuStyle(
        backgroundColor: WidgetStateProperty.all(
          temaCores.backgroundSecundario,
        ),
        surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
        elevation: WidgetStateProperty.all(4),
        shadowColor: WidgetStateProperty.all(temaCores.sombra),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(TemaMedidas.raioControle),
            side: BorderSide(color: temaCores.borda),
          ),
        ),
      ),
    );
  }

  ListTileThemeData _listTileTheme(TemaCores temaCores) {
    return ListTileThemeData(
      dense: true,
      minVerticalPadding: 8,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      iconColor: temaCores.icons,
      textColor: temaCores.texto,
      selectedColor: temaCores.primaria,
      selectedTileColor: temaCores.containerPrimario,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(TemaMedidas.raioControle),
      ),
    );
  }

  ChipThemeData _chipTheme(TemaCores temaCores) {
    return ChipThemeData(
      backgroundColor: temaCores.surfaceBaixa,
      selectedColor: temaCores.containerPrimario,
      disabledColor: temaCores.surfaceBaixa.withValues(alpha: 0.64),
      side: BorderSide(color: temaCores.borda),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(TemaMedidas.raioControle),
      ),
      labelStyle: estiloTexto.labelText.corTexto,
      secondaryLabelStyle: estiloTexto.labelText.primaria,
      iconTheme: IconThemeData(color: temaCores.icons, size: 18),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    );
  }

  DataTableThemeData _dataTableTheme(TemaCores temaCores) {
    return DataTableThemeData(
      headingRowColor: WidgetStateProperty.all(temaCores.surfaceBaixa),
      dataRowColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.hovered)) {
          return temaCores.hover;
        }

        return Colors.transparent;
      }),
      dividerThickness: 1,
      headingTextStyle: estiloTexto.labelText.corTexto,
      dataTextStyle: estiloTexto.bodyText.corTexto,
      decoration: BoxDecoration(
        border: Border.all(color: temaCores.borda),
        borderRadius: BorderRadius.circular(TemaMedidas.raioCard),
      ),
    );
  }
}

class TemaService extends ChangeNotifier {
  TemaService({
    bool isDark = false,
    this.temaEscuroMedio = true,
    SharedPreferences? preferencias,
  }) : _isDark = isDark,
       _preferencias = preferencias;

  static const _chaveTemaEscuro = 'tema_escuro';

  bool _isDark;
  bool temaEscuroMedio;
  final SharedPreferences? _preferencias;

  static Future<TemaService> carregar() async {
    final preferencias = await SharedPreferences.getInstance();
    final brilhoSistema =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
    final temaEscuro =
        preferencias.getBool(_chaveTemaEscuro) ??
        (brilhoSistema == Brightness.dark);

    return TemaService(isDark: temaEscuro, preferencias: preferencias);
  }

  bool get isDark => _isDark;

  ThemeMode get themeMode => _isDark ? ThemeMode.dark : ThemeMode.light;

  TemaApp get tema =>
      TemaApp(isDark: _isDark, temaEscuroMedio: temaEscuroMedio);

  void alternarTema() => definirTemaEscuro(!_isDark);

  void definirTemaEscuro(bool valor) {
    if (_isDark == valor) return;

    _isDark = valor;
    notifyListeners();
    _salvarTemaEscuro(valor);
  }

  void definirEscuroMedio(bool valor) {
    if (temaEscuroMedio == valor) return;

    temaEscuroMedio = valor;
    notifyListeners();
  }

  void _salvarTemaEscuro(bool valor) {
    final preferencias = _preferencias;
    if (preferencias == null) return;

    unawaited(preferencias.setBool(_chaveTemaEscuro, valor));
  }
}

class TemaCores {
  const TemaCores({this.isDark = false, this.temaEscuroMedio = true});

  static const azulPrimario = Color(0xFF1C4779);
  static const azulPrimarioEscuro = Color(0xFF93C5FD);
  static const azulAcao = Color(0xFF235A96);
  static const azulAcaoEscuro = Color(0xFFBFDBFE);
  static const laranjaDestaque = Color(0xFFF28C28);
  static const laranjaDestaqueEscuro = Color(0xFFFDBA74);
  static const verdeDestaque = Color(0xFF168A4A);
  static const verdeEnergia = Color(0xFF45D483);
  static const verdeProfundo = Color(0xFF103B2B);
  static const verdeSuperficie = Color(0xFF173D2E);
  static const conteudoSobrePrimaria = Color(0xFFFFFFFF);
  static const conteudoSobrePrimariaEscura = Color(0xFF071A2F);
  static const conteudoSobreDestaque = Color(0xFFFFFFFF);
  static const conteudoSobreDestaqueEscura = Color(0xFF3A1D04);
  static const neutro950 = Color(0xFF08111F);
  static const neutro900 = Color(0xFF0F1B2A);
  static const neutro800 = Color(0xFF172536);
  static const neutro700 = Color(0xFF314155);
  static const neutro600 = Color(0xFF5F6F82);
  static const neutro500 = Color(0xFF748397);
  static const neutro400 = Color(0xFF8B99AA);
  static const neutro300 = Color(0xFFB3BFCC);
  static const neutro200 = Color(0xFFD4DCE7);
  static const neutro150 = Color(0xFFE1E7EF);
  static const neutro100 = Color(0xFFEAF0F6);
  static const neutro050 = Color(0xFFF5F8FC);
  static const erroClaro = Color(0xFFD43B3B);
  static const erroEscuro = Color(0xFFFF6B6B);

  final bool isDark;
  final bool temaEscuroMedio;

  Color get primaria => isDark ? azulPrimarioEscuro : azulPrimario;

  Color get acaoPrimaria => isDark ? azulAcaoEscuro : azulAcao;

  Color get destaque => isDark ? laranjaDestaqueEscuro : laranjaDestaque;

  Color get contrastePrimaria =>
      isDark ? conteudoSobrePrimariaEscura : conteudoSobrePrimaria;

  Color get contrasteDestaque =>
      isDark ? conteudoSobreDestaqueEscura : conteudoSobreDestaque;

  Color get contrasteSucesso =>
      isDark ? const Color(0xFF062815) : conteudoSobreDestaque;

  Color get contrasteErro =>
      isDark ? const Color(0xFF2A0505) : conteudoSobreDestaque;

  Color get textoComum =>
      isDark ? const Color(0xFFEAF2FA) : const Color(0xFF172131);

  Color get texto => textoComum;

  Color get textoSecundario => isDark ? const Color(0xFFC8D6E6) : neutro600;

  Color get textoSutil => isDark ? const Color(0xFF94A5B8) : neutro400;

  Color get backgroundPrimario =>
      isDark ? (temaEscuroMedio ? neutro900 : neutro950) : neutro050;

  Color get backgroundSecundario =>
      isDark ? const Color(0xFF172536) : Colors.white;

  Color get surfaceBaixa =>
      isDark ? _camadaPrimariaEscura(0.10) : const Color(0xFFEFF5FB);

  Color get surfaceAlta =>
      isDark ? _camadaPrimariaEscura(0.16) : const Color(0xFFFEFCFF);

  Color get surfaceMaisAlta =>
      isDark ? _camadaPrimariaEscura(0.24) : const Color(0xFFDCEAF8);

  Color get campo => backgroundSecundario;

  Color get borda => isDark ? const Color(0xFF293C54) : neutro150;

  Color get outline => isDark ? const Color(0xFF3A5270) : neutro200;

  Color get icons => isDark ? const Color(0xFFC8D6E6) : neutro600;

  Color get hover => isDark
      ? primaria.withValues(alpha: 0.14)
      : primaria.withValues(alpha: 0.08);

  Color get foco => isDark
      ? destaque.withValues(alpha: 0.24)
      : destaque.withValues(alpha: 0.16);

  Color get pressionado => isDark
      ? primaria.withValues(alpha: 0.20)
      : primaria.withValues(alpha: 0.12);

  Color get sombraBase => const Color(0xFF071527);

  Color get sombra => sombraBase.withValues(alpha: isDark ? 0.34 : 0.08);

  Color get green => isDark ? verdeEnergia : verdeDestaque;

  Color get red => isDark ? erroEscuro : erroClaro;

  Color get containerPrimario =>
      isDark ? const Color(0xFF12314F) : const Color(0xFFDDEBFA);

  Color get textoPrimarioContainer =>
      isDark ? const Color(0xFFD7E9FF) : const Color(0xFF0B2A4A);

  Color get containerDestaque =>
      isDark ? const Color(0xFF5C3418) : const Color(0xFFFFEFDE);

  Color get textoDestaqueContainer =>
      isDark ? const Color(0xFFFFD9B0) : const Color(0xFF623300);

  Color get containerSucesso =>
      isDark ? verdeSuperficie : const Color(0xFFDFF6E9);

  Color get textoSucessoContainer =>
      isDark ? const Color(0xFFC9F7DE) : const Color(0xFF0D3A24);

  Color _camadaPrimariaEscura(double alpha) {
    return Color.alphaBlend(
      primaria.withValues(alpha: alpha),
      backgroundSecundario,
    );
  }
}

class TemaEstiloTexto {
  const TemaEstiloTexto(this.cores);

  final TemaCores cores;

  TextTheme get materialTextTheme => TextTheme(
    displayLarge: _text(40, FontWeight.w900, 1),
    displayMedium: _text(34, FontWeight.w900, 1.05),
    displaySmall: _text(30, FontWeight.w800, 1.08),
    headlineLarge: _text(28, FontWeight.w800, 1.1),
    headlineMedium: _text(24, FontWeight.w800, 1.12),
    headlineSmall: _text(20, FontWeight.w800, 1.16),
    titleLarge: _text(20, FontWeight.w800, 1.2),
    titleMedium: _text(16, FontWeight.w800, 1.25),
    titleSmall: _text(14, FontWeight.w700, 1.3),
    bodyLarge: _text(15, FontWeight.w500, 1.5),
    bodyMedium: _text(13, FontWeight.w500, 1.45),
    bodySmall: _text(12, FontWeight.w500, 1.4),
    labelLarge: _text(13, FontWeight.w800, 1.2),
    labelMedium: _text(12, FontWeight.w700, 1.2),
    labelSmall: _text(11, FontWeight.w700, 1.15),
  );

  TemaTexto get headlineBold =>
      TemaTexto(_text(28, FontWeight.w800, 1.1), cores);

  TemaTexto get bodyText => TemaTexto(_text(13, FontWeight.w500, 1.45), cores);

  TemaTexto get buttonText => TemaTexto(_text(13, FontWeight.w800, 1.2), cores);

  TemaTexto get labelText => TemaTexto(_text(12, FontWeight.w700, 1.2), cores);

  TemaTexto get cardTitle => TemaTexto(_text(16, FontWeight.w800, 1.25), cores);

  TemaTexto get titleBold => TemaTexto(_text(20, FontWeight.w800, 1.2), cores);

  TextStyle _text(double size, FontWeight weight, double height) {
    return TextStyle(
      color: cores.texto,
      fontFamily: TemaTipografia.familiaFonte,
      fontFamilyFallback: TemaTipografia.familiasReserva,
      fontSize: size,
      fontWeight: weight,
      height: height,
      letterSpacing: 0,
    );
  }
}

class TemaTexto {
  const TemaTexto(this.base, this._cores);

  final TextStyle base;
  final TemaCores _cores;

  TextStyle get corTexto => base.copyWith(color: _cores.textoComum);

  TextStyle get corContrastePrimaria =>
      base.copyWith(color: _cores.contrastePrimaria);

  TextStyle get primaria => base.copyWith(color: _cores.primaria);

  TextStyle get corDestaque => base.copyWith(color: _cores.destaque);

  TextStyle get secundaria => base.copyWith(color: _cores.textoSecundario);

  TextStyle get sutil => base.copyWith(color: _cores.textoSutil);
}

abstract final class TemaTipografia {
  static const familiaFonte = 'Inter';
  static const familiasReserva = ['Roboto', 'Arial', 'sans-serif'];
}

abstract final class TemaMedidas {
  static const alturaControle = 44.0;
  static const larguraMinimaControle = 64.0;
  static const raioControle = 6.0;
  static const raioCheckbox = 4.0;
  static const raioCard = 8.0;
  static const raioPainel = 8.0;
  static const paddingControle = EdgeInsets.symmetric(
    horizontal: 14,
    vertical: 10,
  );
  static const paddingControleCompacto = EdgeInsets.symmetric(
    horizontal: 10,
    vertical: 8,
  );
}
