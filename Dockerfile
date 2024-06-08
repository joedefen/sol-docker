# Use Ubuntu 18.04 as the base image
FROM ubuntu:18.04

# Set environment variables to avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update and install necessary packages
RUN apt-get update && \
    apt-get install -y \
    locales \
    aisleriot \
    guile-2.0 \
    gtk2-engines-murrine \
    gtk2-engines-pixbuf \
    gnome-themes-standard \
    adwaita-icon-theme \
    breeze-icon-theme \
    hicolor-icon-theme \
    gnome-icon-theme \
    && apt-get clean

# Update the icon cache
RUN gtk-update-icon-cache -f /usr/share/icons/hicolor && \
    gtk-update-icon-cache -f /usr/share/icons/Adwaita && \
    gtk-update-icon-cache -f /usr/share/icons/gnome && \
    gtk-update-icon-cache -f /usr/share/icons/breeze

# Copy application files (if any additional files are needed)
# COPY ./path/to/your/application/files /opt/aisleriot/

# Generate and set the locale to en_US.UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Define the entrypoint (for running inside Docker, if needed)
ENTRYPOINT ["/usr/games/sol"]
