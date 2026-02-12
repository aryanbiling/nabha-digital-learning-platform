PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS teachers (
  teacher_id         INTEGER PRIMARY KEY AUTOINCREMENT,
  full_name          TEXT NOT NULL,
  phone              TEXT UNIQUE,
  email              TEXT UNIQUE,
  gender             TEXT CHECK(gender IN ('F','M','O')),
  school_name        TEXT NOT NULL,
  school_code        TEXT,
  district           TEXT DEFAULT 'Patiala',
  block              TEXT,
  village            TEXT,
  designation        TEXT,
  languages          TEXT,
  qualification      TEXT,
  years_experience   INTEGER DEFAULT 0,
  created_at         TEXT NOT NULL DEFAULT (datetime('now')),
  updated_at         TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE TABLE IF NOT EXISTS teacher_subjects (
  id                 INTEGER PRIMARY KEY AUTOINCREMENT,
  teacher_id         INTEGER NOT NULL,
  class_level        INTEGER NOT NULL CHECK(class_level BETWEEN 1 AND 12),
  subject            TEXT NOT NULL,
  FOREIGN KEY(teacher_id) REFERENCES teachers(teacher_id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_teachers_school ON teachers(school_name);
CREATE INDEX IF NOT EXISTS idx_teacher_subjects_teacher ON teacher_subjects(teacher_id);
