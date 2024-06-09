# SOL-DOCKER README #
This repository covers creating/installing/running Gnome Aisleriot in a docker container running Ubuntu 18.04. 

About 2024, Aisleriot has been rather abandoned; e.g., on Ubuntu and Flatpak, often icons are not available and the game looks like crap.  This image provides a consistent, trouble free experience  (on X11 at least).

Hence, the reason for running Aisleriot (a.k.a., sol) docker container on vintage Ubuntu.  A pre-built docker image is at [joedefen/aisleriot
](https://hub.docker.com/r/joedefen/aisleriot).

---

## INSTRUCTIONS w/o Cloning This Repo #
```
wget -O ~/.local/bin/sol https://raw.githubusercontent.com/joedefen/sol-docker/main/start-sol
chmod +x ~/.local/bin/sol
```
Assuming `~/.local/bin` is on your path, then just run `sol` to start Aisleriot.

---

## INSTRUCTIONS after Cloning This Repo #

Assuming you cloned this repository and changed directory into it...

* To Build the Docker Container:
```
        docker build -t aisleriot:18.04 .
```
* To push the Docker Containter to hub.docker.io:
```
        docker login
        docker tag aisleriot:18.04 joedefen/aisleriot:18.04
        docker push joedefen/aisleriot:18.04

```

* To run Aisleriot:
```
        ./start-sol
```

NOTES:
* You must have docker installed and set up properly.
* This sol-docker version:
    * only has the "Bonded" card set, which is the most practical set.
    * uses the standard places under `~/.config/` to store your perferences and stats.
    * requires running under X11 or with X11 compatibility in Wayland.
* The `deploy` script just copies `start-sol` to your `~/.local/bin/`.


---
---
---
# TODO: Wayland Support/Instructions

Need to disgest these unverified, preliminary notes and make it work... when needed. W/o changes, the current sol-docker runs on sway, at least.

**Steps to Run Dockerized GUI Applications under Wayland**

1. Install `xdg-desktop-portal` and `xdg-desktop-portal-wlr`.
   These are needed for Wayland to allow GUI applications to interact with the display.
```
        sudo apt install xdg-desktop-portal-gtk # Gnome
        sudo apt install xdg-desktop-portal-wlr # Sway
```
2. Use xhost for Display Access (for XWayland)
```
        xhost +si:localuser:$(whoami)
```
3. Run the Docker Container with Correct Environment Variables. Example
```
        docker run -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix joedefen/aisleriot:18.04
```
4. NOTE: Native Wayland Support not available for a old app like this. If it were:
```
        docker run -e WAYLAND_DISPLAY=$WAYLAND_DISPLAY \
           -v /run/user/$(id -u)/wayland-0:/run/user/$(id -u)/wayland-0 joedefen/aisleriot:18.04
```
5. Troubleshooting
* XWayland not starting: Ensure that your Wayland compositor is configured to start XWayland.
* Permissions issues: Use xhost to manage access permissions.
* Missing libraries: Ensure all necessary libraries for running GUI applications are available inside the Docker container.
