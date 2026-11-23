#!/bin/bash
# Automated Grading Script for Lab 5 (Grand Capstone): EX188 Prerequisite Mock Exam (Sections 1-5)
# Must be executed as root / with sudo

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'
SCORE=0
TOTAL=5

echo "=================================================================="
echo "   AUTO-GRADER: LAB 5 (GRAND CAPSTONE EX188 — SECTIONS 1 TO 5)    "
echo "=================================================================="

# --- CHECK TASK 1 (Section 1): Dirs, grep -E/tee, index.html & Containerfile ---
CRIT_LOG="/opt/ex188-capstone/logs/critical-http.log"
CRIT_COUNT=$(grep -E -c "STATUS=500|STATUS=503" "$CRIT_LOG" 2>/dev/null)
CRIT_TOTAL=$(wc -l < "$CRIT_LOG" 2>/dev/null)
CF="/opt/ex188-capstone/src/Containerfile"
HTML="/opt/ex188-capstone/html/index.html"

T1_FAIL=0
[ ! -d "/opt/ex188-capstone/src" ] && T1_FAIL=1
[ ! -d "/opt/ex188-capstone/html" ] && T1_FAIL=1
[ ! -d "/opt/ex188-capstone/logs" ] && T1_FAIL=1
[ ! -d "/opt/ex188-capstone/reports" ] && T1_FAIL=1
[ "$CRIT_COUNT" != "3" ] || [ "$CRIT_TOTAL" != "3" ] && T1_FAIL=1
! grep -q "EX188_CAPSTONE_WEB_OK" "$HTML" 2>/dev/null && T1_FAIL=1
! grep -q "FROM registry.access.redhat.com/ubi9/ubi-minimal:latest" "$CF" 2>/dev/null && T1_FAIL=1
! grep -q 'LABEL exam="EX188-CAPSTONE"' "$CF" 2>/dev/null && T1_FAIL=1
! grep -q "USER 1001" "$CF" 2>/dev/null && T1_FAIL=1
! grep -q 'CMD \["python3", "-m", "http.server", "8080"\]' "$CF" 2>/dev/null && T1_FAIL=1

if [ "$T1_FAIL" -eq 0 ]; then
    echo -e "[ ${GREEN}PASS${NC} ] Task 1 (Section 1): Directories, grep/tee critical logs, index.html & Containerfile verified."
    ((SCORE++))
else
    echo -e "[ ${RED}FAIL${NC} ] Task 1 (Section 1): Check dirs, critical-http.log (3 lines), html/index.html, and src/Containerfile."
fi

# --- CHECK TASK 2 (Section 2): User, Group & SGID (2775) ---
CAP_UID=$(id -u capuser 2>/dev/null)
CAP_GRPS=$(id -Gn capuser 2>/dev/null)
HTML_PERM=$(stat -c "%a" /opt/ex188-capstone/html 2>/dev/null)
HTML_GRP=$(stat -c "%G" /opt/ex188-capstone/html 2>/dev/null)

if [ "$CAP_UID" == "1088" ] && echo "$CAP_GRPS" | grep -qw "capteam" && grep -q "uid=1088(capuser)" /opt/ex188-capstone/reports/capuser-id.txt 2>/dev/null && [ "$HTML_PERM" == "2775" ] && [ "$HTML_GRP" == "capteam" ]; then
    echo -e "[ ${GREEN}PASS${NC} ] Task 2 (Section 2): User capuser (UID 1088, group capteam) & SGID 2775 on html/ verified."
    ((SCORE++))
else
    echo -e "[ ${RED}FAIL${NC} ] Task 2 (Section 2): Check capuser (UID 1088, capteam), reports/capuser-id.txt, and html/ perm=${HTML_PERM:-missing} grp=${HTML_GRP:-none}."
fi

