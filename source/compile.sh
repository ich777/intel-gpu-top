# Set Variables
DATA_DIR="/root/intel-gpu-top"
CPU_COUNT=12
APP_NAME="intel-gpu-top"
UID=99
GID=100

# Clone repository and compile Intel-GPU-TOOLS
cd ${DATA_DIR}
git clone https://gitlab.freedesktop.org/drm/igt-gpu-tools.git
cd ${DATA_DIR}/igt-gpu-tools
git checkout ${BUILD}
meson --prefix=/usr build
ninja -j${CPU_COUNT} -C build

# Create directories and copy files to destination
mkdir -p ${DATA_DIR}/igt-$LAT_V/usr/bin ${DATA_DIR}/igt-$LAT_V/usr/local/emhttp/plugins/intel-gpu-top/images
cp ${DATA_DIR}/igt-gpu-tools/build/tools/intel_gpu_top ${DATA_DIR}/igt-$LAT_V/usr/bin/
wget -q -O ${DATA_DIR}/igt-$LAT_V/usr/local/emhttp/plugins/intel-gpu-top/images/intel-gpu-top.png https://raw.githubusercontent.com/ich777/docker-templates/master/ich777/images/intel.png
mkdir -p ${DATA_DIR}/v$LAT_V
cd ${DATA_DIR}/igt-$LAT_V/
chmod -R 755 ${DATA_DIR}/igt-$LAT_V/

# Create Slackware package
makepkg -l y -c y ${DATA_DIR}/v$LAT_V/intel.gpu.top-"$(date +'%Y.%m.%d')".txz
cd ${DATA_DIR}/v$LAT_V
md5sum intel.gpu.top-"$(date +'%Y.%m.%d')".txz > intel.gpu.top-"$(date +'%Y.%m.%d')".txz.md5