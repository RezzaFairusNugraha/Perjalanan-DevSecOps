#!/bin/bash
# Automated Grading Script for Lab 3: Systemd, Processes, Logs & Environment Variables
# Must be executed as root / with sudo

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'
SCORE=0
TOTAL=5

echo "============================================================"
echo "  AUTO-GRADER: LAB 3 (SYSTEMD, PROCESSES, LOGS & ENV VARS)  "
echo "============================================================"

# --- CHECK TASK 1: Rogue Process Inspection & Termination (kill -9) ---
EXPECTED_PID=$(cat /opt/ex188-lab3/.expected_pid 2>/dev/null | tr -d '[:space:]')
SAVED_PID=$(cat /opt/ex188-lab3/rogue-pid.txt 2>/dev/null | tr -d '[:space:]')
STILL_RUNNING=$(pgrep -f ex188-rogue-worker.sh 2>/dev/null)

if [ -n "$SAVED_PID" ] && [ "$SAVED_PID" == "$EXPECTED_PID" ] && [ -z "$STILL_RUNNING" ]; then
    echo -e "[ ${GREEN}PASS${NC} ] Task 1: Rogue worker PID ($EXPECTED_PID) recorded in rogue-pid.txt and terminated with SIGKILL."
    ((SCORE++))
else
    echo -e "[ ${RED}FAIL${NC} ] Task 1: Check /opt/ex188-lab3/rogue-pid.txt (expected PID: ${EXPECTED_PID:-unknown}) and ensure ex188-rogue-worker.sh is killed."
fi

# --- CHECK TASK 2: Environment Variables ---
ENV_FILE="/opt/ex188-lab3/agent.env"
PROF_FILE="/etc/profile.d/ex188.sh"

if [ -f "$ENV_FILE" ] && grep -q "^CONTAINER_ENV=production$" "$ENV_FILE" && grep -q "^APP_PORT=9090$" "$ENV_FILE" && [ -f "$PROF_FILE" ] && grep -q "export EX188_READY=true" "$PROF_FILE"; then
    echo -e "[ ${GREEN}PASS${NC} ] Task 2: Environment file (/opt/ex188-lab3/agent.env) and /etc/profile.d/ex188.sh configured."
    ((SCORE++))
else
    echo -e "[ ${RED}FAIL${NC} ] Task 2: Check /opt/ex188-lab3/agent.env (CONTAINER_ENV=production, APP_PORT=9090) and /etc/profile.d/ex188.sh."
fi

# --- CHECK TASK 3: Systemd Service (enable --now) ---
IS_ACTIVE=$(systemctl is-active ex188-agent.service 2>/dev/null)
IS_ENABLED=$(systemctl is-enabled ex188-agent.service 2>/dev/null)

if [ "$IS_ACTIVE" == "active" ] && [ "$IS_ENABLED" == "enabled" ]; then
    echo -e "[ ${GREEN}PASS${NC} ] Task 3: Service ex188-agent.service is both active (running) and enabled at boot."
    ((SCORE++))
else
    echo -e "[ ${RED}FAIL${NC} ] Task 3: ex188-agent.service status is active=$IS_ACTIVE, enabled=$IS_ENABLED (expected active & enabled)."
fi

# --- CHECK TASK 4: journalctl Log Extraction ---
JLOG="/opt/ex188-lab3/reports/journal-agent.log"
if [ -s "$JLOG" ] && grep -q "EX188-SYSTEMD-OK" "$JLOG" && grep -q "CONTAINER_ENV=production" "$JLOG" && grep -q "APP_PORT=9090" "$JLOG"; then
    echo -e "[ ${GREEN}PASS${NC} ] Task 4: Systemd journal logs filtered and saved to reports/journal-agent.log."
    ((SCORE++))
else
    echo -e "[ ${RED}FAIL${NC} ] Task 4: Check /opt/ex188-lab3/reports/journal-agent.log (must contain EX188-SYSTEMD-OK with production & 9090)."
fi

# --- CHECK TASK 5: Resource Monitoring (df -h & free -m) ---
DISK_FILE="/opt/ex188-lab3/reports/disk-usage.txt"
MEM_FILE="/opt/ex188-lab3/reports/memory-usage.txt"

if [ -s "$DISK_FILE" ] && grep -q "Filesystem" "$DISK_FILE" && [ -s "$MEM_FILE" ] && grep -q "Mem:" "$MEM_FILE"; then
    echo -e "[ ${GREEN}PASS${NC} ] Task 5: Disk usage (df -h /) and memory usage (free -m) reports saved."
    ((SCORE++))
else
    echo -e "[ ${RED}FAIL${NC} ] Task 5: Check /opt/ex188-lab3/reports/disk-usage.txt (df -h /) and memory-usage.txt (free -m)."
fi

echo "============================================================"
echo -e "  FINAL SCORE: ${YELLOW}${SCORE} / ${TOTAL}${NC}"
if [ "$SCORE" -eq "$TOTAL" ]; then
    echo -e "  ${GREEN}EXCELLENT! YOU HAVE MASTERED SYSTEMD, PROCESSES, LOGS & ENV VARS!${NC}"
fi
echo "============================================================"