# --- CHECK TASK 3 (Section 3): kill -9, Env File, systemd, journalctl & df ---
EXP_PID=$(cat /opt/ex188-capstone/.expected_pid 2>/dev/null | tr -d '[:space:]')
KILLED_PID=$(cat /opt/ex188-capstone/reports/killed-pid.txt 2>/dev/null | tr -d '[:space:]')
STILL_STUCK=$(pgrep -f capstone-stuck-job.sh 2>/dev/null)
SVC_ACTIVE=$(systemctl is-active ex188-capstone.service 2>/dev/null)
SVC_ENABLED=$(systemctl is-enabled ex188-capstone.service 2>/dev/null)
J_FILE="/opt/ex188-capstone/reports/journal-capstone.txt"
DISK_FILE="/opt/ex188-capstone/reports/disk.txt"

if [ -n "$KILLED_PID" ] && [ "$KILLED_PID" == "$EXP_PID" ] && [ -z "$STILL_STUCK" ] && [ "$SVC_ACTIVE" == "active" ] && [ "$SVC_ENABLED" == "enabled" ] && grep -q "CAPSTONE_SERVICE_READY" "$J_FILE" 2>/dev/null && grep -q "Filesystem" "$DISK_FILE" 2>/dev/null; then
    echo -e "[ ${GREEN}PASS${NC} ] Task 3 (Section 3): Stuck job killed (-9), systemd service active+enabled, journalctl & df saved."
    ((SCORE++))
else
    echo -e "[ ${RED}FAIL${NC} ] Task 3 (Section 3): Check killed-pid.txt (expected $EXP_PID), ex188-capstone.service ($SVC_ACTIVE/$SVC_ENABLED), journal-capstone.txt & disk.txt."
fi

# --- CHECK TASK 4 (Section 4): ss, curl, SSH Keys, scp & firewalld ---
P8095="/opt/ex188-capstone/reports/port-8095.txt"
C8095="/opt/ex188-capstone/reports/curl-8095.txt"
SCP_CF="/opt/ex188-capstone/reports/Containerfile.scp"
FW_FILE="/opt/ex188-capstone/reports/firewall.txt"
FW_ACTIVE=$(systemctl is-active firewalld 2>/dev/null)

if grep -q "8095" "$P8095" 2>/dev/null && grep -q "EX188_CAPSTONE_WEB_OK" "$C8095" 2>/dev/null && [ -f "/opt/ex188-capstone/id_capstone" ] && grep -q 'LABEL exam="EX188-CAPSTONE"' "$SCP_CF" 2>/dev/null && [ "$FW_ACTIVE" == "active" ] && grep -q "8095/tcp" "$FW_FILE" 2>/dev/null; then
    echo -e "[ ${GREEN}PASS${NC} ] Task 4 (Section 4): ss port 8095, curl endpoint, scp transfer & firewalld 8095/tcp verified."
    ((SCORE++))
else
    echo -e "[ ${RED}FAIL${NC} ] Task 4 (Section 4): Check port-8095.txt, curl-8095.txt, id_capstone, Containerfile.scp, and firewall.txt (8095/tcp)."
fi

# --- CHECK TASK 5 (Section 5): SELinux Context (container_file_t) & Podman ---
SE_MODE="/opt/ex188-capstone/reports/selinux-mode.txt"
SE_CTX="/opt/ex188-capstone/reports/selinux-context.txt"
POD_VER="/opt/ex188-capstone/reports/podman-version.txt"

if [ -s "$SE_MODE" ] && grep -q "container_file_t" "$SE_CTX" 2>/dev/null && ls -Zd /opt/ex188-capstone/html 2>/dev/null | grep -q "container_file_t" && grep -qi "podman version" "$POD_VER" 2>/dev/null; then
    echo -e "[ ${GREEN}PASS${NC} ] Task 5 (Section 5): SELinux mode/context (container_file_t) & Podman readiness verified."
    ((SCORE++))
else
    echo -e "[ ${RED}FAIL${NC} ] Task 5 (Section 5): Check selinux-mode.txt, selinux-context.txt (container_file_t on html/), and podman-version.txt."
fi

echo "=================================================================="
echo -e "  FINAL CAPSTONE SCORE: ${YELLOW}${SCORE} / ${TOTAL}${NC}"
if [ "$SCORE" -eq "$TOTAL" ]; then
    echo -e "  ${GREEN}OUTSTANDING! YOU ARE 100% READY FOR EX188 PRACTICE EXAMS!${NC}"
fi
echo "=================================================================="
