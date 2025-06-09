const { spawn } = require('child_process');
const fs = require('fs');
const path = require('path');

// Test configuration
const CLI_PATH = path.join(__dirname, 'src', 'index.js');
const EXAMPLES_DIR = path.join(__dirname, 'examples');

// Test cases
const tests = [
  {
    name: 'Version Check',
    command: ['node', CLI_PATH, '--version'],
    expected: /\d+\.\d+\.\d+/
  },
  {
    name: 'Help Command',
    command: ['node', CLI_PATH, '--help'],
    expected: /Usage:/
  },
  {
    name: 'Languages List',
    command: ['node', CLI_PATH, 'languages'],
    expected: /Supported Languages/
  },
  {
    name: 'Config Display',
    command: ['node', CLI_PATH, 'config'],
    expected: /Configuration/
  }
];

// Test runner
async function runTest(test) {
  return new Promise((resolve) => {
    console.log(`\n🧪 Running: ${test.name}`);
    
    const process = spawn(test.command[0], test.command.slice(1), {
      stdio: ['pipe', 'pipe', 'pipe']
    });
    
    let stdout = '';
    let stderr = '';
    
    process.stdout.on('data', (data) => {
      stdout += data.toString();
    });
    
    process.stderr.on('data', (data) => {
      stderr += data.toString();
    });
    
    process.on('close', (code) => {
      const output = stdout + stderr;
      const passed = test.expected.test(output);
      
      console.log(`   ${passed ? '✅ PASS' : '❌ FAIL'}: ${test.name}`);
      
      if (!passed) {
        console.log(`   Expected: ${test.expected}`);
        console.log(`   Got: ${output.slice(0, 200)}...`);
      }
      
      resolve({ name: test.name, passed, output });
    });
    
    // Send empty input for stdin
    process.stdin.end();
  });
}

// Main test function
async function runAllTests() {
  console.log('🚀 Starting Ashish CLI Test Suite');
  console.log('=====================================');
  
  const results = [];
  
  for (const test of tests) {
    const result = await runTest(test);
    results.push(result);
  }
  
  // Summary
  console.log('\n📊 Test Summary');
  console.log('================');
  
  const passed = results.filter(r => r.passed).length;
  const total = results.length;
  
  console.log(`Passed: ${passed}/${total}`);
  
  if (passed === total) {
    console.log('🎉 All tests passed!');
    process.exit(0);
  } else {
    console.log('❌ Some tests failed!');
    process.exit(1);
  }
}

// Run tests if this file is executed directly
if (require.main === module) {
  runAllTests().catch(console.error);
}

module.exports = { runAllTests, runTest };
