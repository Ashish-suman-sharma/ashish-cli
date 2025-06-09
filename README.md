# Ashish CLI - Universal Code Runner

[![npm version](https://badge.fury.io/js/ashish-cli.svg)](https://badge.fury.io/js/ashish-cli)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A cross-platform command-line tool that allows you to execute code files in multiple programming languages **without installing any local compilers or interpreters**. Simply run your code files remotely using free execution APIs.

## 🚀 Features

- **🌐 Multi-language Support**: Execute code in 20+ programming languages
- **📦 No Local Dependencies**: No need to install Python, Java, C++, etc.
- **🔥 Fast Remote Execution**: Uses Judge0 API for reliable code execution
- **🎨 Beautiful Output**: Colored terminal output with clear error messages
- **⚙️ Configurable**: Custom API endpoints and execution settings
- **📂 Input Support**: Pass input files for interactive programs
- **🖥️ Cross-platform**: Works on Windows, macOS, and Linux

## 📋 Supported Languages

| Extension         | Language | Extension | Language   |
| ----------------- | -------- | --------- | ---------- |
| `.c`              | C        | `.js`     | JavaScript |
| `.cpp, .cc, .cxx` | C++      | `.ts`     | TypeScript |
| `.java`           | Java     | `.py`     | Python     |
| `.cs`             | C#       | `.go`     | Go         |
| `.rs`             | Rust     | `.rb`     | Ruby       |
| `.php`            | PHP      | `.swift`  | Swift      |
| `.kt`             | Kotlin   | `.scala`  | Scala      |
| `.pl`             | Perl     | `.r`      | R          |
| `.lua`            | Lua      | `.sh`     | Bash       |
| `.dart`           | Dart     | `.f90`    | Fortran    |
| `.pas`            | Pascal   |           |            |

## 🛠️ Installation

### Via npm (Recommended)

```bash
npm install -g ashish-cli
```

### Via git clone (Development)

```bash
git clone https://github.com/yourusername/ashish-cli.git
cd ashish-cli
npm install
npm link
```

## 🏃‍♂️ Quick Start

### Basic Usage

```bash
# Run a Python file
ashish hello.py

# Run a C++ file
ashish program.cpp

# Run a Java file
ashish Main.java
```

### With Input File

```bash
# Run with input from file
ashish solution.cpp -i input.txt

# Or use shell redirection
ashish solution.cpp < input.txt
```

### Advanced Options

```bash
# Use custom API endpoint
ashish main.py --api "https://your-judge0-instance.com"

# Set custom timeout (default: 10 seconds)
ashish slow_program.py --timeout 30

# Verbose output for debugging
ashish debug.cpp --verbose

# JSON output format
ashish script.py --json
```

## 📖 Commands

### Execute Code

```bash
ashish <file> [options]
```

**Options:**

- `-i, --input <file>` - Input file for stdin
- `-a, --api <url>` - Custom API endpoint
- `-t, --timeout <seconds>` - Execution timeout (default: 10)
- `--json` - Output in JSON format
- `--verbose` - Verbose output

### List Supported Languages

```bash
ashish languages
```

### Show Configuration

```bash
ashish config
```

### Help

```bash
ashish --help
ashish --version
```

## ⚙️ Configuration

Ashish CLI creates a configuration file at `~/.ashish/config.json` on first run:

```json
{
  "apiEndpoint": "https://judge0-ce.p.rapidapi.com",
  "timeout": 10,
  "useRapidAPI": true,
  "rapidApiKey": "",
  "fallbackToPiston": true
}
```

### Using RapidAPI (Recommended)

1. Get a free API key from [RapidAPI Judge0](https://rapidapi.com/judge0-official/api/judge0-ce)
2. Set your API key:
   ```bash
   export RAPIDAPI_KEY="your-rapidapi-key-here"
   ```
3. Or update the config file directly

### Alternative: Free Judge0 Instance

You can use the free Judge0 instance (with rate limits):

```json
{
  "apiEndpoint": "https://judge0-ce.p.rapidapi.com",
  "useRapidAPI": false
}
```

## 📝 Examples

### Hello World Examples

**Python** (`hello.py`):

```python
print("Hello, World!")
```

```bash
$ ashish hello.py
Hello, World!
```

**C++** (`hello.cpp`):

```cpp
#include <iostream>
using namespace std;

int main() {
    cout << "Hello, World!" << endl;
    return 0;
}
```

```bash
$ ashish hello.cpp
Hello, World!
```

**Java** (`Hello.java`):

```java
public class Hello {
    public static void main(String[] args) {
        System.out.println("Hello, World!");
    }
}
```

```bash
$ ashish Hello.java
Hello, World!
```

### Interactive Programs

**Input file** (`input.txt`):

```
5
1 2 3 4 5
```

**C++ program** (`sum.cpp`):

```cpp
#include <iostream>
using namespace std;

int main() {
    int n;
    cin >> n;
    int sum = 0;
    for (int i = 0; i < n; i++) {
        int x;
        cin >> x;
        sum += x;
    }
    cout << "Sum: " << sum << endl;
    return 0;
}
```

```bash
$ ashish sum.cpp -i input.txt
Sum: 15
```

## 🔧 API Integration

### Judge0 API

- **Free Tier**: 50 requests/day
- **Paid Tiers**: Higher limits available
- **Languages**: 40+ supported languages
- **Documentation**: [Judge0 API Docs](https://ce.judge0.com/)

### Piston API (Fallback)

- **Free**: No registration required
- **Languages**: 35+ supported languages
- **Documentation**: [Piston API](https://github.com/engineer-man/piston)

## 🚨 Error Handling

### Compilation Errors

```bash
$ ashish buggy.cpp
error: expected ';' before 'return'
Status: Compilation Error
```

### Runtime Errors

```bash
$ ashish crash.py
Traceback (most recent call last):
  File "main.py", line 2, in <module>
    print(1/0)
ZeroDivisionError: division by zero
Status: Runtime Error
```

### Network Issues

```bash
$ ashish test.py
Error: Network Error: Unable to reach the execution API
```

## 🏗️ Development

### Project Structure

```
ashish-cli/
├── src/
│   ├── index.js          # Main CLI entry point
│   ├── executor.js       # Code execution logic
│   ├── language-detector.js  # Language detection
│   ├── config.js         # Configuration management
│   └── languages.json    # Language mappings
├── package.json
└── README.md
```

### Building from Source

```bash
git clone https://github.com/yourusername/ashish-cli.git
cd ashish-cli
npm install

# Run locally
node src/index.js hello.py

# Create symlink for global usage
npm link

# Build standalone binary (optional)
npm run build
```

### Adding New Languages

1. Update `src/languages.json` with new language mapping:

```json
{
  ".new": {
    "name": "NewLanguage",
    "id": 123,
    "pistonName": "newlang",
    "pistonVersion": "*"
  }
}
```

2. Test with a sample file having the `.new` extension

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [Judge0](https://judge0.com/) for providing the code execution API
- [Piston](https://github.com/engineer-man/piston) for the alternative execution engine
- [Commander.js](https://github.com/tj/commander.js/) for CLI framework
- [Chalk](https://github.com/chalk/chalk) for terminal colors

## 📞 Support

If you encounter any issues or have questions:

1. Check the [Issues](https://github.com/yourusername/ashish-cli/issues) page
2. Create a new issue with detailed information
3. For urgent matters, contact [your-email@example.com]

---

**Happy Coding! 🎉**
