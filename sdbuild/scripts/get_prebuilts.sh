#!/bin/bash
wget https://bit.ly/pynq_sdist_v3_0_1
wget https://bit.ly/pynq_arm_v3_1

# For rebuilding all SD cards, both arm and aarch64 root filesystems
# may be required depending on boards being targetted.
mv pynq_sdist_v3_0_1 prebuilt/pynq_sdist
mv pynq_arm_v3_1 prebuilt/pynq_rootfs.arm

