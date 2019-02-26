#import <Foundation/Foundation.h>

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/sysctl.h>
#include <sys/utsname.h>

#include "KernelStructureOffsets.h"
#include <common.h>

int* offsets = NULL;

int kstruct_offsets_11_0[] = {
    0xb, // KSTRUCT_OFFSET_TASK_LCK_MTX_TYPE,
    0x10, // KSTRUCT_OFFSET_TASK_REF_COUNT,
    0x14, // KSTRUCT_OFFSET_TASK_ACTIVE,
    0x20, // KSTRUCT_OFFSET_TASK_VM_MAP,
    0x28, // KSTRUCT_OFFSET_TASK_NEXT,
    0x30, // KSTRUCT_OFFSET_TASK_PREV,
    0x308, // KSTRUCT_OFFSET_TASK_ITK_SPACE
    0x368, // KSTRUCT_OFFSET_TASK_BSD_INFO,
    0x3a8, // KSTRUCT_OFFSET_TASK_ALL_IMAGE_INFO_ADDR
    0x3b0, // KSTRUCT_OFFSET_TASK_ALL_IMAGE_INFO_SIZE
    0x3a0, // KSTRUCT_OFFSET_TASK_TFLAGS

    0x0, // KSTRUCT_OFFSET_IPC_PORT_IO_BITS,
    0x4, // KSTRUCT_OFFSET_IPC_PORT_IO_REFERENCES,
    0x40, // KSTRUCT_OFFSET_IPC_PORT_IKMQ_BASE,
    0x50, // KSTRUCT_OFFSET_IPC_PORT_MSG_COUNT,
    0x60, // KSTRUCT_OFFSET_IPC_PORT_IP_RECEIVER,
    0x68, // KSTRUCT_OFFSET_IPC_PORT_IP_KOBJECT,
    0x88, // KSTRUCT_OFFSET_IPC_PORT_IP_PREMSG,
    0x90, // KSTRUCT_OFFSET_IPC_PORT_IP_CONTEXT,
    0xa0, // KSTRUCT_OFFSET_IPC_PORT_IP_SRIGHTS,

    0x10, // KSTRUCT_OFFSET_PROC_PID,
    0x108, // KSTRUCT_OFFSET_PROC_P_FD
    0x18, // KSTRUCT_OFFSET_PROC_TASK
    0x100, // KSTRUCT_OFFSET_PROC_UCRED
    0x8, // KSTRUCT_OFFSET_PROC_P_LIST

    0x0, // KSTRUCT_OFFSET_FILEDESC_FD_OFILES

    0x8, // KSTRUCT_OFFSET_FILEPROC_F_FGLOB

    0x38, // KSTRUCT_OFFSET_FILEGLOB_FG_DATA

    0x10, // KSTRUCT_OFFSET_SOCKET_SO_PCB

    0x10, // KSTRUCT_OFFSET_PIPE_BUFFER

    0x14, // KSTRUCT_OFFSET_IPC_SPACE_IS_TABLE_SIZE
    0x20, // KSTRUCT_OFFSET_IPC_SPACE_IS_TABLE

    0xd8, // KSTRUCT_OFFSET_VNODE_V_MOUNT
    0x78, // KSTRUCT_OFFSET_VNODE_VU_SPECINFO
    0x0, // KSTRUCT_OFFSET_VNODE_V_LOCK

    0x10, // KSTRUCT_OFFSET_SPECINFO_SI_FLAGS

    0x70, // KSTRUCT_OFFSET_MOUNT_MNT_FLAG

    0x10, // KSTRUCT_OFFSET_HOST_SPECIAL

    0x6c, // KFREE_ADDR_OFFSET
};

