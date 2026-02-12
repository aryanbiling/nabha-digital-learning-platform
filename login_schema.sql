PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS users (
  user_id            INTEGER PRIMARY KEY AUTOINCREMENT,
  username           TEXT NOT NULL UNIQUE,
  password_hash      TEXT NOT NULL,
  role               TEXT NOT NULL CHECK(role IN ('STUDENT','TEACHER','ADMIN')),
  profile_ref_id     INTEGER,
  is_active          INTEGER NOT NULL DEFAULT 1,
  last_login_at      TEXT,
  created_at         TEXT NOT NULL DEFAULT (datetime('now')),
  updated_at         TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE TABLE IF NOT EXISTS sessions (
  session_id         TEXT PRIMARY KEY,
  user_id            INTEGER NOT NULL,
  issued_at          TEXT NOT NULL DEFAULT (datetime('now')),
  expires_at         TEXT NOT NULL,
  device_id          TEXT,
  FOREIGN KEY(user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_users_role ON users(role);
CREATE INDEX IF NOT EXISTS idx_sessions_user ON sessions(user_id);
