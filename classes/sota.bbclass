python __anonymous() {
    if bb.utils.contains('DISTRO_FEATURES', 'sota', True, False, d):
        d.appendVar("OVERRIDES", ":sota")
        #d.appendVar("IMAGE_INSTALL", " ostree os-release")

        d.appendVarFlag("do_image_wic", "depends", " %s:do_image_otaimg" % d.getVar("IMAGE_BASENAME", True))
        #d.appendVar("EXTRA_IMAGEDEPENDS", " parted-native mtools-native dosfstools-native")
}

IMAGE_INSTALL_append_sota = " ostree os-release"
IMAGE_CLASSES += " image_types_ostree image_types_ota"
IMAGE_FSTYPES += "${@bb.utils.contains('DISTRO_FEATURES', 'sota', 'ostreepush otaimg wic', ' ', d)}"

WKS_FILE_sota ?= "sdimage-sota.wks"

EXTRA_IMAGEDEPENDS_append_sota = " parted-native mtools-native dosfstools-native"

# Please redefine OSTREE_REPO in order to have a persistent OSTree repo
OSTREE_REPO ?= "${DEPLOY_DIR_IMAGE}/ostree_repo"
OSTREE_BRANCHNAME ?= "ota-${MACHINE}"
OSTREE_OSNAME ?= "poky"
OSTREE_INITRAMFS_IMAGE ?= "initramfs-ostree-image"

SOTA_MACHINE ??="none"
SOTA_MACHINE_raspberrypi2 ?= "raspberrypi"
SOTA_MACHINE_rarpberrypi3 ?= "raspberrypi"
SOTA_MACHINE_porter ?= "porter"
SOTA_MACHINE_intel-corei7-64 ?= "minnowboard"
SOTA_MACHINE_qemux86-64 ?= "qemux86-64"

inherit sota_${SOTA_MACHINE}
