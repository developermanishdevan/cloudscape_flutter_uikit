const fs = require('fs');
const path = require('path');

const tokensPath = require.resolve('@cloudscape-design/design-tokens/index-visual-refresh.json');
const data = require(tokensPath).tokens;

const keys = Object.keys(data);

function toCamelCase(str) {
    return str.split('-').map((part, index) => {
        if (index === 0) return part;
        return part.charAt(0).toUpperCase() + part.slice(1);
    }).join('');
}

function extractValue(valData, mode) {
    if (typeof valData === 'string') return valData;
    if (valData && valData[mode] !== undefined) return valData[mode];
    if (valData && valData.light) return valData.light;
    if (valData && valData.comfortable) return valData.comfortable;
    return null;
}

function resolveToken(val, mode, seen = new Set()) {
    if (typeof val === 'string' && val.startsWith('{') && val.endsWith('}')) {
        const refKey = val.slice(1, -1);
        if (seen.has(refKey)) return null;
        seen.add(refKey);

        if (data[refKey]) {
            const innerVal = extractValue(data[refKey].$value, mode);
            return resolveToken(innerVal, mode, seen);
        }
    }
    return val;
}

function toFlutterColor(value) {
    if (!value) return null;
    value = value.trim();

    if (value.startsWith('rgba')) {
        const match = value.match(/rgba\(\s*(\d+)\s*,\s*(\d+)\s*,\s*(\d+)\s*,\s*([\d.]+)\s*\)/);
        if (match) {
            const r = match[1];
            const g = match[2];
            const b = match[3];
            const a = match[4];
            const aHex = Math.round(parseFloat(a) * 255).toString(16).padStart(2, '0');
            const rHex = parseInt(r).toString(16).padStart(2, '0');
            const gHex = parseInt(g).toString(16).padStart(2, '0');
            const bHex = parseInt(b).toString(16).padStart(2, '0');
            return `Color(0x${aHex}${rHex}${gHex}${bHex})`;
        }
    } else if (value.startsWith('#')) {
        let hex = value.slice(1);
        if (hex.length === 3) hex = hex.split('').map(c => c + c).join('');
        if (hex.length === 6) return `Color(0xFF${hex.toUpperCase()})`;
        if (hex.length === 8) return `Color(0x${hex.slice(6, 8)}${hex.slice(0, 6).toUpperCase()})`;
    } else if (value === 'transparent') {
        return 'Colors.transparent';
    }
    return null;
}

function toDouble(val) {
    if (!val) return null;
    if (typeof val === 'number') return val;
    if (val.toString().endsWith('px')) return parseFloat(val.toString().replace('px', '').trim());
    if (val.toString().endsWith('rem')) return parseFloat(val.toString().replace('rem', '').trim()) * 16;
    return parseFloat(val);
}

const targetDir = 'd:/developer.manish/FLUTTER-PACKAGE/MAIN-PACKAGE/cloudscape_flutter_uikit/lib/src/foundation/tokens/';

// ==========================================
// 1. COLORS
// ==========================================
let colorKeys = keys.filter(k => k.startsWith('color-'));
let colorsOutput = `import 'package:flutter/material.dart';

/// Semantic tokens for colors.
/// Generated from Cloudscape Design Tokens.
class CloudscapeColors {\n`;

colorKeys.forEach(key => {
    const fcLight = toFlutterColor(resolveToken(extractValue(data[key].$value, 'light'), 'light'));
    const fcDark = toFlutterColor(resolveToken(extractValue(data[key].$value, 'dark'), 'dark'));
    if (fcLight && fcDark) {
        colorsOutput += `  final Color ${toCamelCase(key).replace('color', '')};\n`;
    }
});
colorsOutput += `\n  const CloudscapeColors({\n`;
colorKeys.forEach(key => {
    const fcLight = toFlutterColor(resolveToken(extractValue(data[key].$value, 'light'), 'light'));
    const fcDark = toFlutterColor(resolveToken(extractValue(data[key].$value, 'dark'), 'dark'));
    if (fcLight && fcDark) {
        colorsOutput += `    required this.${toCamelCase(key).replace('color', '')},\n`;
    }
});
colorsOutput += `  });\n\n`;

// Light Mode
colorsOutput += `  factory CloudscapeColors.light() => const CloudscapeColors(\n`;
colorKeys.forEach(key => {
    const fcLight = toFlutterColor(resolveToken(extractValue(data[key].$value, 'light'), 'light'));
    const fcDark = toFlutterColor(resolveToken(extractValue(data[key].$value, 'dark'), 'dark'));
    if (fcLight && fcDark) {
        colorsOutput += `    ${toCamelCase(key).replace('color', '')}: ${fcLight},\n`;
    }
});
colorsOutput += `  );\n\n`;

