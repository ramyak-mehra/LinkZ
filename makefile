migrateup:
	migrate -path db/migration -database "postgres://postgres:password@localhost:5432/db_testing?sslmode=disable" -verbose up
migratedown:
	migrate -path db/migration -database "postgres://postgres:password@localhost:5432/db_testing?sslmode=disable" -verbose down
newmigrate:
	migrate create -ext sql -dir db/migration -seq $(schema-name)

.PHONY: migrateup migrateup newmigrate