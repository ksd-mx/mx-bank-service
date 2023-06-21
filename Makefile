postgres:
	docker run --name postgres -p 5432:5432 -e POSTGRES_USER=app -e POSTGRES_PASSWORD=apppwd -d postgres:12-alpine

createdb:
	docker exec -it postgres createdb --username=app --owner=app bank

dropdb:
	docker exec -it postgres dropdb bank

.PHONY: postgres createdb dropdb