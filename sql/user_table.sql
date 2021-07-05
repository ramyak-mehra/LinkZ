CREATE TABLE "users" (
  "id" SERIAL PRIMARY KEY,
  "full_name" varchar,
  "password" varchar NOT NULL,
  "created_at" timestamp DEFAULT (now())
);
