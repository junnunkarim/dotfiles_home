import sqlite3
from pathlib import Path


class DatabaseManager:
    def __init__(self, db_path: Path):
        """
        Initialize the DatabaseManager.
        This opens a connection to the given SQLite database and initializes the schema if necessary.
        """
        self.db_path = db_path
        self.conn = sqlite3.connect(self.db_path)
        self.conn.execute("PRAGMA foreign_keys = ON;")

        self.init_db()

    def init_db(self):
        """Initialize the database schema in a modular fashion."""
        self.create_tables()
        self.create_triggers()
        self.create_default_group()

        self.conn.commit()

    def create_tables(self):
        """Create the 'groups' and 'tabs' tables if they do not exist."""
        cursor = self.conn.cursor()
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS groups (
                id          INTEGER PRIMARY KEY AUTOINCREMENT,
                name        TEXT NOT NULL UNIQUE,
                created_at  DATETIME DEFAULT CURRENT_TIMESTAMP,
                updated_at  DATETIME DEFAULT CURRENT_TIMESTAMP
            );
        """)
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS tabs (
                id          INTEGER PRIMARY KEY AUTOINCREMENT,
                url         TEXT NOT NULL,
                title       TEXT,
                description TEXT,
                group_name  TEXT NOT NULL DEFAULT 'no_group',
                position    INTEGER DEFAULT 0,
                created_at  DATETIME DEFAULT CURRENT_TIMESTAMP,
                updated_at  DATETIME DEFAULT CURRENT_TIMESTAMP,
                FOREIGN KEY (group_name) REFERENCES groups(name) ON DELETE SET DEFAULT
            );
        """)

        self.conn.commit()

    def create_triggers(self):
        """Create triggers to update the updated_at columns automatically."""
        cursor = self.conn.cursor()
        cursor.execute("""
            CREATE TRIGGER IF NOT EXISTS trg_update_groups_updated_at
            AFTER UPDATE ON groups
            FOR EACH ROW
            BEGIN
                UPDATE groups SET updated_at = CURRENT_TIMESTAMP WHERE id = old.id;
            END;
        """)
        cursor.execute("""
            CREATE TRIGGER IF NOT EXISTS trg_update_tabs_updated_at
            AFTER UPDATE ON tabs
            FOR EACH ROW
            BEGIN
                UPDATE tabs SET updated_at = CURRENT_TIMESTAMP WHERE id = old.id;
            END;
        """)

        self.conn.commit()

    def create_default_group(self):
        """Insert the default group ('no_group') if it doesn't exist."""
        cursor = self.conn.cursor()
        cursor.execute("INSERT OR IGNORE INTO groups (name) VALUES ('no_group')")

        self.conn.commit()

    ############################
    # CRUD Operations for Groups
    ############################

    def create_group(self, name: str):
        """Create a new group with the given name and return its id."""
        cursor = self.conn.cursor()
        cursor.execute("INSERT INTO groups (name) VALUES (?)", (name,))
        self.conn.commit()

        return cursor.lastrowid

    def get_group_by_id(self, group_id: int):
        """Retrieve a group by its id."""
        cursor = self.conn.cursor()
        cursor.execute("SELECT * FROM groups WHERE id = ?", (group_id,))
        return cursor.fetchone()

    def get_group_by_name(self, name: str):
        """Retrieve a group by its name."""
        cursor = self.conn.cursor()
        cursor.execute("SELECT * FROM groups WHERE name = ?", (name,))

        return cursor.fetchone()

    def update_group(self, group_id: int, new_name: str):
        """Update the name of a group by its id."""
        cursor = self.conn.cursor()
        cursor.execute("UPDATE groups SET name = ? WHERE id = ?", (new_name, group_id))

        self.conn.commit()

    def delete_group(self, group_id: int):
        """Delete a group by its id."""
        cursor = self.conn.cursor()
        cursor.execute("DELETE FROM groups WHERE id = ?", (group_id,))

        self.conn.commit()

    def list_groups(self):
        """Return a list of all groups."""
        cursor = self.conn.cursor()
        cursor.execute("SELECT * FROM groups")

        return cursor.fetchall()

    ###########################
    # CRUD Operations for Tabs
    ###########################

    def create_tab(
        self,
        url: str,
        title: str | None = None,
        description: str | None = None,
        group_name: str = "no_group",
        position: int = 0,
    ):
        """Create a new tab and return its id."""
        cursor = self.conn.cursor()
        cursor.execute(
            """
            INSERT INTO tabs (url, title, description, group_name, position)
            VALUES (?, ?, ?, ?, ?)
        """,
            (url, title, description, group_name, position),
        )
        self.conn.commit()

        return cursor.lastrowid

    def get_tab(self, tab_id: int):
        """Retrieve a tab by its id."""
        cursor = self.conn.cursor()
        cursor.execute("SELECT * FROM tabs WHERE id = ?", (tab_id,))

        return cursor.fetchone()

    def update_tab(
        self,
        tab_id: int,
        url: str | None = None,
        title: str | None = None,
        description: str | None = None,
        group_name: str | None = None,
        position: str | None = None,
    ):
        """
        Update a tab record.
        Only provided (non-None) parameters will be updated.
        """
        fields = []
        params = []

        if url is not None:
            fields.append("url = ?")
            params.append(url)
        if title is not None:
            fields.append("title = ?")
            params.append(title)
        if description is not None:
            fields.append("description = ?")
            params.append(description)
        if group_name is not None:
            fields.append("group_name = ?")
            params.append(group_name)
        if position is not None:
            fields.append("position = ?")
            params.append(position)
        if not fields:
            return  # nothing to update

        params.append(tab_id)
        query = "UPDATE tabs SET " + ", ".join(fields) + " WHERE id = ?"
        cursor = self.conn.cursor()
        cursor.execute(query, params)

        self.conn.commit()

    def delete_tab(self, tab_id: int):
        """Delete a tab by its id."""
        cursor = self.conn.cursor()
        cursor.execute("DELETE FROM tabs WHERE id = ?", (tab_id,))

        self.conn.commit()

    def list_tabs(self):
        """Return a list of all tabs."""
        cursor = self.conn.cursor()
        cursor.execute("SELECT * FROM tabs")

        return cursor.fetchall()

    def list_tabs_by_group(self, group_name: str):
        """Return a list of all tabs in a specific group."""
        cursor = self.conn.cursor()
        cursor.execute("SELECT * FROM tabs WHERE group_name = ?", (group_name,))

        return cursor.fetchall()

    ###########################
    # Connection Management
    ###########################

    def close(self):
        """Close the database connection."""
        self.conn.close()

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        self.close()
