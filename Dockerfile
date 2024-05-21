FROM ubuntu:focal-20240410 

# add new user
RUN useradd -ms /bin/bash mmr -G sudo

# install tool
RUN apt update && \
	apt install -y software-properties-common && \
	add-apt-repository universe && \
	apt update && \
	apt install -y curl && \
	curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg && \
	echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null && \
	apt update && \
	apt install -y openssh-server \
	git \ 
	build-essential \
	tmux \
	vim \
	ros-foxy-desktop \
	python3-argcomplete \
	ros-dev-tools \
	ros-foxy-rosbag2-storage-mcap

RUN mkdir /var/run/sshd
RUN echo "mmr:mmr" | chpasswd
COPY ./sshd_config /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

EXPOSE 22

COPY --chown=mmr:mmr ./bashrc /home/mmr/.bashrc
RUN mkdir -p /home/mmr/.cache/xdgr && chown mmr:mmr /home/mmr/.cache/xdgr
RUN apt install -y python3-pip python3-venv can-utils iproute2

# start sshd
CMD ["/usr/sbin/sshd", "-D"]
