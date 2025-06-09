# Project Prompt: Universal Code Runner CLI (`ashish`)

## Overview

Design and build a **cross-platform command-line tool** (CLI) called `ashish` that allows users to execute or compile code files in multiple programming languages **without installing any local compilers or interpreters**. The tool should:
- Detect the language from the file extension.
- Send the code to a remote execution API (like Judge0 or Piston).
- Display the output or errors directly in the terminal.
- Be installable via `winget`, `npm`, or similar package managers.

## Motivation

Developers frequently need to compile or run code snippets in different languages. Installing and configuring multiple compilers/interpreters is time-consuming and error-prone, especially for beginners or on new machines. This tool aims to eliminate that friction, making it as simple as:

```sh
ashish hello.py
ashish test.java
ashish main.cpp
```

---

## Features

- **Language Detection:** Infers programming language from file extension.
- **Remote Compilation/Execution:** Uses a free or self-hosted code execution API to run code.
- **Result Display:** Outputs stdout, stderr, and exit code in terminal.
- **No Local Dependencies:** No need to install Python, Java, C++, etc.
- **Cross-Platform:** Works on Windows, macOS, and Linux.
- **Easy Installation:** Available via `winget`, `npm`, etc.
- **Extensible:** Support for more languages or execution services can be added via config or plugins.
- **Optional Config:** Allow users to set API endpoints or keys.

---

## User Experience

### Basic Usage

```sh
ashish filename.ext
```
- Example: `ashish hello.py`
- Example: `ashish program.cpp`

### Output

```
$ ashish hello.py
Hello, World!
```

If there are errors:

```
$ ashish buggy.c
error: expected ';' before 'return'
```

### Advanced Usage

- Run with input from stdin:
  ```sh
  ashish solution.cpp < input.txt
  ```
- Choose API endpoint:
  ```sh
  ashish --api "https://my-judge0-instance.com" main.java
  ```
- Display version/help:
  ```sh
  ashish --help
  ```

---

## Technical Requirements

### CLI Tool
- Written in Node.js (recommended for easy cross-platform support).
- Uses `commander` or `yargs` for argument parsing.
- Reads code file and (optionally) input data.
- Detects language by extension and maps to API language IDs.

### Remote Code Execution
- Integrate with an API like Judge0 or Piston:
  - Send code, language, (optional) stdin to API.
  - Poll or wait for execution result.
  - Display output/errors neatly.

### Packaging & Distribution
- Package as a standalone Node.js binary (with `pkg`, `nexe`, or similar).
- Publish to npm, winget, and/or Homebrew.

### Extensibility
- Config file for API endpoint, supported languages, and credentials.
- Architecture allows easy addition of new language mappings or APIs.

---

## Example API Flow (Judge0)

1. User runs: `ashish test.py`
2. CLI reads `test.py`, detects Python.
3. CLI sends code to Judge0 API with language ID for Python.
4. Waits for execution result.
5. Displays output/errors in terminal.

---

## Possible Challenges

- **API Rate Limits:** Free APIs may limit requests; offer self-hosting guide or API key config.
- **Security:** Warn users about sending sensitive code over the internet.
- **Latency:** Remote execution is not instant, but typically fast enough for small files.
- **Language Support:** Limited by the chosen API's capabilities.

---

## Future Enhancements

- Allow running multiple files (batch mode).
- Support for code snippets via stdin or direct input.
- Customizable output formatting (colors, JSON, etc).
- Caching results or offline execution (if possible).
- Plugin system for alternative code execution backends.

---

## Deliverables

- Well-documented codebase (with clear structure and comments).
- Installation and usage instructions.
- Example config file and API usage.
- Tests for core functionality.
- README with badges and contribution guidelines.

---

## References

- [Judge0 API Docs](https://ce.judge0.com/)
- [Piston API](https://github.com/engineer-man/piston)
- [pkg Node.js Packager](https://github.com/vercel/pkg)
- [commander.js CLI Framework](https://www.npmjs.com/package/commander)

---

## License

Open source (MIT or similar).
