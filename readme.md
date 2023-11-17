### run follow command to generate a image of ambot development env

docker build --progress=plain -t ambot_env --build-arg user=$USER -f ./Dockerfile --network host  .
