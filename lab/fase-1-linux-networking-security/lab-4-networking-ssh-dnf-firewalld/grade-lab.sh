#!/bin/bash
# Automated Grading Script for Lab 4: Networking (ss, curl), SSH Keys, scp, dnf/rpm & firewalld
# Must be executed as root / with sudo

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'
SCORE=0
TOTAL=5

echo "================================================================"
echo "  AUTO-GRADER: LAB 4 (NETWORKING, SSH, SCP, DNF/RPM & FIREWALLD)"
echo "================================================================"

# --- CHECK TASK 1: Package Management (dnf & rpm) ---
RPM_FILE="/opt/ex188-lab4/reports/rpm-firewalld.txt"
if command -v host >/dev/null 2>&1 && [ -s "$RPM_FILE" ] && grep -q "^firewalld-" "$RPM_FILE"; then
    echo -e "[ ${GREEN}PASS${NC} ] Task 1: bind-utils installed and rpm -q firewalld recorded."
    ((SCORE++))
else
    echo -e "[ ${RED}FAIL${NC} ] Task 1: Ensure bind-utils is installed (dnf install -y bind-utils) and rpm -q firewalld is saved to $RPM_FILE."
fi

# --- CHECK TASK 2: Socket Inspection (ss) & Endpoint Verification (curl) ---
PORT_FILE="/opt/ex188-lab4/reports/port-8091.txt"
CURL_FILE="/opt/ex188-lab4/reports/curl-response.txt"

if [ -s "$PORT_FILE" ] && grep -q "8091" "$PORT_FILE" && [ -s "$CURL_FILE" ] && grep -q "EX188_NET_LAB_OK" "$CURL_FILE"; then
    echo -e "[ ${GREEN}PASS${NC} ] Task 2: Listening port 8091 captured via ss -tulpn and endpoint verified via curl."
    ((SCORE++))
else
    echo -e "[ ${RED}FAIL${NC} ] Task 2: Check $PORT_FILE (ss -tulpn | grep 8091) and $CURL_FILE (curl http://127.0.0.1:8091/index.html)."
fi

# --- CHECK TASK 3: Passwordless SSH Keys & scp Transfer ---
KEY_FILE="/opt/ex188-lab4/ssh/id_ex188"
DEPLOYED_FILE="/opt/ex188-lab4/deployed-payload.conf"

if [ -f "$KEY_FILE" ] && [ -f "${KEY_FILE}.pub" ] && [ -f "$DEPLOYED_FILE" ] && grep -q "SCP_ED25519_VERIFIED" "$DEPLOYED_FILE"; then
    echo -e "[ ${GREEN}PASS${NC} ] Task 3: SSH key pair generated and secret-payload.conf transferred via scp."
    ((SCORE++))
else
    echo -e "[ ${RED}FAIL${NC} ] Task 3: Check SSH key at $KEY_FILE and ensure $DEPLOYED_FILE was copied via scp."
fi

# --- CHECK TASK 4: firewalld Port & Service Configuration ---
FW_STATUS_FILE="/opt/ex188-lab4/reports/firewall-status.txt"
FW_ACTIVE=$(systemctl is-active firewalld 2>/dev/null)

if [ "$FW_ACTIVE" == "active" ] && [ -s "$FW_STATUS_FILE" ] && grep -q "8091/tcp" "$FW_STATUS_FILE" && grep -q "http" "$FW_STATUS_FILE"; then
    echo -e "[ ${GREEN}PASS${NC} ] Task 4: firewalld is active, 8091/tcp & http service opened permanently, and status saved."
    ((SCORE++))
else
    echo -e "[ ${RED}FAIL${NC} ] Task 4: Ensure firewalld is active, 8091/tcp and http are added (--permanent & --reload), and saved to $FW_STATUS_FILE."
fi

# --- CHECK TASK 5: Outbound Direct Rule ---
DIRECT_FILE="/opt/ex188-lab4/reports/direct-rules.txt"

if [ -s "$DIRECT_FILE" ] && grep -q "198.51.100.99" "$DIRECT_FILE" && grep -q "DROP" "$DIRECT_FILE"; then
    echo -e "[ ${GREEN}PASS${NC} ] Task 5: Outbound DROP direct rule for 198.51.100.99 verified in $DIRECT_FILE."
    ((SCORE++))
else
    echo -e "[ ${RED}FAIL${NC} ] Task 5: Check direct rule for 198.51.100.99 and save 'firewall-cmd --direct --get-all-rules' to $DIRECT_FILE."
fi

echo "================================================================"
echo -e "  FINAL SCORE: ${YELLOW}${SCORE} / ${TOTAL}${NC}"
if [ "$SCORE" -eq "$TOTAL" ]; then
    echo -e "  ${GREEN}EXCELLENT! YOU HAVE MASTERED NETWORKING, SSH, SCP, DNF & FIREWALLD!${NC}"
fi
echo "================================================================"
