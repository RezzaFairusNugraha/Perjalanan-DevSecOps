#!/bin/bash
# Automated Grading Script for Lab 2 (v2)
# Must be executed with root/sudo

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'
SCORE=0
TOTAL=5

echo "========================================================"
echo "    AUTO-GRADER: LAB 2 (EX188 CONTAINER PREP & USERS)   "
echo "========================================================"

# --- CHECK TASK 1: Staging Storage & File Maintenance ---
T1_FAIL=0
[ ! -d "/opt/container-lab/app/data" ] && T1_FAIL=1
[ ! -d "/opt/container-lab/app/conf" ] && T1_FAIL=1
[ ! -f "/opt/container-lab/app/conf/app.conf" ] && T1_FAIL=1
[ ! -f "/opt/container-lab/app/conf/.env" ] && T1_FAIL=1
[ -d "/tmp/staging-ex188" ] && T1_FAIL=1

if [ "$T1_FAIL" -eq 0 ]; then
    echo -e "[ ${GREEN}PASS${NC} ] Task 1: Storage folders created, conf & .env placed, and staging cleaned."
    ((SCORE++))
else
    echo -e "[ ${RED}FAIL${NC} ] Task 1: Check /opt/container-lab/app/{data,conf}, app.conf, .env, and remove /tmp/staging-ex188."
fi

# --- CHECK TASK 2: Log Filtering (grep -E, tail) ---
ALERTS_COUNT=$(grep -E -c "CRITICAL|FATAL" /opt/container-lab/logs/alerts.txt 2>/dev/null)
ALERTS_TOTAL=$(wc -l < /opt/container-lab/logs/alerts.txt 2>/dev/null)
CONN_COUNT=$(grep -c "REMOTE_ADDR=" /opt/container-lab/logs/connections.txt 2>/dev/null)
RECENT_COUNT=$(wc -l < /opt/container-lab/logs/recent.txt 2>/dev/null)

if [ "$ALERTS_COUNT" == "3" ] && [ "$ALERTS_TOTAL" == "3" ] && [ "$CONN_COUNT" == "4" ] && [ "$RECENT_COUNT" == "5" ]; then
    echo -e "[ ${GREEN}PASS${NC} ] Task 2: Log parsing (alerts: 3 lines, connections: 4 lines, recent: 5 lines) verified."
    ((SCORE++))
else
    echo -e "[ ${RED}FAIL${NC} ] Task 2: Check alerts.txt (3 lines of CRITICAL|FATAL), connections.txt (4 REMOTE_ADDR lines), and recent.txt (last 5 lines)."
fi

# --- CHECK TASK 3: Containerfile via vi/vim ---
CF="/opt/container-lab/Containerfile"
T3_FAIL=0
[ ! -f "$CF" ] && T3_FAIL=1
! grep -q "FROM registry.access.redhat.com/ubi9/ubi-minimal:latest" "$CF" 2>/dev/null && T3_FAIL=1
! grep -q 'LABEL maintainer="student@ex188.lab"' "$CF" 2>/dev/null && T3_FAIL=1
! grep -q "WORKDIR /app" "$CF" 2>/dev/null && T3_FAIL=1
! grep -q "USER 1001" "$CF" 2>/dev/null && T3_FAIL=1
! grep -q "EXPOSE 8080" "$CF" 2>/dev/null && T3_FAIL=1
! grep -q 'CMD \["python3", "-m", "http.server", "8080"\]' "$CF" 2>/dev/null && T3_FAIL=1

if [ "$T3_FAIL" -eq 0 ]; then
    echo -e "[ ${GREEN}PASS${NC} ] Task 3: Containerfile written accurately with vi/vim (UBI9, non-root USER 1001)."
    ((SCORE++))
else
    echo -e "[ ${RED}FAIL${NC} ] Task 3: Check /opt/container-lab/Containerfile (FROM UBI9, LABEL, WORKDIR, USER 1001, EXPOSE, CMD)."
fi

# --- CHECK TASK 4: User, Group & SubUID Check ---
APP_UID=$(id -u apprunner 2>/dev/null)
APP_GROUPS=$(id -Gn apprunner 2>/dev/null)
APP_INFO_CHECK=$(grep -q "uid=1024(apprunner)" /opt/container-lab/logs/apprunner-info.txt 2>/dev/null && echo "ok")

if [ "$APP_UID" == "1024" ] && echo "$APP_GROUPS" | grep -qw "engineers" && [ "$APP_INFO_CHECK" == "ok" ]; then
    echo -e "[ ${GREEN}PASS${NC} ] Task 4: User apprunner (UID 1024, group engineers) and apprunner-info.txt verified."
    ((SCORE++))
else
    echo -e "[ ${RED}FAIL${NC} ] Task 4: Check user apprunner (UID 1024), group engineers, and /opt/container-lab/logs/apprunner-info.txt."
fi

# --- CHECK TASK 5: Special Permissions (SGID & Sticky Bit) ---
TEAM_PERM=$(stat -c "%a" /opt/container-lab/shared-workspace 2>/dev/null)
TEAM_GRP=$(stat -c "%G" /opt/container-lab/shared-workspace 2>/dev/null)
DROP_PERM=$(stat -c "%a" /opt/container-lab/public-drop 2>/dev/null)

if [ "$TEAM_PERM" == "2770" ] && [ "$TEAM_GRP" == "engineers" ] && [ "$DROP_PERM" == "1777" ]; then
    echo -e "[ ${GREEN}PASS${NC} ] Task 5: SGID (2770 on shared-workspace) and Sticky Bit (1777 on public-drop) verified."
    ((SCORE++))
else
    echo -e "[ ${RED}FAIL${NC} ] Task 5: shared-workspace is ${TEAM_PERM:-missing} (expected 2770 engineers); public-drop is ${DROP_PERM:-missing} (expected 1777)."
fi

echo "========================================================"
echo -e "  FINAL SCORE: ${YELLOW}${SCORE} / ${TOTAL}${NC}"
if [ "$SCORE" -eq "$TOTAL" ]; then
    echo -e "  ${GREEN}EXCELLENT! YOU HAVE MASTERED EX188 LINUX PREREQUISITES!${NC}"
fi
echo "========================================================"
