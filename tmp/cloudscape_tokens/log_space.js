const tokens = require('./node_modules/@cloudscape-design/design-tokens/index-visual-refresh.json').tokens;
const spaces = Object.keys(tokens).filter(k => k.includes('space-scaled'));
spaces.forEach(k => console.log(k, tokens[k].$value));
