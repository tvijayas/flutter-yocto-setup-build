
DIR="rpi4-drm-honister"
if [ ! -d "$DIR" ]; then
   mkdir rpi4-drm-honister
fi

cd rpi4-drm-honister

if [ ! -d "raspberrypi4-64" ]; then
   repo init -u https://github.com/tvijayas/manifests.git -m rpi64.xml -b honister

   repo sync --force-sync --no-clone-bundle -j `grep -c ^processor /proc/cpuinfo` & wait
   
   cd sources/poky
   git checkout honister-3.4.2
   git apply ../../conf/rpi64/0001-mesa-broadcom-vulkan.patch
          
   cd ../../
          
   chmod +x setup-environment raspberrypi4-64

   ./setup-environment raspberrypi4-64

   . ./sources/poky/oe-init-build-env raspberrypi4-64

   echo -e 'IMAGE_LINGUAS = "en-us"' >> ./conf/local.conf
   echo -e 'PACKAGECONFIG:pn-sascha-samples = "d2d"' >> ./conf/local.conf
   echo -e 'PACKAGECONFIG:pn-vkcube = "kms wayland"' >> ./conf/local.conf
   echo -e 'FLUTTER_SDK_TAG = "2.10.2"' >> ./conf/local.conf   
   echo -e '' >> ./conf/local.conf
   echo -e 'PREFERRED_VERSION:vulkan-headers = "1.2.198.0"' >> ./conf/local.conf
   echo -e 'PREFERRED_VERSION:vulkan-loader = "1.2.198.1"' >> ./conf/local.conf
   echo -e 'PREFERRED_VERSION:vulkan-tools = "1.2.198.0"' >> ./conf/local.conf
   echo -e 'PREFERRED_VERSION:glslang = "11.6.0"' >> ./conf/local.conf
   echo -e 'PREFERRED_VERSION:vulkan-validationlayers = "1.2.198"' >> ./conf/local.conf
   echo -e 'PREFERRED_VERSION:cmake = "3.21.1"' >> ./conf/local.conf
   echo -e 'PREFERRED_VERSION:cmake-native = "3.21.1"' >> ./conf/local.conf   
   
   #echo 'FLUTTER_CHANNEL = "master"' >> ./conf/local.conf
   echo -e 'CORE_IMAGE_EXTRA_INSTALL:append = " flutter-pi-release"' >> ./conf/local.conf
   echo -e 'CORE_IMAGE_EXTRA_INSTALL:append = " flutter-gallery-release"' >> ./conf/local.conf
   echo -e 'CORE_IMAGE_EXTRA_INSTALL:append = " swiftshader"' >> ./conf/local.conf
   echo -e 'CORE_IMAGE_EXTRA_INSTALL:append = " filament-samples-vk"' >> ./conf/local.conf   
   echo -e 'CORE_IMAGE_EXTRA_INSTALL:append = " sascha-samples"' >> ./conf/local.conf
   echo -e 'CORE_IMAGE_EXTRA_INSTALL:append = " vkcube"' >> ./conf/local.conf
   echo -e 'CORE_IMAGE_EXTRA_INSTALL:append = " vkmark"' >> ./conf/local.conf   
   echo -e 'CORE_IMAGE_EXTRA_INSTALL:append = " vkquake3"' >> ./conf/local.conf
   echo -e 'CORE_IMAGE_EXTRA_INSTALL:append = " vkrunner"' >> ./conf/local.conf
   echo -e 'CORE_IMAGE_EXTRA_INSTALL:append = " vk-layer-perfdoc"' >> ./conf/local.conf
   #echo -e 'CORE_IMAGE_EXTRA_INSTALL:append = " vulkan-extensionlayer"' >> ./conf/local.conf
   echo -e 'CORE_IMAGE_EXTRA_INSTALL:append = " ivi-homescreen-release"' >> ./conf/local.conf
   echo -e 'IMAGE_FSTYPES = "tar.xz ext3 rpi-sdimg"' >> ./conf/local.conf
else
   cd $DIR
   . ./sources/poky/oe-init-build-env raspberrypi4-64
fi

bitbake core-image-minimal

