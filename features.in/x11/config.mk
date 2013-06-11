+icewm: use/x11/icewm; @:
+razorqt: use/x11/razorqt use/x11/lightdm/razorqt; @:
+xmonad: use/x11/xmonad; @:
+tde: use/x11/tde use/x11/kdm; @:
+kde4-lite: use/x11/kde4-lite use/x11/kdm4; @:

# the very minimal driver set
use/x11:
	@$(call add_feature)
	@$(call add,THE_KMODULES,drm)	# required by recent nvidia.ko as well
	@$(call add,THE_LISTS,$(call tags,base xorg))

# free drivers for various hardware (might lack acceleration)
use/x11/xorg: use/x11 use/x11/intel
	@$(call add,THE_KMODULES,drm-radeon drm-nouveau)
	@$(call add,THE_LISTS,$(call tags,desktop xorg))

# both free and excellent
use/x11/intel: use/x11
	@$(call add,THE_PACKAGES,xorg-drv-intel)
	@$(call add,THE_PACKAGES,xorg-dri-intel)	### #25044

# for those cases when no 3D means no use at all
# NB: blobs won't Just Work (TM) with use/x11/xorg,
#     nouveau gets prioritized during autodetection
#use/x11/3d: use/x11/intel use/x11/nvidia use/x11/fglrx; @:
use/x11/3d: use/x11/intel use/x11/nvidia use/x11/radeon; @:

# has performance problems but is getting better, just not there yet
use/x11/radeon: use/x11
	@$(call add,THE_KMODULES,drm-radeon)
	@$(call add,THE_PACKAGES,xorg-drv-radeon)

# sometimes broken with current xorg-server
use/x11/nvidia: use/x11
	@$(call add,THE_KMODULES,nvidia)
	@$(call add,THE_PACKAGES,nvidia-settings nvidia-xconfig)

# oftenly broken with current xorg-server, use radeon then
use/x11/fglrx: use/x11
	@$(call add,THE_KMODULES,fglrx)
	@$(call add,THE_PACKAGES,fglrx_glx fglrx-tools)

use/x11/wacom: use/x11
	@$(call add,THE_PACKAGES,xorg-drv-wacom xorg-drv-wizardpen)

### xdm: see also #23108
use/x11/xdm: use/x11-autostart
	@$(call add,THE_PACKAGES,xdm installer-feature-no-xconsole-stage3)

### : some set()-like thing might be better?
use/x11/lightdm/gtk use/x11/lightdm/qt use/x11/lightdm/razorqt \
	use/x11/lightdm/kde: use/x11/lightdm/%: use/x11-autostart
	@$(call add,THE_PACKAGES,lightdm-$*-greeter)

use/x11/kdm: use/x11-autostart
	@$(call add,THE_PACKAGES,kdebase-kdm<4)

use/x11/kdm4: use/x11-autostart
	@$(call add,THE_PACKAGES,kde4base-workspace-kdm)

use/x11/gdm2.20: use/x11-autostart
	@$(call add,THE_PACKAGES,gdm2.20)

use/x11/icewm: use/x11
	@$(call add,THE_LISTS,$(call tags,icewm desktop))

use/x11/razorqt: use/x11
	@$(call add,THE_LISTS,$(call tags,razorqt desktop))

use/x11/tde: use/x11
	@$(call add,THE_LISTS,$(call tags,tde desktop))

use/x11/kde4-lite: use/x11
	@$(call add,THE_LISTS,$(call tags,kde4 desktop))

use/x11/kde4: use/x11
	@$(call add,THE_PACKAGES,kde4-default)

use/x11/xfce: use/x11
	@$(call add,THE_LISTS,$(call tags,xfce desktop))

use/x11/cinnamon: use/x11/xorg
	@$(call add,THE_LISTS,$(call tags,cinnamon desktop))

use/x11/gnome3: use/x11/xorg
	@$(call add,THE_PACKAGES,gnome3-default)
	@$(call add,THE_PACKAGES,gst-libav pulseaudio-daemon)

use/x11/e17: use/x11
	@$(call add,THE_LISTS,$(call tags,e17 desktop))

use/x11/lxde: use/x11
	@$(call add,THE_LISTS,$(call tags,lxde desktop))

use/x11/fvwm: use/x11
	@$(call add,THE_LISTS,$(call tags,fvwm desktop))

use/x11/sugar: use/x11
	@$(call add,THE_LISTS,$(call tags,sugar desktop))

use/x11/wmaker: use/x11
	@$(call add,THE_LISTS,$(call tags,wmaker desktop))

use/x11/gnustep: use/x11
	@$(call add,THE_LISTS,$(call tags,gnustep desktop))

use/x11/xmonad: use/x11
	@$(call add,THE_LISTS,$(call tags,xmonad desktop))

use/x11/mate: use/x11
	@$(call add,THE_LISTS,$(call tags,mate desktop))
