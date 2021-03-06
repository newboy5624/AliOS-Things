NAME := board_aaboard_demo

$(NAME)_MBINS_TYPE   := kernel
SUPPORT_MBINS 	     := no
MODULE             := 1062
HOST_ARCH          := Cortex-M4
HOST_MCU_FAMILY    := aamcu_demo
HOST_MCU_NAME      := aamcu1_demo
ENABLE_VFP         := 1

GLOBAL_DEFINES += CONFIG_AOS_KV_BUFFER_SIZE=32768 # 32kb
GLOBAL_DEFINES += CONFIG_AOS_KV_BLK_BITS=14       # (1 << 14) = 16kb
GLOBAL_CFLAGS  += -DSTM32F429xx -DCENTRALIZE_MAPPING

$(NAME)_SOURCES += config/k_config.c       \
                   config/partition_conf.c \
                   drivers/xx.c      \
                   startup/board.c         \
                   startup/startup.c

ifeq ($(COMPILER), armcc)
$(NAME)_SOURCES    += startup/startup_keil.s
$(NAME)_LINK_FILES := startup/startup_keil.o
GLOBAL_LDFLAGS += -L --scatter=board/aaboard_demo/aaboard_demo.sct
else ifeq ($(COMPILER), iar)
$(NAME)_SOURCES    += startup/startup_iar.s
GLOBAL_LDFLAGS += --config board/aaboard_demo/aaboard_demo.icf
else
$(NAME)_SOURCES    += startup/startup_gcc.s
GLOBAL_LDFLAGS += -T board/aaboard_demo/aaboard_demo.ld
endif

GLOBAL_INCLUDES += .        \
                   config/  \
                   drivers/ \
                   startup/

CONFIG_SYSINFO_PRODUCT_MODEL := ALI_AOS_aaboard_demo
CONFIG_SYSINFO_DEVICE_NAME   := aaboard_demo

GLOBAL_CFLAGS += -DSYSINFO_OS_VERSION=\"$(CONFIG_SYSINFO_OS_VERSION)\"
GLOBAL_CFLAGS += -DSYSINFO_PRODUCT_MODEL=\"$(CONFIG_SYSINFO_PRODUCT_MODEL)\"
GLOBAL_CFLAGS += -DSYSINFO_DEVICE_NAME=\"$(CONFIG_SYSINFO_DEVICE_NAME)\"
