# macros/main.py

import datetime
import json
import os
import yaml

def define_env(env):
    """
    This function is executed once when MkDocs starts.
    You can define macros, filters, and global variables here.
    """

    # ---------------------------------------------------------
    # Global variables
    # ---------------------------------------------------------
    env.variables["project_name"] = "My Project"
    env.variables["build_year"] = datetime.datetime.now().year

    # Load version from a file if it exists
    version_file = "version.txt"
    if os.path.exists(version_file):
        with open(version_file, "r") as f:
            env.variables["project_version"] = f.read().strip()
    else:
        env.variables["project_version"] = "0.0.0"

    # ---------------------------------------------------------
    # Macros
    # ---------------------------------------------------------

    @env.macro
    def shout(text):
        """Return text in uppercase."""
        return text.upper()

    @env.macro
    def badge(label, color="blue"):
        """Generate a simple badge."""
        return f"<span style='background:{color};padding:4px 8px;border-radius:4px;color:white'>{label}</span>"

    @env.macro
    def load_json(path):
        """Load a JSON file and return its contents."""
        with open(path, "r") as f:
            return json.load(f)

    @env.macro
    def load_yaml(path):
        """Load a YAML file and return its contents."""
        with open(path, "r") as f:
            return yaml.safe_load(f)

    @env.macro
    def table(headers, rows):
        """
        Generate a Markdown table.
        headers: list
        rows: list of lists
        """
        header_row = " | ".join(headers)
        separator = " | ".join(["---"] * len(headers))
        body = "\n".join([" | ".join(map(str, r)) for r in rows])
        return f"{header_row}\n{separator}\n{body}"

    # ---------------------------------------------------------
    # Filters
    # ---------------------------------------------------------

    @env.filter
    def reverse(value):
        return value[::-1]

    @env.filter
    def lowercase(value):
        return value.lower()

    @env.filter
    def uppercase(value):
        return value.upper()