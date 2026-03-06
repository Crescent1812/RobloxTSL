import os
import time

LOG_DIR = "site-logs"
MAX_LOGS = 20  # keep the newest 20 logs

def ensure_log_dir():
    """Create the log directory if it doesn't exist."""
    if not os.path.exists(LOG_DIR):
        os.makedirs(LOG_DIR)

def clean_old_logs():
    """Remove old logs, keeping only the newest MAX_LOGS."""
    ensure_log_dir()

    files = [
        os.path.join(LOG_DIR, f)
        for f in os.listdir(LOG_DIR)
        if os.path.isfile(os.path.join(LOG_DIR, f))
    ]

    # Sort by modification time (newest first)
    files.sort(key=lambda x: os.path.getmtime(x), reverse=True)

    # Delete older logs
    for old_file in files[MAX_LOGS:]:
        try:
            os.remove(old_file)
        except Exception:
            pass  # never crash MkDocs

def write_log(message):
    """Write a timestamped log entry."""
    ensure_log_dir()

    timestamp = time.strftime("%Y-%m-%d_%H-%M-%S")
    filename = os.path.join(LOG_DIR, f"log_{timestamp}.txt")

    with open(filename, "w", encoding="utf-8") as f:
        f.write(message)

    clean_old_logs()