-- 
-- Created by SQL::Translator::Producer::SQLite
-- Created on Sun Jul 10 18:04:49 2016
-- 

;
BEGIN TRANSACTION;
--
-- Table: users
--
CREATE TABLE users (
  id INTEGER PRIMARY KEY NOT NULL,
  username varchar(255) NOT NULL,
  lc_username varchar(255) NOT NULL,
  email varchar(255) NOT NULL,
  password varchar(50) NOT NULL,
  set_password_code varchar(80)
);
CREATE UNIQUE INDEX users_email ON users (email);
CREATE UNIQUE INDEX users_lc_username ON users (lc_username);
CREATE UNIQUE INDEX users_username ON users (username);
--
-- Table: projects
--
CREATE TABLE projects (
  id INTEGER PRIMARY KEY NOT NULL,
  user_id int NOT NULL,
  name varchar(255) NOT NULL,
  lc_name varchar(255) NOT NULL,
  description text NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE INDEX projects_idx_user_id ON projects (user_id);
--
-- Table: versions
--
CREATE TABLE versions (
  id INTEGER PRIMARY KEY NOT NULL,
  project_id int NOT NULL,
  version int NOT NULL DEFAULT 1,
  timestamp datetime NOT NULL,
  description text NOT NULL,
  tar_file text,
  zip_file text,
  gz_file text,
  FOREIGN KEY (project_id) REFERENCES projects(id) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE INDEX versions_idx_project_id ON versions (project_id);
CREATE UNIQUE INDEX versions_project_id_version ON versions (project_id, version);
--
-- Table: files
--
CREATE TABLE files (
  id INTEGER PRIMARY KEY NOT NULL,
  version_id int NOT NULL,
  filename varchar(255) NOT NULL,
  file text,
  FOREIGN KEY (version_id) REFERENCES versions(id) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE INDEX files_idx_version_id ON files (version_id);
COMMIT;
