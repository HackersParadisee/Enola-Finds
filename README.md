
# Enola-Finds

### An Advanced OSINT Information Gathering Tool

Enola-Finds is a powerful and flexible tool designed to gather OSINT (Open-Source Intelligence) data effortlessly. It leverages multiple utilities to extract valuable information about targets, domains, and websites, making it perfect for penetration testers, ethical hackers, and cybersecurity enthusiasts.

---

## Table of Contents
- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
  - [Running the Tool](#running-the-tool)
  - [Available Operations](#available-operations)
- [Logging and Reports](#logging-and-reports)
- [Configuration](#configuration)
- [Scheduling Scans](#scheduling-scans)
- [Contributing](#contributing)
- [License](#license)

---

## Features
- **Multithreading**: Run multiple tools simultaneously to speed up information gathering.
- **Batch Target Scanning**: Perform OSINT scans on multiple targets.
- **HTML Report Generation**: Generate easy-to-read reports from gathered data.
- **Progress Bar**: Visual feedback on tool installation progress.
- **Password Authentication**: Secure access to tool features.
- **Logging**: Automatically logs all operations to a log file.
- **Retry Mechanism**: Automatic retry on tool installation failures.
- **Cron Job Scheduling**: Schedule recurring scans for continuous monitoring.
- **Network Detection**: Ensures the tool runs only when network connectivity is available.

---

## Installation

### Prerequisites
Ensure your system is running a Debian-based Linux distribution (e.g., Ubuntu). You'll need **sudo** privileges.

### Steps
1. Clone the repository:
    \`\`\`bash
    git clone https://github.com/HackersParadisee/Enola-Finds.sh
    cd Enola-Finds
    \`\`\`

2. Make the installation script executable:
    \`\`\`bash
    chmod +x Enola-Finds.sh
    \`\`\`

3. Run the script to install the required tools:
    \`\`\`bash
    ./Enola-Finds.sh
    \`\`\`

Enola-Finds will automatically install all the necessary dependencies, including `nmap`, `whois`, `dnsenum`, `sublist3r`, and more. 

---

## Usage

### Running the Tool
Once installed, launch Enola-Finds:
\`\`\`bash
./enola-finds.sh
\`\`\`

You will be prompted for a password for authentication (can be configured in the script).

### Available Operations
Upon launch, you'll be presented with a menu of available tools:
- **Nmap** - Network exploration and security auditing
- **Whois** - Domain information lookup
- **DNSenum** - DNS enumeration
- **Sublist3r** - Subdomain enumeration
- **Dirb** - URL brute force
- **Gobuster** - Directory and DNS brute force
- **Nikto** - Web server scanner
- **WhatWeb** - Website fingerprinting
- **WafW00f** - Web application firewall detection
- **DNSrecon** - DNS enumeration and brute forcing
- **SSLscan** - SSL/TLS security testing
- **Run all tools on target** - Comprehensive scan on a specified target

Simply enter the number corresponding to the tool you wish to use.

---

## Logging and Reports
- **Logging**: All operations and outputs are logged in `enola_finds.log` by default.
- **Report Generation**: After each scan, an HTML report is generated summarizing the results of all tools used during the scan.

To view the log:
\`\`\`bash
cat enola_finds.log
\`\`\`

Reports are saved automatically and can be found in the `reports/` directory.

---

## Configuration
Enola-Finds uses a simple configuration file `config.ini` to store custom settings, like:
- Default targets
- Output directories
- API keys (e.g., Shodan API)

Make sure to modify `config.ini` to suit your needs.

---

## Scheduling Scans
Enola-Finds allows you to schedule scans using `cron`. This is ideal for running scans automatically at specific intervals.

To schedule a scan, select the **Schedule Scan** option from the menu and provide the cron timing.

---

## Contributing
If you'd like to contribute, please fork the repository and use a feature branch. Pull requests are welcome.

---

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

**Developers**:
- **Yash Pawar** - yashpawar1199@gmail.com
- **Om Navale** - omnavale930@gmail.com
- **Siddhanth Gaikwad** - siddhanthgaikwad7@gmail.com

---

This tool is intended for educational purposes and ethical hacking only. Misuse of this tool can lead to legal consequences.
