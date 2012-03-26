# step 2: build up distribution's configuration

ifndef MKIMAGE_PROFILES
$(error this makefile is designed to be included in toplevel one)
endif

ifeq (distro,$(IMAGE_CLASS))

# request particular image subprofile inclusion
sub/%:
	@$(call add,SUBPROFILES,$(@:sub/%=%))

# install media bootloader
boot/%:
	@$(call set,BOOTLOADER,$*)

# fundamental targets

distro/.init: profile/bare
	@$(call try,META_PREPARER,mkimage-profiles)
	@$(call try,META_APP_ID,$(IMAGE_NAME))
	@$(call set,META_PUBLISHER,ALT Linux Team)

# NB: the last flavour in KFLAVOURS gets to be the default one;
# the kernel packages regexp evaluation has to take place at build stage
distro/.base: distro/.init
	@$(call set,KFLAVOURS,std-def)
	@$(call set,META_SYSTEM_ID,LINUX)
	@$(call set,META_VOL_ID,ALT Linux $(ARCH))
	@$(call set,META_VOL_SET,ALT Linux)

# something marginally useful (as a network-only installer)
# NB: doesn't carry stage3 thus cannot use/bootloader
distro/installer: distro/.base use/install2 use/syslinux/localboot.cfg
	@$(call set,INSTALLER,altlinux-generic)
	@$(call set,STAGE1_KMODULES_REGEXP,drm.*)	# for KMS

distro/.installer: distro/installer use/bootloader/grub use/repo/main; @:

endif
