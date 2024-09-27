#!/bin/bash

# Define color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
BOLD='\033[1m'
NC='\033[0m' # No Color

LOG_FILE="info_paradise.log"
CONFIG_FILE="info_paradise_config.ini"

# Progress bar
check_progress() {
    sudo apt-get install -y progress
}

# Function to install required tools with progress bar
install_tools() {
    echo "Installing required tools..." | tee -a "$LOG_FILE"
    sudo apt update
    progress --wait --pid $$ &
    sudo apt install -y figlet toilet lolcat jp2a nmap whois dnsenum sublist3r dirb gobuster nikto whatweb wafw00f dnsrecon sslscan || {
        echo "Failed to install some tools. Please check your internet connection and package manager." | tee -a "$LOG_FILE"
        exit 1
    }
    echo "All required tools have been installed!" | tee -a "$LOG_FILE"
    sleep 2
}

# Authentication Function
#authenticate_user() {
#    read -sp "Enter the password: "
#    if [[ "$password" != "thisispassword" ]]; then
#        echo -e "${RED}Authentication failed! Exiting...${NC}" | tee -a "$LOG_FILE"
#        exit 1
#    fi
#}

# Function to check network connectivity
check_network() {
    echo "Checking network connectivity..." | tee -a "$LOG_FILE"
    if ! ping -c 1 google.com &>/dev/null; then
        echo "No network connection. Please check your internet." | tee -a "$LOG_FILE"
        exit 1
    fi
}

# Function to display the logo with ASCII art and colors
display_logo() {
    clear
    toilet -f big "ENOLA-FINDS" --filter border | lolcat
    echo "****************************************************************************" | lolcat
    echo -e "${BOLD}${GREEN}** All rights reserved by HACKERS-PARADISE                                **${NC}" | lolcat
    echo "****************************************************************************" | lolcat
    echo -e "${BOLD}${GREEN}** An OSINT Information Gathering Tool                                    **${NC}" | lolcat
    echo "****************************************************************************" | lolcat
    echo -e "${BOLD}**   -Contributors :                                                      **${NC}" | lolcat
    echo -e "${WHITE}**   [ Yash Pawar        ]  - yashpawar1199@gmail.com                     **${NC}" | lolcat
    echo -e "${WHITE}**   [ Om Navale         ]  - omnavale930@gmail.com                       **${NC}" | lolcat
    echo -e "${WHITE}**   [ Siddhanth Gaikwad ]  - siddhanthgaikwad7@gmail                     **${NC}" | lolcat
    echo "****************************************************************************" | lolcat
}

# Function to show the main menu with colorful options
show_menu() {
    echo -e "\n${BOLD}${YELLOW}Choose an operation to perform:${NC}"
    echo -e "${GREEN}1. Nmap - Network Exploration and Security Auditing${NC}"
    echo -e "${GREEN}2. Whois - Domain Information Lookup${NC}"
    echo -e "${GREEN}3. DNSenum - DNS Enumeration${NC}"
    echo -e "${GREEN}4. Sublist3r - Fast Subdomains Enumeration${NC}"
    echo -e "${GREEN}5. Dirb - URL Bruteforce${NC}"
    echo -e "${GREEN}6. Gobuster - Directory and DNS Bruteforcer${NC}"
    echo -e "${GREEN}7. Nikto - Web Server Scanner${NC}"
    echo -e "${GREEN}8. WhatWeb - Website Fingerprinting${NC}"
    echo -e "${GREEN}9. WafW00f - Web Application Firewall Detection${NC}"
    echo -e "${GREEN}10. DNSrecon - DNS Enumeration and Brute Forcing${NC}"
    echo -e "${GREEN}11. SSLscan - SSL/TLS Security Testing${NC}"
    echo -e "${YELLOW}12. Run All Tools on Target${NC}"
    echo -e "${YELLOW}13. Schedule Scan${NC}"
    echo -e "${RED}14. Exit${NC}"
}

# Logging all output
log_output() {
    echo "Logging started: $(date)" > "$LOG_FILE"
}

# Function to run a tool
run_tool() {
    local tool=$1
    local command=$2
    echo -e "\nRunning $tool...\n" | tee -a "$LOG_FILE"
    eval "$command" | tee -a output.txt
    echo -e "\n$tool completed. Output saved." | tee -a "$LOG_FILE"
}

# Function to get user input for target and run the specified tool
get_target_and_run() {
    read -p "Enter the target domain or IP: " target
    run_tool "$1" "${2//<target>/$target}"
}

# Save the output to a file
save_output() {
    echo -e "\nDo you want to save the output to a text file? (yes/no)"
    read -r save_choice
    if [[ $save_choice == "yes" ]]; then
        read -r -p "Enter the file name to save the output: " filename
        mv output.txt "$filename.txt"
        echo "Output saved as $filename.txt" | tee -a "$LOG_FILE"
    else
        rm output.txt
        echo "Output discarded." | tee -a "$LOG_FILE"
    fi
}

# Generate HTML Report
generate_report() {
    echo "Generating report..." | tee -a "$LOG_FILE"
    echo "<html><head><title>Info-Paradise Report</title></head><body>" > report.html
    echo "<h1>Scan Results for $target</h1>" >> report.html
    cat output.txt >> report.html
    echo "</body></html>" >> report.html
    echo "Report generated as report.html" | tee -a "$LOG_FILE"
}

# Main script flow
log_output
authenticate_user
check_network
install_tools
display_logo

while true; do
    show_menu
    read -p "Enter your choice [1-14]: " choice
    case $choice in
        1) get_target_and_run "Nmap" "nmap -A -v <target>";;
        2) get_target_and_run "Whois" "whois <target>";;
        3) get_target_and_run "DNSenum" "dnsenum <target>";;
        4) get_target_and_run "Sublist3r" "sublist3r -d <target>";;
        5) get_target_and_run "Dirb" "dirb http://<target>";;
        6) get_target_and_run "Gobuster" "gobuster dir -u http://<target> -w /usr/share/wordlists/dirb/common.txt";;
        7) get_target_and_run "Nikto" "nikto -h http://<target>";;
        8) get_target_and_run "WhatWeb" "whatweb http://<target>";;
        9) get_target_and_run "WafW00f" "wafw00f http://<target>";;
        10) get_target_and_run "DNSrecon" "dnsrecon -d <target>";;
        11) get_target_and_run "SSLscan" "sslscan <target>";;
        12)
            echo -e "\nRunning all tools on target...";
            read -p "Enter the target domain or IP: " target;
            run_tool "Nmap" "nmap -A -v $target";
            run_tool "Whois" "whois $target";
            run_tool "DNSenum" "dnsenum $target";
            run_tool "Sublist3r" "sublist3r -d $target";
            run_tool "Dirb" "dirb http://$target";
            run_tool "Gobuster" "gobuster dir -u http://$target -w /usr/share/wordlists/dirb/common.txt";
            run_tool "Nikto" "nikto -h http://$target";
            run_tool "WhatWeb" "whatweb http://$target";
            run_tool "WafW00f" "wafw00f http://$target";
            run_tool "DNSrecon" "dnsrecon -d $target";
            run_tool "SSLscan" "sslscan $target";
            generate_report
            ;;
        13)
            schedule_scan;;
        14)
            echo "Exiting..." | tee -a "$LOG_FILE"
            exit 0;;
        *)
            echo -e "${RED}Invalid choice, please select a valid option.${NC}";;
    esac
    save_output
done
