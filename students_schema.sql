PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS students (
  student_id         INTEGER PRIMARY KEY AUTOINCREMENT,
  full_name          TEXT NOT NULL,
  gender             TEXT CHECK(gender IN ('F','M','O')),
  dob                TEXT,
  class_level        INTEGER NOT NULL CHECK(class_level BETWEEN 1 AND 12),
  section            TEXT,
  roll_no            TEXT,
  school_name        TEXT NOT NULL,
  school_code        TEXT,
  district           TEXT DEFAULT 'Patiala',
  block              TEXT,
  village            TEXT,
  parent_name        TEXT,
  parent_phone       TEXT,
  languages          TEXT,
  device_type        TEXT,
  created_at         TEXT NOT NULL DEFAULT (datetime('now')),
  updated_at         TEXT NOT NULL DEFAULT (datetime('now')),
  UNIQUE (school_name, class_level, section, roll_no)
);

CREATE TABLE IF NOT EXISTS lessons (
  lesson_id          INTEGER PRIMARY KEY AUTOINCREMENT,
  title              TEXT NOT NULL,
  language           TEXT NOT NULL,
  grade_min          INTEGER NOT NULL CHECK(grade_min BETWEEN 1 AND 12),
  grade_max          INTEGER NOT NULL CHECK(grade_max BETWEEN 1 AND 12),
  module_type        TEXT NOT NULL CHECK(module_type IN ('DIGITAL_LITERACY','ACADEMIC')),
  content_version    INTEGER NOT NULL DEFAULT 1
);

CREATE TABLE IF NOT EXISTS student_progress (
  progress_id        INTEGER PRIMARY KEY AUTOINCREMENT,
  student_id         INTEGER NOT NULL,
  lesson_id          INTEGER NOT NULL,
  status             TEXT NOT NULL CHECK(status IN ('NOT_STARTED','IN_PROGRESS','COMPLETED')),
  score              REAL DEFAULT 0,
  time_spent_sec     INTEGER DEFAULT 0,
  last_seen_at       TEXT DEFAULT (datetime('now')),
  synced             INTEGER NOT NULL DEFAULT 0,
  FOREIGN KEY(student_id) REFERENCES students(student_id) ON DELETE CASCADE,
  FOREIGN KEY(lesson_id) REFERENCES lessons(lesson_id) ON DELETE CASCADE,
  UNIQUE(student_id, lesson_id)
);

CREATE INDEX IF NOT EXISTS idx_students_school ON students(school_name);
CREATE INDEX IF NOT EXISTS idx_progress_student ON student_progress(student_id);
CREATE INDEX IF NOT EXISTS idx_progress_synced ON student_progress(synced);
