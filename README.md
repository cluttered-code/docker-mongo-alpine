# clutteredcode/mongo-alpine

An alpine:latest image with mongodb.  The default behavior is to run mongo in
'--auth' mode.  This image will set a root username and password based on
environment variables at run time.

## Environment Variables
* **MONGO_USERNAME:**  
    (defaults to 'root') The root username for the mongod instance.
* **MONGO_PASSWORD:**  
    (defaults to 'password') The root password for the mongod instance.

## Examples
**.env-file**
```bash
MONGO_USERNAME="root-user"
MONGO_PASSWORD="root-password"
```  

```bash
docker pull clutteredcode/mongo-alpine
docker run -d --name mongo \
  --env-file "$PWD/.env-file" \
  -p "27017:27017" \
  -v /path/to/data:/data/db \
  clutteredcode/mongo-alpine
```
-----------------------
Same as above, but not using an env-file.
```bash
docker pull clutteredcode/mongo-alpine
docker run -d --name mongo \
    -e MONGO_USERNAME="root-user" \
    -e MONGO_PASSWORD="super-secret" \
    -v /path/to/data:/data/db \
    -p "27017:27017" \
    clutteredcode/mongo-alpine
```
---------------------
Passing other options to `mongod` at start-up.  If no options are passed, we call
`mongod --auth`, however if you pass additional options, then you need to include the `--auth`
option, if desired.
```bash
docker pull clutteredcode/mongo-alpine
docker run -d --name mongo \
  --env-file "$PWD/.env-file" \
  -p "27017:27017" \
  -v /path/to/data:/data/db \
  clutteredcode/mongo-alpine mongod --auth --smallfiles
```