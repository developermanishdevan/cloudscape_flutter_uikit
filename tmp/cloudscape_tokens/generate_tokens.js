const fs = require('fs');
const path = require('path');

const tokensPath = require.resolve('@cloudscape-design/design-tokens/index-visual-refresh.json');
const data = require(tokensPath).tokens;

const keys = Object.keys(data);

let output = `import 'package:flutter/material.dart';

/// Auto-generated Cloudscape Design Tokens
/// Do not edit directly, use the generator script.
class CloudscapeTokens {
`;

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

// -----------------------------------------
// 1. Spacing Tokens
// -----------------------------------------
output += `  // --- SPACING ---\n`;
keys.filter(k => k.startsWith('space-')).forEach(key => {
    const t = data[key];
    const rawSpace = extractValue(t.$value, 'comfortable') || extractValue(t.$value, 'light');
    const spaceVal = resolveToken(rawSpace, 'comfortable');
    const dVal = toDouble(spaceVal);
    if (!isNaN(dVal)) {
        output += `  static const double ${toCamelCase(key)} = ${dVal};\n`;
    }
});
output += `\n`;

// -----------------------------------------
// 2. Radius Tokens
// -----------------------------------------
output += `  // --- RADIUS ---\n`;
keys.filter(k => k.startsWith('border-radius-')).forEach(key => {
    const t = data[key];
    const valueLight = resolveToken(extractValue(t.$value, 'light'), 'light') || '';
    const dVal = toDouble(valueLight);
    if (!isNaN(dVal)) {
        output += `  static const double ${toCamelCase(key)} = ${dVal};\n`;
    }
});
output += `\n`;

// -----------------------------------------
// 3. Typography Tokens
// -----------------------------------------
output += `  // --- TYPOGRAPHY ---\n`;
keys.filter(k => k.startsWith('font-') || k.startsWith('size-font-') || k.startsWith('line-height-')).forEach(key => {
    const t = data[key];
    const valueLight = resolveToken(extractValue(t.$value, 'light'), 'light') || '';
    if (key.includes('font-weight')) {
        output += `  static const FontWeight ${toCamelCase(key)} = FontWeight.w${valueLight.toString().trim()};\n`;
    } else {
        const dVal = toDouble(valueLight);
        if (!isNaN(dVal)) {
            output += `  static const double ${toCamelCase(key)} = ${dVal};\n`;
        }
    }
});
output += `\n`;

output += `}\n\n`;

// -----------------------------------------
// 4. Color Tokens (Theme Extension format)
// -----------------------------------------
let colorKeys = keys.filter(k => k.startsWith('color-'));
output += `class CloudscapeColorTokens {\n`;
colorKeys.forEach(key => {
    const fcLight = toFlutterColor(resolveToken(extractValue(data[key].$value, 'light'), 'light'));
    const fcDark = toFlutterColor(resolveToken(extractValue(data[key].$value, 'dark'), 'dark'));
    if (fcLight && fcDark) {
        output += `  final Color ${toCamelCase(key)};\n`;
    }
});
output += `\n  const CloudscapeColorTokens({\n`;
colorKeys.forEach(key => {
    const fcLight = toFlutterColor(resolveToken(extractValue(data[key].$value, 'light'), 'light'));
    const fcDark = toFlutterColor(resolveToken(extractValue(data[key].$value, 'dark'), 'dark'));
    if (fcLight && fcDark) {
        output += `    required this.${toCamelCase(key)},\n`;
    }
});
output += `  });\n\n`;

// Light Mode
output += `  factory CloudscapeColorTokens.light() => const CloudscapeColorTokens(\n`;
colorKeys.forEach(key => {
    const fcLight = toFlutterColor(resolveToken(extractValue(data[key].$value, 'light'), 'light'));
    const fcDark = toFlutterColor(resolveToken(extractValue(data[key].$value, 'dark'), 'dark'));
    if (fcLight && fcDark) {
        output += `    ${toCamelCase(key)}: ${fcLight},\n`;
    }
});
output += `  );\n\n`;

// Dark Mode
output += `  factory CloudscapeColorTokens.dark() => const CloudscapeColorTokens(\n`;
colorKeys.forEach(key => {
    const fcLight = toFlutterColor(resolveToken(extractValue(data[key].$value, 'light'), 'light'));
    const fcDark = toFlutterColor(resolveToken(extractValue(data[key].$value, 'dark'), 'dark'));
    if (fcLight && fcDark) {
        output += `    ${toCamelCase(key)}: ${fcDark},\n`;
    }
});
output += `  );\n`;
output += `}\n`;

const outPath = 'd:/developer.manish/FLUTTER-PACKAGE/MAIN-PACKAGE/cloudscape_flutter_uikit/lib/src/foundation/tokens/generated/cloudscape_tokens.dart';
fs.writeFileSync(outPath, output);
console.log('Dart tokens generated at:', outPath);
