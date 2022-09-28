FROM kalilinux/kali-rolling:latest

ENV DEBIAN_FRONTEND noninteractive

RUN apt update -y && \
	apt upgrade -y && \
    # kali tools
    apt install -y --no-install-recommends kismet && \
	apt install -y --no-install-recommends wireshark && \
	apt install -y --no-install-recommends macchanger && \
	apt install -y --no-install-recommends sslh && \
    apt install -y --no-install-recommends kali-linux-headless && \
    # hardware acceleration library
    apt install -y --no-install-recommends nvidia-opencl-icd && \
    # manual pyrit installation
    apt install -y build-essential git python2-dev libssl-dev libpcap-dev build-essential libz-dev -y && \
    git config --global http.sslverify false && \
    git clone https://github.com/JPaulMora/Pyrit.git && cd Pyrit && \
    python2 setup.py build && python2 setup.py install && cd .. && \
    rm -rf Pyrit && \
    # remove useless stuff
    rm -rf /var/lib/apt/lists/* && \
    apt autoremove -y
