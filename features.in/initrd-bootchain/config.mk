use/initrd-bootchain:
	@$(call add_feature)
	@$(call set,STAGE1_INITRD,initrd-bootchain)
	@$(call set,STAGE1_PACKAGES,make-initrd-bootchain kbd)
	@$(call set,STAGE1_INITRD_TYPEARGS,$(shell echo "root=bootchain bootchain=fg,altboot automatic"))
	@$(call set,STAGE1_INITRD_BOOTMETHOD,$(shell echo "method:disk,uuid:$(UUID_ISO)"))
	@$(call set,STAGE1_INITRD_STAGE2_OPTION,stagename)
	@$(call try,BOOTCHAIN_BC_FGVT_ACTIVATE,7)
	@$(call try,BOOTCHAIN_WAITDEV_TIMEOUT,)
	@$(call try,BOOTCHAIN_OEM_WELCOME_TEXT,Welcome to ALT!)
	@$(call try,BOOTCHAIN_OEM_CDROOT,/image)
	@$(call try,BOOTCHAIN_OEM_DEFAULT_STAGE2,altinst)
	@$(call try,BOOTCHAIN_OEM_LIVE_STORAGE,alt-live-storage)
	@$(call try,BOOTCHAIN_OEM_BAD_STORAGE,alt-slow-storage)
	@$(call try,BOOTCHAIN_OEM_SETUP_STORAGE,alt-drivers-update)
	@$(call try,BOOTCHAIN_OEM_IMAGES_BASE,/tmp/images)
	@$(call try,BOOTCHAIN_OEM_OVERLAYS_DIR,/tmp/overlays)
	@$(call try,BOOTCHAIN_OEM_URL_NETINST,/pub/netinst/current)
	@$(call try,BOOTCHAIN_OEM_SRV_NETINST,)
	@$(call try,BOOTCHAIN_OEM_NFS_NETINST,/srv/public/netinst)
	@$(call try,BOOTCHAIN_OEM_CIFS_NETINST,/netinst)
	@$(call try,BOOTCHAIN_LOGFILE,/var/log/chaind.log)
	@$(call try,BOOTCHAIN_LOG_VT,3)
