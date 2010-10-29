PKGDIR=$(GLOBAL_BUILDDIR)/pkg

# prefix pkglist name with its directory to form a path
list = $(1:%=$(PKGDIR)/lists/%)

# prefix/suffix group name to form a path
group = $(1:%=$(PKGDIR)/groups/%.directory)

# map first argument (a function) onto second one (an argument list)
map = $(foreach a,$(2),$(call $(1),$(a)))

# kernel package list generation; see also #24669
NULL :=
SPACE := $(NULL) # the officially documented way of getting a space
# NB: sort() shouldn't be applied here as kernel image order matters
list2re = $(subst $(SPACE),|,$(strip $(1)))
kpackages = ^kernel-(image|modules-($(call list2re,$(KMODULES))))-($(call list2re,$(KFLAVOURS)))$$
