FROM carlasim/carla:0.9.11 as carla
FROM ros:melodic-ros-base

RUN apt-get update && apt-get install -y sudo && \
    apt-get install -y apt-utils gnupg2 software-properties-common && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 1AF1527DE64CB8D9 && \
    add-apt-repository "deb [arch=amd64] http://dist.carla.org/carla $(lsb_release -sc) main" && \
    apt-get update && \
    apt-get install -y carla-ros-bridge

COPY --from=carla --chown=root /home/carla/PythonAPI /opt/carla/PythonAPI
COPY PythonAPI/carla-0.9.11-py2.7-linux-x86_64.egg /opt/carla/PythonAPI/carla/dist/
COPY lidar.py /opt/carla-ros-bridge/melodic/lib/python2.7/dist-packages/carla_ros_bridge/lidar.py
ENV PYTHONPATH=/opt/carla/PythonAPI/carla/dist/carla-0.9.11-py2.7-linux-x86_64.egg

RUN echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
RUN echo "source /opt/carla-ros-bridge/melodic/setup.bash" >> ~/.bashrc

# DockerFileのRUNやCMDはbashではなくてshなのでsourceコマンドがないため, このように /bin/bash -sc "" と書く
# /bin/bash を使うとDockerFile内の変数は使えないっぽい
# docker run 時に locakhost を ホストのIPに変換してるはずなのにうまく機能しないため host:= で指定する
CMD /bin/bash -c "source /opt/ros/melodic/setup.bash ; source /opt/carla-ros-bridge/melodic/setup.bash ; roslaunch carla_ros_bridge carla_ros_bridge.launch host=:localhost"
