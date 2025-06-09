const fs = require("fs-extra");
const path = require("path");
const os = require("os");

/**
 * Load configuration from file or create default
 */
async function loadConfig() {
  const configDir = path.join(os.homedir(), ".ashish");
  const configPath = path.join(configDir, "config.json");
  const defaultConfig = {
    apiEndpoint: "https://emkc.org/api/v2/piston",
    timeout: 10,
    usePiston: true,
  };

  try {
    if (await fs.pathExists(configPath)) {
      const userConfig = await fs.readJson(configPath);
      return { ...defaultConfig, ...userConfig, configPath };
    } else {
      // Create config directory and file
      await fs.ensureDir(configDir);
      await fs.writeJson(configPath, defaultConfig, { spaces: 2 });
      return { ...defaultConfig, configPath };
    }
  } catch (error) {
    console.warn("Warning: Could not load config file, using defaults");
    return { ...defaultConfig, configPath };
  }
}

/**
 * Save configuration
 */
async function saveConfig(config) {
  const configDir = path.join(os.homedir(), ".ashish");
  const configPath = path.join(configDir, "config.json");

  try {
    await fs.ensureDir(configDir);
    const { configPath: _, ...configToSave } = config;
    await fs.writeJson(configPath, configToSave, { spaces: 2 });
    return true;
  } catch (error) {
    throw new Error(`Could not save config: ${error.message}`);
  }
}

module.exports = {
  loadConfig,
  saveConfig,
};
