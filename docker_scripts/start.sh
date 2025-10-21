#!/bin/zsh

cleanup() {
    echo "Stopping container, cleaning up..."
    # Kill all child processes gracefully
    kill -TERM $XVFB_PID $FLUXBOX_PID $VNC_PID $WEBSOCK_PID $RVIZ_PID 2>/dev/null
    rm -f /tmp/.X1-lock /tmp/.X11-unix/X1
    exit 0
}

trap cleanup SIGTERM SIGINT

rm -f /tmp/.X1-lock /tmp/.X11-unix/X1

echo "Starting Xvfb..."
Xvfb :1 -screen 0 1920x1080x24 > /dev/null 2>&1 &
XVFB_PID=$!
sleep 4

export DISPLAY=:1
echo "Starting fluxbox..."
fluxbox > /dev/null 2>&1 &
FLUXBOX_PID=$!
sleep 1

echo "Starting x11vnc..."
x11vnc -forever -usepw -display :1 -rfbport 5900 -shared -quiet > /dev/null 2>&1 &
VNC_PID=$!
sleep 1

echo "Starting websockify..."
websockify --web=/usr/share/novnc 6080 localhost:5900 > /dev/null 2>&1 &
WEBSOCK_PID=$!
sleep 1

echo "Starting roscore..."
roscore &
ROSCORE_PID=$!
sleep 2

export ROS_MASTER_URI=http://localhost:11311
export ROS_HOSTNAME=localhost
source /opt/ros/noetic/setup.zsh
if [ -f /workspace/devel/setup.zsh ]; then source /workspace/devel/setup.zsh; fi

echo "Starting rviz..."
rviz 2>&1 | grep -v "^\\[WARN\\]" | grep -v "QStandardPaths" &
RVIZ_PID=$!

wait

echo "A critical process died, cleaning up..."
cleanup