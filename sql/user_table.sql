CREATE TABLE "users" (
  "username" varchar PRIMARY KEY,
  "id" varchar UNIQUE NOT NULL,
  "hashed_password" varchar NOT NULL,
  "salt" varchar NOT NULL,
  "email" varchar,
  "created_at" timestamp DEFAULT (now())
);
