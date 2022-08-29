module.exports = {
  env: {
    browser: true,
    es2021: true
  },
  extends: 'standard-with-typescript',
  overrides: [
  ],
  parserOptions: {
    project: 'tsconfig.json',
    ecmaVersion: 'latest',
    sourceType: 'module'
  },
  rules: {
    "space-before-blocks": "off",
    quotes: "off",
    "no-extra-semi": "off",
    semi: ["warn", "always"]
  }
}
