FROM osrf/ros:noetic-desktop-full

RUN apt-get update && apt-get install -y \
    x11vnc xvfb fluxbox nano novnc websockify xterm \
    zsh git curl bat \
    python3-catkin-tools \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p ~/.vnc && x11vnc -storepasswd 1234 ~/.vnc/passwd

RUN chsh -s /bin/zsh root
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
RUN git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /root/.oh-my-zsh/custom/themes/powerlevel10k

RUN mkdir -p /root/.fluxbox
COPY docker_scripts/fluxbox_apps /root/.fluxbox/apps
COPY docker_scripts/.zshrc_custom /root/.zshrc
COPY docker_scripts/start.sh /start.sh

RUN chmod +x /start.sh

WORKDIR /workspace
EXPOSE 5900 6080 11311
CMD ["/start.sh"]
