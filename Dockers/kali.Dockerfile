FROM kalilinux/kali-last-release

# Kali Linux: CLI workflow
# Set workdir
WORKDIR /root

# Update
RUN apt -y update && DEBIAN_FRONTEND=noninteractive apt -y dist-upgrade && apt -y autoremove && apt clean

# Install common system tools
RUN apt -y install curl wget vim git net-tools whois man-db fzf tmux ripgrep fd-find 

# Install common hacking tools
RUN apt -y install netcat-traditional pciutils usbutils nmap proxychains fping

# Install programming languages
RUN apt -y install python3-pip golang nodejs npm

# Install Kali Linux tools
RUN DEBIAN_FRONTEND=noninteractive apt -y install kali-tools-top10 exploitdb dirb nikto wpscan uniscan lsof apktool strace ltrace binwalk

# Install Go hacking tools
RUN go install \
    github.com/OJ/gobuster/v3@latest # Gobuster

# Setup configuration files
## Clone repository
RUN git clone --single-branch --branch purifying-the-evil --depth 1 https://github.com/salorak/dotfiles.git
## Setup config files
RUN cd dotfiles && ./configure.sh INSTALL

# Install openvpn
RUN apt -y install openvpn

ENTRYPOINT ["/bin/bash"]