// Dark Mode
colorsOutput += `  factory CloudscapeColors.dark() => const CloudscapeColors(\n`;
colorKeys.forEach(key => {
    const fcLight = toFlutterColor(resolveToken(extractValue(data[key].$value, 'light'), 'light'));
    const fcDark = toFlutterColor(resolveToken(extractValue(data[key].$value, 'dark'), 'dark'));
    if (fcLight && fcDark) {
        colorsOutput += `    ${toCamelCase(key).replace('color', '')}: ${fcDark},\n`;
    }
});
colorsOutput += `  );\n}\n`;

fs.writeFileSync(path.join(targetDir, 'colors.dart'), colorsOutput);


// ==========================================
// 2. SPACING
// ==========================================
let spacingOutput = `/// Spacing tokens for consistent rhythm and clarity.
/// Generated from Cloudscape Design Tokens.
class CloudscapeSpacing {\n`;
keys.filter(k => k.startsWith('space-')).forEach(key => {
    const t = data[key];
    const rawSpace = extractValue(t.$value, 'comfortable') || extractValue(t.$value, 'light');
    const spaceVal = resolveToken(rawSpace, 'comfortable');
    const dVal = toDouble(spaceVal);
    if (!isNaN(dVal)) {
        const rawName = toCamelCase(key.replace('space-', ''));
        spacingOutput += `  static const double ${rawName} = ${dVal};\n`;
    }
});
spacingOutput += `}\n`;
fs.writeFileSync(path.join(targetDir, 'spacing.dart'), spacingOutput);


// ==========================================
// 3. RADIUS
// ==========================================
let radiusOutput = `import 'package:flutter/material.dart';

/// Border radius tokens for Cloudscape Design System.
/// Generated from Cloudscape Design Tokens.
class CloudscapeRadius {\n`;

let radiusConsts = [];
keys.filter(k => k.startsWith('border-radius-')).forEach(key => {
    const t = data[key];
    const valueLight = resolveToken(extractValue(t.$value, 'light'), 'light') || '';
    const dVal = toDouble(valueLight);
    if (!isNaN(dVal)) {
        const rawName = toCamelCase(key.replace('border-radius-', ''));
        radiusOutput += `  static const double ${rawName} = ${dVal};\n`;
        radiusConsts.push(rawName);
    }
});

radiusOutput += `\n`;
radiusConsts.forEach(rawName => {
    radiusOutput += `  static const BorderRadius br${rawName.charAt(0).toUpperCase() + rawName.slice(1)} = BorderRadius.all(Radius.circular(${rawName}));\n`;
});

radiusOutput += `}\n`;
fs.writeFileSync(path.join(targetDir, 'radius.dart'), radiusOutput);

// ==========================================
// 4. TYPOGRAPHY
// ==========================================
let typographyOutput = `import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Typography definitions for Cloudscape Design System.
/// Generated from Cloudscape Design Tokens.
class CloudscapeTypography {
  static final TextStyle _base = GoogleFonts.openSans();
  static final TextStyle _mono = GoogleFonts.sourceCodePro();\n\n`;

// First list all raw doubles and weights
keys.filter(k => k.startsWith('font-') || k.startsWith('size-font-') || k.startsWith('line-height-')).forEach(key => {
    const t = data[key];
    const valueLight = resolveToken(extractValue(t.$value, 'light'), 'light') || '';
    if (key.includes('font-weight')) {
        const rawName = toCamelCase(key.replace('font-', ''));
        typographyOutput += `  static const FontWeight ${rawName} = FontWeight.w${valueLight.toString().trim()};\n`;
    } else {
        const dVal = toDouble(valueLight);
        if (!isNaN(dVal)) {
            let modKey = key.replace('font-', '').replace('size-', '');
            const rawName = toCamelCase(modKey);
            typographyOutput += `  static const double fontSize${rawName.charAt(0).toUpperCase() + rawName.slice(1)} = ${dVal};\n`;
        }
    }
});

typographyOutput += `\n  // Type Styles\n`;
const headings = ['BodyM', 'BodyS', 'DisplayL', 'HeadingXl', 'HeadingL', 'HeadingM', 'HeadingS', 'HeadingXs'];
headings.forEach(h => {
    let lowerName = h.charAt(0).toLowerCase() + h.slice(1);
    typographyOutput += `  static final TextStyle ${lowerName} = _base.copyWith(
    fontSize: fontSize${h},
    height: lineHeight${h} / fontSize${h},
    fontWeight: weight${h.replace('Body', 'BodyM').replace('Display', 'DisplayL')}, // Adjust as needed if weight token matches
  );\n\n`;
});

typographyOutput += `}\n`;
fs.writeFileSync(path.join(targetDir, 'typography.dart'), typographyOutput);

console.log('Successfully wrote colors.dart, spacing.dart, radius.dart, and typography.dart into flutter foundation kit');
