# cmd_1 = "pg_dump --clean"
cmd_2 = "pg_restore --verbose --clean --no-acl --no-owner -h localhost -U $(whoami) -d rails-engine_development db/data/rails-engine-development.pgdump"
puts "Loading PostgreSQL Data dump into local database with command:"
# puts cmd_1
# system(cmd_1)
puts cmd_2
system(cmd_2)
