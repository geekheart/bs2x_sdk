SRC_REPLACE_COMPONENT_NAME=REPLACE_SOURCES

C_OBJ_REPLACE_COMPONENT_NAME = $(subst $(SDK_ROOT),$(OUTPUT_DIR),$(patsubst %,%.obj,$(filter %.c,$(SRC_REPLACE_COMPONENT_NAME))))
CPP_OBJ_REPLACE_COMPONENT_NAME = $(subst $(SDK_ROOT),$(OUTPUT_DIR),$(patsubst %,%.obj,$(filter %.cpp,$(SRC_REPLACE_COMPONENT_NAME))))
CPP_OBJ_REPLACE_COMPONENT_NAME += $(subst $(SDK_ROOT),$(OUTPUT_DIR),$(patsubst %,%.obj,$(filter %.cc,$(SRC_REPLACE_COMPONENT_NAME))))
S_OBJ_REPLACE_COMPONENT_NAME = $(subst $(SDK_ROOT),$(OUTPUT_DIR),$(patsubst %,%.obj,$(filter %.S,$(SRC_REPLACE_COMPONENT_NAME))))
s_OBJ_REPLACE_COMPONENT_NAME = $(subst $(SDK_ROOT),$(OUTPUT_DIR),$(patsubst %,%.obj,$(filter %.s,$(SRC_REPLACE_COMPONENT_NAME))))
ALL_OBJ_REPLACE_COMPONENT_NAME = $(subst $(SDK_ROOT),$(OUTPUT_DIR),$(patsubst %,%.obj,$(SRC_REPLACE_COMPONENT_NAME)))

INCLUDES_TEMP_REPLACE_COMPONENT_NAME = REPLACE_COMPONENT_CUSTOM_INCLUDE
INCLUDES_REPLACE_COMPONENT_NAME = $(patsubst %,-I%,$(INCLUDES_TEMP_REPLACE_COMPONENT_NAME))

CCFLAGS_REPLACE_COMPONENT_NAME = $(LOS_PUB_CCFLAGS)
CCFLAGS_REPLACE_COMPONENT_NAME += REPLACE_COMPONENT_CUSTOM_CCFLAGS
DEFINES_TEMP_REPLACE_COMPONENT_NAME = REPLACE_COMPONENT_CUSTOM_DEFINES
DEFINES_REPLACE_COMPONENT_NAME += $(patsubst %,-D%,$(DEFINES_TEMP_REPLACE_COMPONENT_NAME))

LIBS_REPLACE_COMPONENT_NAME = REPLACE_LIBS
WHOLE_LINK_REPLACE_COMPONENT_NAME = REPLACE_WHOLE_LINK
ifeq ("$(WHOLE_LINK_REPLACE_COMPONENT_NAME)", "true")
    WHOLE_LINK_LIBS += REPLACE_COMPONENT_NAME
    WHOLE_EXTERN_LINK_LIBS += $(LIBS_REPLACE_COMPONENT_NAME)
else
    NORMAL_LINK_LIBS += REPLACE_COMPONENT_NAME
    NORMAL_EXTERN_LINK_LIBS += $(LIBS_REPLACE_COMPONENT_NAME)
endif

COMPONENT_NAME_REPLACE_COMPONENT_NAME=REPLACE_COMPONENT_NAME

LIB_DIR_TEMP_REPLACE_COMPONENT_NAME = REPLACE_LIB_DIR

LIB_DIR_REPLACE_COMPONENT_NAME = $(subst $(SDK_ROOT),$(OUTPUT_DIR),$(LIB_DIR_TEMP_REPLACE_COMPONENT_NAME))

LIB_DIR += $(LIB_DIR_REPLACE_COMPONENT_NAME)

LIB_EXIST := $(shell if [ -e "$(LIB_DIR_TEMP_REPLACE_COMPONENT_NAME)/lib$(COMPONENT_NAME_REPLACE_COMPONENT_NAME).a" ]; then echo "exist"; else echo "noexist"; fi )


lib$(COMPONENT_NAME_REPLACE_COMPONENT_NAME).a:$(ALL_OBJ_REPLACE_COMPONENT_NAME) HSO_DB_$(COMPONENT_NAME_REPLACE_COMPONENT_NAME)
	@mkdir -p $(LIB_DIR_REPLACE_COMPONENT_NAME)
	@$(RM) $(LIB_DIR_REPLACE_COMPONENT_NAME)/lib$(COMPONENT_NAME_REPLACE_COMPONENT_NAME).a
ifeq ("$(LIB_EXIST)", "noexist")
	@echo building $(LIB_DIR_REPLACE_COMPONENT_NAME)/lib$(COMPONENT_NAME_REPLACE_COMPONENT_NAME).a
	@$(AR) -rc $(LIB_DIR_REPLACE_COMPONENT_NAME)/lib$(COMPONENT_NAME_REPLACE_COMPONENT_NAME).a $(ALL_OBJ_REPLACE_COMPONENT_NAME)
else
	@echo copy $(LIB_DIR_REPLACE_COMPONENT_NAME)/lib$(COMPONENT_NAME_REPLACE_COMPONENT_NAME).a
	@cp $(LIB_DIR_TEMP_REPLACE_COMPONENT_NAME)/lib$(COMPONENT_NAME_REPLACE_COMPONENT_NAME).a $(LIB_DIR_REPLACE_COMPONENT_NAME)
endif

$(C_OBJ_REPLACE_COMPONENT_NAME): $(OUTPUT_DIR)/%.obj : $(SDK_ROOT)/%
	@echo Building $<
	@mkdir -p $(dir $@)
	@${CCACHE} $(CC) -c $(INCLUDES_REPLACE_COMPONENT_NAME) $(DEFINES_REPLACE_COMPONENT_NAME) $(CCFLAGS_REPLACE_COMPONENT_NAME) $< -o $@;

$(CPP_OBJ_REPLACE_COMPONENT_NAME): $(OUTPUT_DIR)/%.obj : $(SDK_ROOT)/%
	@echo Building $<
	@mkdir -p $(dir $@)
	@${CCACHE} $(CXX) -c $(INCLUDES_REPLACE_COMPONENT_NAME) $(DEFINES_REPLACE_COMPONENT_NAME) $(CCFLAGS_REPLACE_COMPONENT_NAME) $< -o $@;

$(s_OBJ_REPLACE_COMPONENT_NAME): $(OUTPUT_DIR)/%.obj : $(SDK_ROOT)/%
	@echo Building $<
	@mkdir -p $(dir $@)
	@$(AS) -c $(INCLUDES_REPLACE_COMPONENT_NAME) $(DEFINES_REPLACE_COMPONENT_NAME) $(CCFLAGS_REPLACE_COMPONENT_NAME) $< -o $@;

$(S_OBJ_REPLACE_COMPONENT_NAME): $(OUTPUT_DIR)/%.obj : $(SDK_ROOT)/%
	@echo Building $<
	@mkdir -p $(dir $@)
	@$(AS) -c $(INCLUDES_REPLACE_COMPONENT_NAME) $(DEFINES_REPLACE_COMPONENT_NAME) $(CCFLAGS_REPLACE_COMPONENT_NAME) $< -o $@;

HSO_DB_$(COMPONENT_NAME_REPLACE_COMPONENT_NAME):
	@echo "skip building $(COMPONENT_NAME_REPLACE_COMPONENT_NAME) HSO DB"

include ./toolchains.make
