##============================================================================
## hooks.mk
HOOKS_MK =

## mimic double colon targets for hooks, as automake will at times
## insert a single colon target for, e.g., dist-hook, if multiple
## automake conditionals are present

DIST_HOOKS =

dist-hook : $(DIST_HOOKS)
