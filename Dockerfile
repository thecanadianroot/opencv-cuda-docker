ARG CUDA="11.3.1"
ARG UBUNTU="18.04"
ARG ARCH=""

FROM nvidia/cuda${ARCH}:${CUDA}-devel-ubuntu${UBUNTU}

ARG NVIDIA_DISTRO="ubuntu1804/x86_64"
ARG OPENCV="3.4.14"

ENV DEBIAN_FRONTEND=noninteractive

# See https://developer.nvidia.com/blog/updating-the-cuda-linux-gpg-repository-key/
RUN apt-key del 7fa2af80
RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/${NVIDIA_DISTRO}/3bf863cc.pub
RUN rm /etc/apt/sources.list.d/nvidia-ml.list

RUN apt update && apt install -y --no-install-recommends build-essential \
    cmake \
    gcc \
    g++ \
    ninja-build \
    gdb \
    git \
    wget \
    unzip \
    yasm \
    doxygen \
    pkg-config \
    checkinstall \
    libdc1394-22 \
    libdc1394-22-dev \
    libatlas-base-dev \
    gfortran \
    libflann-dev \
    libtbb2 \
    libtbb-dev \
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    libglew-dev \
    libtiff5-dev \
    zlib1g-dev \
    libjpeg-dev \
    libgdal-dev \
    libeigen3-dev \
    libgflags-dev \
    libgoogle-glog-dev \
    libprotobuf-dev \
    protobuf-compiler \
    python-dev \
    python-numpy \
    python3-dev \
    python3-numpy \
    ffmpeg \
    libavcodec-dev \
    libavformat-dev \
    libavutil-dev \
    libswscale-dev \
    libavresample-dev \
    libleptonica-dev \
    libtesseract-dev \
    libgtk-3-dev \
    libgtk2.0-dev \
    libvtk6-dev \
    liblapack-dev \
    libv4l-dev \
    libhdf5-serial-dev

WORKDIR /tmp
RUN wget https://github.com/opencv/opencv/archive/refs/tags/${OPENCV}.zip && unzip ${OPENCV}.zip && rm ${OPENCV}.zip
RUN wget https://github.com/opencv/opencv_contrib/archive/${OPENCV}.zip && unzip ${OPENCV}.zip && rm ${OPENCV}.zip
RUN mkdir opencv-${OPENCV}/build && \
    cd opencv-${OPENCV}/build && \
    cmake -GNinja -DOPENCV_EXTRA_MODULES_PATH=/tmp/opencv_contrib-${OPENCV}/modules \
        -DWITH_CUDA=ON \
        -DENABLE_FAST_MATH=ON \
        -DCUDA_FAST_MATH=ON \
        -DCUDA_ARCH_BIN='5.2 5.3 6.0 6.1 6.2 7.0 7.2 7.5 8.0 8.6' \
        -DCUDA_ARCH_PTX='8.6' \
        -DWITH_CUBLAS=ON \
        -DOPENCV_ENABLE_NONFREE=ON \
        -DWITH_GSTREAMER=OFF \
        -DCMAKE_BUILD_TYPE=RELEASE \
        -DCMAKE_INSTALL_PREFIX=/usr/local \
        -DBUILD_TESTS=OFF \
        -DBUILD_PERF_TESTS=OFF \
        -DBUILD_EXAMPLES=OFF \
        -DBUILD_opencv_apps=ON \
        .. && \
    ninja && \
    ninja install && \
    ldconfig

RUN rm -rf /tmp/* && rm -rf /var/lib/apt/lists/*
