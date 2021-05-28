ARG CUDA
ARG UBUNTU

FROM nvidia/cuda:${CUDA}-devel-ubuntu${UBUNTU}
ARG OPENCV

RUN apt update
RUN apt dist-upgrade -y
RUN apt install -y --no-install-recommends build-essential \
    cmake \
    gcc \
    gdb \
    git \
    wget \
    unzip \
    yasm \
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
    libavresample-dev

WORKDIR /tmp
RUN wget https://github.com/opencv/opencv/archive/refs/tags/${OPENCV}.zip && unzip ${OPENCV}.zip && rm ${OPENCV}.zip
RUN wget https://github.com/opencv/opencv_contrib/archive/${OPENCV}.zip && unzip ${OPENCV}.zip && rm ${OPENCV}.zip
RUN mkdir opencv-${OPENCV}/build && \
    cd opencv-${OPENCV}/build && \
    cmake -DOPENCV_EXTRA_MODULES_PATH=/tmp/opencv_contrib-${OPENCV}/modules \
        -DWITH_CUDA=ON \
        -DENABLE_FAST_MATH=ON \
        -DCUDA_FAST_MATH=ON \
        -DWITH_CUBLAS=ON \
        -DOPENCV_ENABLE_NONFREE=ON \
        -DCMAKE_BUILD_TYPE=RELEASE \
        -DCMAKE_INSTALL_PREFIX=/usr/local \
        .. && \
    make -j"$(nproc)" && \
    make install && \
    ldconfig
RUN rm -rf /tmp/* && rm -rf /var/lib/apt/lists/*