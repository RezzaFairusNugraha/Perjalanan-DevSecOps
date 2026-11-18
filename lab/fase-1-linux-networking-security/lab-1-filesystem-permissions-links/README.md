# Hands-On Lab 1: Linux File System, Permissions, Redirects & Links

Welcome to **Lab 1** of Phase 1! Complete the tasks below inside your Linux terminal.

## How to Use This Lab
1. Initialize or reset the clean lab environment:
   ```bash
   bash setup-lab.sh
   ```
2. Read and complete **Task 1** through **Task 5** below.
3. Run the automated grading script at any time to verify your score:
   ```bash
   bash grade-lab.sh
   ```

---

## Tasks

### Task 1: Build the Directory Structure (`mkdir -p`, `cp -r`)
1. Inside `~/app-deploy`, create three subdirectories:
   - `configs`
   - `scripts`
   - `logs`
2. Copy the `configs` directory recursively to `~/app-deploy/configs-backup`.

---

### Task 2: Text Creation, Redirection (`>`, `>>`), and `tee`
1. Create the file `~/app-deploy/scripts/deploy.sh`.
2. Write `#!/bin/bash` as the first line using `>`.
3. Append `echo "Starting Deployment"` as the second line using `>>`.
4. Run `uname -a` and pipe it into `tee` so the output is saved to `~/app-deploy/logs/system_info.log`.

---

### Task 3: Configure Numeric Permissions (`chmod`)
1. Change permissions on `~/app-deploy/scripts/deploy.sh` to **`755`** (`rwxr-xr-x`).
2. Create `~/app-deploy/configs/database.env` with the text `DB_PASS=secret123`.
3. Change permissions on `~/app-deploy/configs/database.env` to **`600`** (`rw-------`).

---

### Task 4: Wildcards and Finding Files (`find`, wildcards)
1. Inside `~/app-deploy/configs`, create three empty files:
   - `web-1.conf`
   - `web-2.conf`
   - `web-test.conf`
2. Practice listing only `web-1.conf` and `web-2.conf` using bracket wildcards: `ls ~/app-deploy/configs/web-[12].conf`.
3. Find all `.conf` files inside `~/app-deploy` and save the list of found paths into `~/app-deploy/logs/found_configs.txt` using:
   ```bash
   find ~/app-deploy -name "*.conf" > ~/app-deploy/logs/found_configs.txt
   ```

---

### Task 5: Hard Links and Symbolic Links (`ln`, `ln -s`)
1. Create a file `~/app-deploy/configs/master.conf` with the text `SERVER_PORT=8080`.
2. Create a **hard link** named `~/app-deploy/configs/hard_master.conf` pointing to `~/app-deploy/configs/master.conf`.
3. Create a **symbolic (soft) link** named `~/app-deploy/quick_access.conf` pointing to `~/app-deploy/configs/master.conf`.
4. Rename the original `~/app-deploy/configs/master.conf` to `~/app-deploy/configs/master.conf.bak`.
   *(Notice how `hard_master.conf` still works, while `quick_access.conf` becomes a broken link!)*
