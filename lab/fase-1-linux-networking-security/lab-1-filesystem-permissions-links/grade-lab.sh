#!/bin/bash
# Automated Grading Script for Lab 1: Linux File System & Permissions

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'
SCORE=0
TOTAL=5

echo "===================================================="
echo "    AUTO-GRADER: LAB 1 (FILESYSTEM & PERMISSIONS)   "
echo "===================================================="

# --- CHECK TASK 1 ---
if [ -d "$HOME/app-deploy/configs" ] && [ -d "$HOME/app-deploy/scripts" ] && [ -d "$HOME/app-deploy/logs" ] && [ -d "$HOME/app-deploy/configs-backup" ]; then
    echo -e "[ ${GREEN}PASS${NC} ] Task 1: Directory structure & backup folder created correctly."
    ((SCORE++))
else
    echo -e "[ ${RED}FAIL${NC} ] Task 1: Missing directories in ~/app-deploy (Expected: configs, scripts, logs, configs-backup)."
fi

# --- CHECK TASK 2 ---
if [ -f "$HOME/app-deploy/scripts/deploy.sh" ] && grep -q "#!/bin/bash" "$HOME/app-deploy/scripts/deploy.sh" && grep -q "Starting Deployment" "$HOME/app-deploy/scripts/deploy.sh" && [ -s "$HOME/app-deploy/logs/system_info.log" ]; then
    echo -e "[ ${GREEN}PASS${NC} ] Task 2: Redirects (>, >>) and tee log file verified."
    ((SCORE++))
else
    echo -e "[ ${RED}FAIL${NC} ] Task 2: Check scripts/deploy.sh content or logs/system_info.log."
fi

# --- CHECK TASK 3 ---
PERM_SCRIPT=$(stat -c "%a" "$HOME/app-deploy/scripts/deploy.sh" 2>/dev/null)
PERM_DB=$(stat -c "%a" "$HOME/app-deploy/configs/database.env" 2>/dev/null)

if [ "$PERM_SCRIPT" == "755" ] && [ "$PERM_DB" == "600" ]; then
    echo -e "[ ${GREEN}PASS${NC} ] Task 3: Permissions (755 on deploy.sh and 600 on database.env) are correct."
    ((SCORE++))
else
    echo -e "[ ${RED}FAIL${NC} ] Task 3: Wrong permissions (deploy.sh is ${PERM_SCRIPT:-missing}, expected 755; database.env is ${PERM_DB:-missing}, expected 600)."
fi

# --- CHECK TASK 4 ---
if [ -f "$HOME/app-deploy/configs/web-1.conf" ] && [ -f "$HOME/app-deploy/configs/web-2.conf" ] && [ -f "$HOME/app-deploy/configs/web-test.conf" ] && [ -s "$HOME/app-deploy/logs/found_configs.txt" ]; then
    echo -e "[ ${GREEN}PASS${NC} ] Task 4: All .conf files exist & find output saved to logs/found_configs.txt."
    ((SCORE++))
else
    echo -e "[ ${RED}FAIL${NC} ] Task 4: Missing web-*.conf files in configs/ or missing logs/found_configs.txt."
fi

# --- CHECK TASK 5 ---
INODE_HARD=$(stat -c "%i" "$HOME/app-deploy/configs/hard_master.conf" 2>/dev/null)
INODE_BAK=$(stat -c "%i" "$HOME/app-deploy/configs/master.conf.bak" 2>/dev/null)

if [ -n "$INODE_HARD" ] && [ "$INODE_HARD" == "$INODE_BAK" ] && [ -L "$HOME/app-deploy/quick_access.conf" ]; then
    echo -e "[ ${GREEN}PASS${NC} ] Task 5: Hard link shares same inode with master.conf.bak & symbolic link verified."
    ((SCORE++))
else
    echo -e "[ ${RED}FAIL${NC} ] Task 5: Check hard_master.conf, master.conf.bak (must share same inode), and symlink quick_access.conf."
fi

echo "===================================================="
echo -e "  FINAL SCORE: ${YELLOW}${SCORE} / ${TOTAL}${NC}"
if [ "$SCORE" -eq "$TOTAL" ]; then
    echo -e "  ${GREEN}CONGRATULATIONS! ALL TASKS COMPLETED PERFECTLY!${NC}"
fi
echo "===================================================="
