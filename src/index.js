#!/usr/bin/env node

const { program } = require("commander");
const chalk = require("chalk");
const fs = require("fs-extra");
const path = require("path");
const { executeCode } = require("./executor");
const { detectLanguage } = require("./language-detector");
const { loadConfig } = require("./config");

// Package info
const packageJson = require("../package.json");

// Setup CLI
program
  .name("ashish")
  .description(
    "Universal Code Runner CLI - Execute code in multiple languages without local compilers"
  )
  .version(packageJson.version);

program
  .argument("<file>", "code file to execute")
  .option("-i, --input <file>", "input file for stdin")
  .option("-a, --api <url>", "custom API endpoint")
  .option("-t, --timeout <seconds>", "execution timeout in seconds", "10")
  .option("--json", "output in JSON format")
  .option("--verbose", "verbose output")
  .action(async (file, options) => {
    try {
      // Check if file exists
      if (!(await fs.pathExists(file))) {
        console.error(chalk.red(`Error: File '${file}' not found`));
        process.exit(1);
      }

      // Read code file
      const code = await fs.readFile(file, "utf8");

      // Read input file if provided
      let input = "";
      if (options.input) {
        if (!(await fs.pathExists(options.input))) {
          console.error(
            chalk.red(`Error: Input file '${options.input}' not found`)
          );
          process.exit(1);
        }
        input = await fs.readFile(options.input, "utf8");
      }

      // Detect language
      const language = detectLanguage(file);
      if (!language) {
        console.error(
          chalk.red(`Error: Unsupported file extension for '${file}'`)
        );
        process.exit(1);
      }

      if (options.verbose) {
        console.log(chalk.blue(`Detected language: ${language.name}`));
        console.log(chalk.blue(`Using API: ${options.api || "default"}`));
      }

      // Load config
      const config = await loadConfig();

      // Execute code
      const result = await executeCode(code, language, input, {
        apiEndpoint: options.api || config.apiEndpoint,
        timeout: parseInt(options.timeout),
        verbose: options.verbose,
      });

      // Display results
      if (options.json) {
        console.log(JSON.stringify(result, null, 2));
      } else {
        displayResult(result);
      }
    } catch (error) {
      console.error(chalk.red(`Error: ${error.message}`));
      if (options.verbose) {
        console.error(error.stack);
      }
      process.exit(1);
    }
  });

// Help command
program
  .command("languages")
  .description("List supported languages")
  .action(() => {
    const languages = require("./languages.json");
    console.log(chalk.blue("Supported Languages:"));
    console.log("");
    Object.entries(languages).forEach(([ext, lang]) => {
      console.log(
        `  ${chalk.green(ext.padEnd(8))} → ${lang.name} (ID: ${lang.id})`
      );
    });
  });

// Config command
program
  .command("config")
  .description("Show configuration")
  .action(async () => {
    const config = await loadConfig();
    console.log(chalk.blue("Current Configuration:"));
    console.log("");
    console.log(`  API Endpoint: ${config.apiEndpoint}`);
    console.log(`  Config File:  ${config.configPath}`);
  });

function displayResult(result) {
  if (result.stdout) {
    console.log(result.stdout);
  }

  if (result.stderr) {
    console.error(chalk.red(result.stderr));
  }

  if (result.compile_output) {
    console.error(chalk.yellow("Compilation Output:"));
    console.error(chalk.yellow(result.compile_output));
  }

  if (result.status && result.status.description !== "Accepted") {
    console.error(chalk.red(`Status: ${result.status.description}`));
  }

  // Exit with appropriate code
  if (result.status && result.status.id !== 3) {
    // 3 = Accepted in Judge0
    process.exit(1);
  }
}

// Parse arguments
program.parse();
