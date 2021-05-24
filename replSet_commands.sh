# create directories if they don't already exist
mkdir -p rps1 rps2 rps3
# configuration for each mongod instance (replSet name, logpath, db, port)
mongod --replSet m103rs --logpath "rps1.log" --dbpath rps1 --port 27017 &
mongod --replSet m103rs --logpath "rps2.log" --dbpath rps2 --port 27018 & 
mongod --replSet m103rs --logpath "rps3.log" --dbpath rps3 --port 27019 &

# connect to Mongo
mongo;

# var for replSet member configuration
config = { _id: "m103rs", members:[
			{_id: 0, host: "localhost:27017"},
			{_id: 1, host: "localhost:27018"},
			{_id: 2, host: "localhost:27019"},]};

# initiates the config to bind 3 mongod instances			
rs.initiate(config);

# verify replSet status of each member
rs.status();



# connect to cluster after primary node is down using this command. Will find a former secondary as the new primary after elections.
mongo --host m103rs/localhost:27017,localhost:27018,localhost:27019
