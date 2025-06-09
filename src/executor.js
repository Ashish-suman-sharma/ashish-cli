const axios = require("axios");
const chalk = require("chalk");

/**
 * Execute code using Piston API (free, no API key required)
 */
async function executeCode(code, language, input = "", options = {}) {
  const {
    apiEndpoint = "https://emkc.org/api/v2/piston",
    timeout = 10,
    verbose = false,
  } = options;

  try {
    if (verbose) {
      console.log(chalk.blue("Submitting code to Piston API..."));
    }

    // Map language to Piston format
    const pistonLanguage = getPistonLanguage(language);
    if (!pistonLanguage) {
      throw new Error(
        `Language ${language.name} is not supported by Piston API`
      );
    }

    const requestData = {
      language: pistonLanguage.name,
      version: pistonLanguage.version || "*",
      files: [
        {
          name: getFileName(language),
          content: code,
        },
      ],
    };

    // Add stdin if provided
    if (input.trim()) {
      requestData.stdin = input;
    }

    if (verbose) {
      console.log(
        chalk.blue(
          `Language: ${pistonLanguage.name} v${
            pistonLanguage.version || "latest"
          }`
        )
      );
    }

    const response = await axios.post(`${apiEndpoint}/execute`, requestData, {
      headers: {
        "Content-Type": "application/json",
      },
      timeout: (timeout + 5) * 1000, // Convert to milliseconds
    });

    const result = response.data;

    // Format result to match expected structure
    return {
      stdout: result.run?.stdout || "",
      stderr: result.run?.stderr || "",
      compile_output: result.compile?.stderr || result.compile?.stdout || "",
      status: {
        id: result.run?.code === 0 ? 3 : 4, // Map to Judge0-like status codes
        description: result.run?.code === 0 ? "Accepted" : "Runtime Error",
      },
      time: null,
      memory: null,
      exit_code: result.run?.code || 0,
    };
  } catch (error) {
    if (error.response) {
      const errorMsg =
        error.response.data?.message || error.response.statusText;
      throw new Error(
        `Piston API Error: ${error.response.status} - ${errorMsg}`
      );
    } else if (error.request) {
      throw new Error(
        "Network Error: Unable to reach Piston API. Please check your internet connection."
      );
    } else {
      throw new Error(`Execution Error: ${error.message}`);
    }
  }
}

/**
 * Map our language format to Piston API format
 */
function getPistonLanguage(language) {
  const pistonMap = {
    C: { name: "c", version: "*" },
    "C++": { name: "cpp", version: "*" },
    Java: { name: "java", version: "*" },
    Python: { name: "python", version: "*" },
    JavaScript: { name: "javascript", version: "*" },
    TypeScript: { name: "typescript", version: "*" },
    "C#": { name: "csharp", version: "*" },
    Go: { name: "go", version: "*" },
    Rust: { name: "rust", version: "*" },
    Ruby: { name: "ruby", version: "*" },
    PHP: { name: "php", version: "*" },
    Swift: { name: "swift", version: "*" },
    Kotlin: { name: "kotlin", version: "*" },
    Scala: { name: "scala", version: "*" },
    Perl: { name: "perl", version: "*" },
    R: { name: "r", version: "*" },
    Lua: { name: "lua", version: "*" },
    Bash: { name: "bash", version: "*" },
    Dart: { name: "dart", version: "*" },
    Fortran: { name: "fortran", version: "*" },
    Pascal: { name: "pascal", version: "*" },
  };

  return pistonMap[language.name] || null;
}

/**
 * Get appropriate filename for the language
 */
function getFileName(language) {
  const fileNames = {
    C: "main.c",
    "C++": "main.cpp",
    Java: "Main.java",
    Python: "main.py",
    JavaScript: "main.js",
    TypeScript: "main.ts",
    "C#": "Main.cs",
    Go: "main.go",
    Rust: "main.rs",
    Ruby: "main.rb",
    PHP: "main.php",
    Swift: "main.swift",
    Kotlin: "Main.kt",
    Scala: "Main.scala",
    Perl: "main.pl",
    R: "main.r",
    Lua: "main.lua",
    Bash: "main.sh",
    Dart: "main.dart",
    Fortran: "main.f90",
    Pascal: "main.pas",
  };

  return fileNames[language.name] || "main.txt";
}

/**
 * Alternative executor using Piston API
 */
async function executeCodeWithPiston(code, language, input = "", options = {}) {
  const { apiEndpoint = "https://emkc.org/api/v2/piston", verbose = false } =
    options;

  try {
    if (verbose) {
      console.log(chalk.blue("Submitting code to Piston API..."));
    }

    const requestData = {
      language: language.pistonName || language.name.toLowerCase(),
      version: language.pistonVersion || "*",
      files: [
        {
          content: code,
        },
      ],
      stdin: input,
    };

    const response = await axios.post(`${apiEndpoint}/execute`, requestData, {
      headers: {
        "Content-Type": "application/json",
      },
    });

    const result = response.data;

    return {
      stdout: result.run?.stdout || "",
      stderr: result.run?.stderr || "",
      compile_output: result.compile?.stderr || "",
      status: {
        id: result.run?.code === 0 ? 3 : 4, // Map to Judge0 status codes
        description: result.run?.code === 0 ? "Accepted" : "Runtime Error",
      },
      time: null,
      memory: null,
    };
  } catch (error) {
    if (error.response) {
      throw new Error(
        `Piston API Error: ${error.response.status} - ${
          error.response.data.message || error.response.statusText
        }`
      );
    } else if (error.request) {
      throw new Error("Network Error: Unable to reach Piston API");
    } else {
      throw new Error(`Execution Error: ${error.message}`);
    }
  }
}

module.exports = {
  executeCode,
};
