const path = require("path");
const languages = require("./languages.json");

/**
 * Detect programming language from file extension
 */
function detectLanguage(filePath) {
  const extension = path.extname(filePath).toLowerCase();
  return languages[extension] || null;
}

/**
 * Get all supported extensions
 */
function getSupportedExtensions() {
  return Object.keys(languages);
}

/**
 * Get language by name
 */
function getLanguageByName(name) {
  const entries = Object.entries(languages);
  for (const [ext, lang] of entries) {
    if (lang.name.toLowerCase() === name.toLowerCase()) {
      return lang;
    }
  }
  return null;
}

module.exports = {
  detectLanguage,
  getSupportedExtensions,
  getLanguageByName,
};
