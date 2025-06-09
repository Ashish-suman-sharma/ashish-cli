# Ashish CLI - Universal Code Runner

[![npm version](https://badge.fury.io/js/ashish-cli.svg)](https://badge.fury.io/js/ashish-cli)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A command-line tool that executes code in multiple programming languages without installing local compilers.

## 🚀 Installation

```bash
npm install -g ashish-cli
```

## 📖 Usage

```bash
# Run a file with automatic language detection
ashish script.py

# Run with input file
ashish solution.cpp -i input.txt

# List supported languages
ashish --list

# Get help
ashish --help
```

## 📋 Supported Languages

- JavaScript/TypeScript
- Python
- C/C++
- Java
- C#
- Rust
- Go
- Ruby
- PHP
- And 10+ more!

## ⚙️ Configuration

Set your RapidAPI key for Judge0 (optional):

```bash
export RAPIDAPI_KEY="your-api-key"
```

## 📝 Examples

**Python:**

```bash
ashish hello.py
```

**C++ with input:**

```bash
ashish solution.cpp -i input.txt
```

**Java:**

```bash
ashish Main.java
```

## 🔧 Development

```bash
git clone https://github.com/ashish-suman-sharma/ashish-cli.git
cd ashish-cli
npm install
npm link
```

## 📜 License

MIT License - see [LICENSE](LICENSE) file for details.

---

**Happy Coding! 🎉**
