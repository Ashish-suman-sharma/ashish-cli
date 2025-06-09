# Ashish CLI - Demo & Examples

This document showcases all the features of the Ashish CLI tool.

## Quick Start

After installation via `npm install -g ashish-cli`, you can immediately start running code files:

```bash
ashish hello.py
ashish program.cpp
ashish Main.java
```

## Feature Demonstrations

### 1. Multi-Language Support

The CLI supports 20+ programming languages. Here are some examples:

#### Python

```python
# hello.py
print("Hello from Python!")
```

```bash
$ ashish hello.py
Hello from Python!
```

#### C++

```cpp
// hello.cpp
#include <iostream>
using namespace std;

int main() {
    cout << "Hello from C++!" << endl;
    return 0;
}
```

```bash
$ ashish hello.cpp
Hello from C++!
```

#### Java

```java
// Hello.java
public class Hello {
    public static void main(String[] args) {
        System.out.println("Hello from Java!");
    }
}
```

```bash
$ ashish Hello.java
Hello from Java!
```

### 2. Interactive Programs with Input

For programs that require input, you can provide input files:

#### C++ Program (sum.cpp)

```cpp
#include <iostream>
using namespace std;

int main() {
    int n;
    cout << "Enter number of integers: ";
    cin >> n;

    int sum = 0;
    cout << "Enter " << n << " integers: ";
    for (int i = 0; i < n; i++) {
        int x;
        cin >> x;
        sum += x;
    }

    cout << "Sum is: " << sum << endl;
    return 0;
}
```

#### Input File (input.txt)

```
5
10 20 30 40 50
```

#### Execution

```bash
$ ashish sum.cpp -i input.txt
Enter number of integers: Enter 5 integers: Sum is: 150
```

### 3. Error Handling

The CLI provides clear error messages for compilation and runtime errors:

#### Compilation Error Example

```cpp
// buggy.cpp
#include <iostream>
using namespace std;

int main() {
    cout << "Missing semicolon" << endl
    // Missing semicolon above
    return 0;
}
```

```bash
$ ashish buggy.cpp
main.cpp:5:58: error: expected ';' before 'return'
Status: Runtime Error
```

### 4. Verbose Output

Use the `--verbose` flag to see detailed execution information:

```bash
$ ashish hello.cpp --verbose
Detected language: C++
Using API: default
Submitting code to Piston API...
Language: cpp v*
Hello from C++!
```

### 5. JSON Output Format

Get structured output in JSON format:

```bash
$ ashish hello.py --json
{
  "stdout": "Hello from Python!\n",
  "stderr": "",
  "compile_output": "",
  "status": {
    "id": 3,
    "description": "Accepted"
  },
  "time": null,
  "memory": null,
  "exit_code": 0
}
```

### 6. Language Detection

The CLI automatically detects the programming language based on file extension:

```bash
$ ashish languages
Supported Languages:

  .c       → C (ID: 50)
  .cpp     → C++ (ID: 54)
  .java    → Java (ID: 62)
  .py      → Python (ID: 71)
  .js      → JavaScript (ID: 63)
  .go      → Go (ID: 60)
  .rs      → Rust (ID: 73)
  .rb      → Ruby (ID: 72)
  .php     → PHP (ID: 68)
  .cs      → C# (ID: 51)
  # ... and many more
```

### 7. Configuration Management

View and manage configuration:

```bash
$ ashish config
Current Configuration:
  API Endpoint: https://emkc.org/api/v2/piston
  Config File:  /home/user/.ashish/config.json
```

## Advanced Usage Examples

### Custom Timeout

```bash
ashish slow_program.py --timeout 30
```

### Custom API Endpoint

```bash
ashish program.cpp --api "https://your-custom-api.com"
```

### Multiple Operations

```bash
# Run multiple files
ashish test1.py
ashish test2.cpp
ashish test3.java

# With different options
ashish debug.py --verbose --timeout 20
ashish production.cpp --json > results.json
```

## Supported Languages

| Language   | Extensions            | Example              |
| ---------- | --------------------- | -------------------- |
| C          | `.c`                  | `ashish hello.c`     |
| C++        | `.cpp`, `.cc`, `.cxx` | `ashish hello.cpp`   |
| Java       | `.java`               | `ashish Hello.java`  |
| Python     | `.py`                 | `ashish hello.py`    |
| JavaScript | `.js`                 | `ashish hello.js`    |
| TypeScript | `.ts`                 | `ashish hello.ts`    |
| Go         | `.go`                 | `ashish hello.go`    |
| Rust       | `.rs`                 | `ashish hello.rs`    |
| Ruby       | `.rb`                 | `ashish hello.rb`    |
| PHP        | `.php`                | `ashish hello.php`   |
| C#         | `.cs`                 | `ashish hello.cs`    |
| Kotlin     | `.kt`                 | `ashish hello.kt`    |
| Swift      | `.swift`              | `ashish hello.swift` |
| Scala      | `.scala`              | `ashish hello.scala` |
| Dart       | `.dart`               | `ashish hello.dart`  |
| Lua        | `.lua`                | `ashish hello.lua`   |
| Perl       | `.pl`                 | `ashish hello.pl`    |
| R          | `.r`                  | `ashish hello.r`     |
| Bash       | `.sh`                 | `ashish hello.sh`    |
| Fortran    | `.f90`                | `ashish hello.f90`   |
| Pascal     | `.pas`                | `ashish hello.pas`   |

## API Integration

The CLI uses the free Piston API (https://emkc.org/api/v2/piston) by default, which:

- Requires no API key
- Supports 35+ programming languages
- Has reasonable rate limits
- Provides fast execution times

## Installation Options

### Via npm (Recommended)

```bash
npm install -g ashish-cli
```

### Via git (Development)

```bash
git clone https://github.com/yourusername/ashish-cli.git
cd ashish-cli
npm install
npm link
```

### Building Standalone Executable

```bash
npm run build
# Creates binaries in dist/ folder for Windows, macOS, and Linux
```

## Common Use Cases

1. **Learning & Education**: Test code snippets without installing compilers
2. **Competitive Programming**: Quick testing of solutions
3. **Code Reviews**: Verify code functionality
4. **Cross-platform Development**: Test code on different systems
5. **Rapid Prototyping**: Quick iteration without setup overhead

## Troubleshooting

### Network Issues

```bash
Error: Network Error: Unable to reach Piston API
```

- Check internet connection
- Try again after a moment (temporary API issues)

### Unsupported Language

```bash
Error: Unsupported file extension for 'file.xyz'
```

- Check supported languages with `ashish languages`
- Rename file with correct extension

### File Not Found

```bash
Error: File 'missing.py' not found
```

- Verify file path and name
- Use absolute or relative paths as needed

## Contributing

The project is open source and contributions are welcome! Check the GitHub repository for:

- Issue reporting
- Feature requests
- Pull requests
- Documentation improvements

---

**Happy Coding with Ashish CLI! 🚀**