int kstruct_offsets_11_3[] = {
    0xb, // KSTRUCT_OFFSET_TASK_LCK_MTX_TYPE,
    0x10, // KSTRUCT_OFFSET_TASK_REF_COUNT,
    0x14, // KSTRUCT_OFFSET_TASK_ACTIVE,
    0x20, // KSTRUCT_OFFSET_TASK_VM_MAP,
    0x28, // KSTRUCT_OFFSET_TASK_NEXT,
    0x30, // KSTRUCT_OFFSET_TASK_PREV,
    0x308, // KSTRUCT_OFFSET_TASK_ITK_SPACE
    0x368, // KSTRUCT_OFFSET_TASK_BSD_INFO,
    0x3a8, // KSTRUCT_OFFSET_TASK_ALL_IMAGE_INFO_ADDR
    0x3b0, // KSTRUCT_OFFSET_TASK_ALL_IMAGE_INFO_SIZE
    0x3a0, // KSTRUCT_OFFSET_TASK_TFLAGS

    0x0, // KSTRUCT_OFFSET_IPC_PORT_IO_BITS,
    0x4, // KSTRUCT_OFFSET_IPC_PORT_IO_REFERENCES,
    0x40, // KSTRUCT_OFFSET_IPC_PORT_IKMQ_BASE,
    0x50, // KSTRUCT_OFFSET_IPC_PORT_MSG_COUNT,
    0x60, // KSTRUCT_OFFSET_IPC_PORT_IP_RECEIVER,
    0x68, // KSTRUCT_OFFSET_IPC_PORT_IP_KOBJECT,
    0x88, // KSTRUCT_OFFSET_IPC_PORT_IP_PREMSG,
    0x90, // KSTRUCT_OFFSET_IPC_PORT_IP_CONTEXT,
    0xa0, // KSTRUCT_OFFSET_IPC_PORT_IP_SRIGHTS,

    0x10, // KSTRUCT_OFFSET_PROC_PID,
    0x108, // KSTRUCT_OFFSET_PROC_P_FD
    0x18, // KSTRUCT_OFFSET_PROC_TASK
    0x100, // KSTRUCT_OFFSET_PROC_UCRED
    0x8, // KSTRUCT_OFFSET_PROC_P_LIST

    0x0, // KSTRUCT_OFFSET_FILEDESC_FD_OFILES

    0x8, // KSTRUCT_OFFSET_FILEPROC_F_FGLOB

    0x38, // KSTRUCT_OFFSET_FILEGLOB_FG_DATA

    0x10, // KSTRUCT_OFFSET_SOCKET_SO_PCB

    0x10, // KSTRUCT_OFFSET_PIPE_BUFFER

    0x14, // KSTRUCT_OFFSET_IPC_SPACE_IS_TABLE_SIZE
    0x20, // KSTRUCT_OFFSET_IPC_SPACE_IS_TABLE

    0xd8, // KSTRUCT_OFFSET_VNODE_V_MOUNT
    0x78, // KSTRUCT_OFFSET_VNODE_VU_SPECINFO
    0x0, // KSTRUCT_OFFSET_VNODE_V_LOCK

    0x10, // KSTRUCT_OFFSET_SPECINFO_SI_FLAGS

    0x70, // KSTRUCT_OFFSET_MOUNT_MNT_FLAG

    0x10, // KSTRUCT_OFFSET_HOST_SPECIAL

    0x7c, // KFREE_ADDR_OFFSET
};

int koffset(enum kstruct_offset offset)
{
    if (offsets == NULL) {
        LOG("need to call offsets_init() prior to querying offsets");
        return 0;
    }
    return offsets[offset];
}

void offsets_init()
{
    if (kCFCoreFoundationVersionNumber >= 1452.23) {
        LOG("offsets selected for iOS 11.3 or above");
        offsets = kstruct_offsets_11_3;
    } else if (kCFCoreFoundationVersionNumber >= 1443.00) {
        LOG("offsets selected for iOS 11.0 to 11.2.6");
        offsets = kstruct_offsets_11_0;
    } else {
        LOG("iOS version too low, 11.0 required");
        exit(EXIT_FAILURE);
    }
}
