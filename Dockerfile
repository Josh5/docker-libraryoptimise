FROM josh5/base-ubuntu:16.04
LABEL maintainer="Josh.5 <jsunnex@gmail.com>"


################################
### Config:
###
# Set version for pyinotify
ARG PYINOTIFY_VERSION="0.9.6"
# Build Dependencies (not required in final image)
ARG BUILD_DEPENDENCIES=" \
        python3-dev \
        python3-pip \
        python3-setuptools \
    "


### Install pyinotify service.
RUN \
    echo "**** Update sources ****" \
        && apt-get update \
    && \
    echo "**** Install python ****" \
        && apt-get install python3 -y --no-install-recommends \
            python3 \
    && \
    echo "**** Install package build tools ****" \
        && apt-get install -y --no-install-recommends \
            ${BUILD_DEPENDENCIES} \
    && \
    echo "**** Install ffmpeg ****" \
        && apt-get install -y \
            ffmpeg \
    && \
    echo "**** Install pyinotify ****" \
        && curl -SL https://github.com/seb-m/pyinotify/archive/${PYINOTIFY_VERSION}.tar.gz -o /tmp/pyinotify.tar.gz \
        && tar zxfp "/tmp/pyinotify.tar.gz" -C /tmp \
        && cd /tmp/pyinotify-* \
        && python3 setup.py install \
    && \
    echo "**** Install schedule ****" \
        && python3 -m pip install --no-cache-dir --upgrade schedule \
    && \
    echo "**** Install ffpb ****" \
        && python3 -m pip install --no-cache-dir --upgrade ffpb \
    && \
    echo "**** cleanup ****" \
        && apt-get purge -y --auto-remove \
	        ${BUILD_DEPENDENCIES} \
        && apt-get clean \
        && echo rm -rf \
            /tmp/* \
            /var/tmp/* \
            /var/lib/apt/lists/*


### Add local files
COPY /root /


### Intended ports and volumes
VOLUME \
    /library \
    /cache

