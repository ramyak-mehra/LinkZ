CREATE TABLE "users" (
  "username" varchar PRIMARY KEY,
  "id" varchar UNIQUE NOT NULL,
  "hashed_password" varchar NOT NULL,
  "salt" varchar NOT NULL,
  "email" varchar,
  "created_at" timestamp DEFAULT (now())
);

CREATE TABLE "links" (
  "id" varchar PRIMARY KEY,
  "account" varchar NOT NULL,
  "title" varchar NOT NULL,
  "url" varchar NOT NULL,
  "index" int NOT NULL,
  "turned_on" boolean NOT NULL,
  "emoji" varchar,
  "clicks" int NOT NULL,
  "created_at" timestamp DEFAULT (now())
);
