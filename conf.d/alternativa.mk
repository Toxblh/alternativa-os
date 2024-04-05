# desktop distributions
ifeq (distro,$(IMAGE_CLASS))

DISTRO_VERSION="Alpha.$(date +"%d.%m.%y-%H.%M.%S")"

# Включаем sudo по умолчанию
# Ставим базовый пакет софта - pkg.in/lists/alternativa/base
mixin/alternativa-common:
	@$(call add,THE_PACKAGES,sudo)
	@$(call add,CONTROL,sudo:public)
	@$(call add,CONTROL,sudowheel:enabled)
	@$(call add,THE_LISTS,alternativa/base)

# @$(call set,BRANDING,alternativa)

# Копия регулярки
distro/alternativa-os: distro/.regular-install-x11-systemd \
	mixin/regular-gnome \
	mixin/alternativa-common \
	use/kernel/latest \
	use/fonts/ttf/google-noto \
	+plymouth;
	@$(call add,INSTALL2_PACKAGES,btrfs-progs)
	@$(call set,META_PUBLISHER,Toxblh)
	@$(call set,META_VOL_ID,Alternativa $(DISTRO_VERSION) $(ARCH))
	@$(call set,META_APP_ID,Alternativa $(DISTRO_VERSION) $(ARCH) $(shell date +%F))
	@$(call set,META_VOL_SET,Alternativa)
	
# Дистр с nvidia драйверами из коробки
# Пакет софта - pkg.in/lists/alternativa/nvidia
distro/alternativa-os-nvidia: distro/alternativa-os \
	use/x11/nvidia \
	use/stage2/kms/nvidia
	@$(call add,EFI_BOOTARGS,xdriver=vesa)
	@$(call add,BASE_BOOTARGS,nvidia-drm.modeset=1)
	@$(call add,LIVE_PACKAGES,installer-feature-remove-xorgconf)
	@$(call add,LIVE_PACKAGES,apt-scripts-nvidia)
	@$(call add,CLEANUP_PACKAGES,'^kernel-modules-drm-nouveau.*')
	@$(call add,BASE_PACKAGES,apt-scripts-nvidia)
	@$(call add,THE_LISTS,alternativa/nvidia)
endif

# features.in/fonts/config.mk
use/fonts/ttf/google-noto: use/fonts
	@$(call add,FONTS,fonts-ttf-google-noto-sans)
	@$(call add,FONTS,fonts-ttf-google-noto-serif)
	@$(call add,FONTS,fonts-ttf-google-noto-sans-mono)
	@$(call add,FONTS,fonts-ttf-google-noto-sans-symbols)
	@$(call add,FONTS,fonts-ttf-google-noto-sans-symbols2)
	@$(call add,FONTS,fonts-ttf-google-noto-emoji)
	@$(call add,FONTS,fonts-ttf-google-noto-emoji-color)
	@$(call add,FONTS,fonts-otf-google-noto-cjk)