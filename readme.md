### run follow command to generate a image of ambot development env

docker build --progress=plain -t ambot_env --build-arg user=$USER -f ./Dockerfile --network host  .

[ docker run -u ${USER} -it -v /dev/bus/usb:/dev/bus/usb --privileged ambot_env:0.1 /bin/bash ] && docker run -u suntao -it -v /dev/bus/usb:/dev/bus/usb --privileged ambot_env:0.1 /bin/bash
