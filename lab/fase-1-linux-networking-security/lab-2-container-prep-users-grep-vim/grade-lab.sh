#!/bin/bash
# Automated Grading Script for Lab 2

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'
SCORE=0
TOTAL=5

echo "========================================================"
echo "   AUTO-GRADER: LAB 2 (CONTAINER PREP & USER SECURITY)  "
echo "========================================================"

# --- CHECK TASK 1: File Maintenance ---
if [ -d "/opt/container-lab/web/html" ] && [ -f "/opt/container-lab/web/html/index.html" ] && [ ! -f "/tmp/staging-data/index.html" ] && [ ! -f "/tmp/staging-data/old-trash.tmp" ]; then
    echo -e "[ ${GREEN}PASS${NC} ] Task 1: Bind mount folders created, index.html moved, and old-trash.tmp removed."
    ((SCORE++))
else
    echo -e "[ ${RED}FAIL${NC} ] Task 1: Check /opt/container-lab/web/html/index.html exists and /tmp/staging-data/old-trash.tmp is deleted."
fi

# --- CHECK TASK 2: grep, egrep, tail ---
ERR_COUNT=$(grep -c "ERROR" /opt/container-lab/logs/errors.txt 2>/dev/null)
ERR_TOTAL=$(wc -l < /opt/container-lab/logs/errors.txt 2>/dev/null)
NET_COUNT=$(grep -Ec "IP=|PORT=" /opt/container-lab/logs/network.txt 2>/dev/null)
LATEST_COUNT=$(wc -l < /opt/container-lab/logs/latest.txt 2>/dev/null)

if [ "$ERR_COUNT" == "2" ] && [ "$ERR_TOTAL" == "2" ] && [ "$NET_COUNT" == "3" ] && [ "$LATEST_COUNT" == "3" ]; then
    echo -e "[ ${GREEN}PASS${NC} ] Task 2: Log filtering with grep, egrep, and tail verified."
    ((SCORE++))
else
    echo -e "[ ${RED}FAIL${NC} ] Task 2: Check errors.txt (2 ERROR lines), network.txt (3 IP=/PORT= lines), and latest.txt (last 3 lines)."
fi

# --- CHECK TASK 3: Containerfile via vi/vim ---
CF="/opt/container-lab/Containerfile"
if [ -f "$CF" ] && grep -q "FROM registry.access.redhat.com/ubi9/ubi-minimal" "$CF" && grep -q "USER 1001" "$CF" && grep -q "EXPOSE 8080" "$CF" && grep -q 'CMD \["echo", "Hello EX188"\]' "$CF"; then
    echo -e "[ ${GREEN}PASS${NC} ] Task 3: Containerfile created accurately using vi/vim."
    ((SCORE++))
else
    echo -e "[ ${RED}FAIL${NC} ] Task 3: Check /opt/container-lab/Containerfile content (FROM, USER 1001, EXPOSE 8080, CMD)."
fi

# --- CHECK TASK 4: Users, Groups, UID & id ---
POD_UID=$(id -u poduser 2>/dev/null)
POD_GROUPS=$(id -Gn poduser 2>/dev/null)

if [ "$POD_UID" == "1050" ] && echo "$POD_GROUPS" | grep -qw "devteam" && grep -q "uid=1050(poduser)" /opt/container-lab/logs/poduser-id.txt 2>/dev/null; then
    echo -e "[ ${GREEN}PASS${NC} ] Task 4: User poduser (UID 1050) in group devteam & id output saved."
    ((SCORE++))
else
    echo -e "[ ${RED}FAIL${NC} ] Task 4: Check poduser UID (expected 1050), group devteam membership, and /opt/container-lab/logs/poduser-id.txt."
fi

# --- CHECK TASK 5: Special Permissions (SGID & Sticky Bit) ---
TEAM_PERM=$(stat -c "%a" /opt/container-lab/shared-team 2>/dev/null)
TEAM_GRP=$(stat -c "%G" /opt/container-lab/shared-team 2>/dev/null)
DROP_PERM=$(stat -c "%a" /opt/container-lab/shared-drop 2>/dev/null)

if [ "$TEAM_PERM" == "2770" ] && [ "$TEAM_GRP" == "devteam" ] && [ "$DROP_PERM" == "1777" ]; then
    echo -e "[ ${GREEN}PASS${NC} ] Task 5: SGID (2770, group devteam) and Sticky Bit (1777) configured properly."
    ((SCORE++))
else
    echo -e "[ ${RED}FAIL${NC} ] Task 5: shared-team is ${TEAM_PERM:-missing} (group: ${TEAM_GRP:-none}, expected 2770 devteam); shared-drop is ${DROP_PERM:-missing} (expected 1777)."
fi

echo "========================================================"
echo -e "  FINAL SCORE: ${YELLOW}${SCORE} / ${TOTAL}${NC}"
if [ "$SCORE" -eq "$TOTAL" ]; then
    echo -e "  ${GREEN}EXCELLENT! YOU ARE READY FOR EX188 LINUX BASICS!${NC}"
fi
echo "========================================================"
