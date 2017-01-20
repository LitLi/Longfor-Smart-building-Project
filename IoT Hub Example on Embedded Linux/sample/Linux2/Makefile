TARGETNAME := sample_enno
#TARGETTYPE can be APP, STATIC or SHARED
TARGETTYPE := APP

to_lowercase = $(subst A,a,$(subst B,b,$(subst C,c,$(subst D,d,$(subst E,e,$(subst F,f,$(subst G,g,$(subst H,h,$(subst I,i,$(subst J,j,$(subst K,k,$(subst L,l,$(subst M,m,$(subst N,n,$(subst O,o,$(subst P,p,$(subst Q,q,$(subst R,r,$(subst S,s,$(subst T,t,$(subst U,u,$(subst V,v,$(subst W,w,$(subst X,x,$(subst Y,y,$(subst Z,z,$1))))))))))))))))))))))))))

CONFIG ?= DEBUG

CONFIGURATION_FLAGS_FILE := $(call to_lowercase,$(CONFIG)).mak

include $(CONFIGURATION_FLAGS_FILE)
include $(ADDITIONAL_MAKE_FILES)

ifeq ($(BINARYDIR),)
error:
	$(error Invalid configuration, please check your inputs)
endif

SOURCEFILES := ../../azure-c-shared-utility/adapters/agenttime.c ../../azure-c-shared-utility/adapters/lock_pthreads.c ../../azure-c-shared-utility/adapters/platform_linux.c ../../azure-c-shared-utility/adapters/socketio_berkeley.c ../../azure-c-shared-utility/adapters/threadapi_pthreads.c ../../azure-c-shared-utility/adapters/tickcounter_linux.c ../../azure-c-shared-utility/src/base64.c ../../azure-c-shared-utility/src/buffer.c ../../azure-c-shared-utility/src/crt_abstractions.c ../../azure-c-shared-utility/src/doublylinkedlist.c ../../azure-c-shared-utility/src/gballoc.c ../../azure-c-shared-utility/src/gb_stdio.c ../../azure-c-shared-utility/src/gb_time.c ../../azure-c-shared-utility/src/hmac.c ../../azure-c-shared-utility/src/hmacsha256.c ../../azure-c-shared-utility/src/list.c ../../azure-c-shared-utility/src/map.c ../../azure-c-shared-utility/src/sastoken.c ../../azure-c-shared-utility/src/sha1.c ../../azure-c-shared-utility/src/sha224.c ../../azure-c-shared-utility/src/sha384-512.c ../../azure-c-shared-utility/src/strings.c ../../azure-c-shared-utility/src/string_tokenizer.c ../../azure-c-shared-utility/src/tlsio_openssl.c ../../azure-c-shared-utility/src/urlencode.c ../../azure-c-shared-utility/src/usha.c ../../azure-c-shared-utility/src/vector.c ../../azure-c-shared-utility/src/xio.c ../../azure-umqtt-c/src/mqtt_client.c ../../azure-umqtt-c/src/mqtt_codec.c ../../azure-umqtt-c/src/mqtt_message.c ../../certs/certs.c ../../iothub_client/samples/iothub_client_sample_mqtt/iothub_client_sample_mqtt.c ../../iothub_client/samples/iothub_client_sample_mqtt/linux/main.c ../../iothub_client/src/iothubtransport.c ../../iothub_client/src/iothubtransportmqtt.c ../../iothub_client/src/iothub_client.c ../../iothub_client/src/iothub_client_ll.c ../../iothub_client/src/iothub_message.c ../../iothub_client/src/version.c ../../serializer/src/agenttypesystem.c ../../serializer/src/codefirst.c ../../serializer/src/commanddecoder.c ../../serializer/src/datamarshaller.c ../../serializer/src/datapublisher.c ../../serializer/src/dataserializer.c ../../serializer/src/iotdevice.c ../../serializer/src/jsondecoder.c ../../serializer/src/jsonencoder.c ../../serializer/src/multitree.c ../../serializer/src/schema.c ../../serializer/src/schemalib.c ../../serializer/src/schemaserializer.c
EXTERNAL_LIBS := 
EXTERNAL_LIBS_COPIED := $(foreach lib, $(EXTERNAL_LIBS),$(BINARYDIR)/$(notdir $(lib)))

CFLAGS += $(COMMONFLAGS)
CXXFLAGS += $(COMMONFLAGS)
ASFLAGS += $(COMMONFLAGS)
LDFLAGS += $(COMMONFLAGS)

CFLAGS += $(addprefix -I,$(INCLUDE_DIRS))
CXXFLAGS += $(addprefix -I,$(INCLUDE_DIRS))

CFLAGS += $(addprefix -D,$(PREPROCESSOR_MACROS))
CXXFLAGS += $(addprefix -D,$(PREPROCESSOR_MACROS))
ASFLAGS += $(addprefix -D,$(PREPROCESSOR_MACROS))

CXXFLAGS += $(addprefix -framework ,$(MACOS_FRAMEWORKS))
CFLAGS += $(addprefix -framework ,$(MACOS_FRAMEWORKS))
LDFLAGS += $(addprefix -framework ,$(MACOS_FRAMEWORKS))

LDFLAGS += $(addprefix -L,$(LIBRARY_DIRS))

ifeq ($(GENERATE_MAP_FILE),1)
LDFLAGS += -Wl,-Map=$(BINARYDIR)/$(basename $(TARGETNAME)).map
endif

LIBRARY_LDFLAGS = $(addprefix -l,$(LIBRARY_NAMES))

ifeq ($(IS_LINUX_PROJECT),1)
	RPATH_PREFIX := -Wl,--rpath='$$ORIGIN/../
	LIBRARY_LDFLAGS += $(EXTERNAL_LIBS)
	LIBRARY_LDFLAGS += -Wl,--rpath='$$ORIGIN'
	LIBRARY_LDFLAGS += $(addsuffix ',$(addprefix $(RPATH_PREFIX),$(dir $(EXTERNAL_LIBS))))
	
	ifeq ($(TARGETTYPE),SHARED)
		CFLAGS += -fPIC
		CXXFLAGS += -fPIC
		ASFLAGS += -fPIC
		LIBRARY_LDFLAGS += -Wl,-soname,$(TARGETNAME)
	endif
	
	ifneq ($(LINUX_PACKAGES),)
		PACKAGE_CFLAGS := $(foreach pkg,$(LINUX_PACKAGES),$(shell pkg-config --cflags $(pkg)))
		PACKAGE_LDFLAGS := $(foreach pkg,$(LINUX_PACKAGES),$(shell pkg-config --libs $(pkg)))
		CFLAGS += $(PACKAGE_CFLAGS)
		CXXFLAGS += $(PACKAGE_CFLAGS)
		LIBRARY_LDFLAGS += $(PACKAGE_LDFLAGS)
	endif	
else
	LIBRARY_LDFLAGS += $(EXTERNAL_LIBS)
endif

LIBRARY_LDFLAGS += $(ADDITIONAL_LINKER_INPUTS)

all_make_files := $(firstword $(MAKEFILE_LIST)) $(CONFIGURATION_FLAGS_FILE) $(ADDITIONAL_MAKE_FILES)

ifeq ($(STARTUPFILES),)
	all_source_files := $(SOURCEFILES)
else
	all_source_files := $(STARTUPFILES) $(filter-out $(STARTUPFILES),$(SOURCEFILES))
endif

source_obj1 := $(all_source_files:.cpp=.o)
source_obj2 := $(source_obj1:.c=.o)
source_obj3 := $(source_obj2:.s=.o)
source_obj4 := $(source_obj3:.S=.o)
source_obj5 := $(source_obj4:.cc=.o)
source_objs := $(source_obj5:.cxx=.o)

all_objs := $(addprefix $(BINARYDIR)/, $(notdir $(source_objs)))

PRIMARY_OUTPUTS :=

ifeq ($(GENERATE_BIN_FILE),1)
PRIMARY_OUTPUTS += $(BINARYDIR)/$(basename $(TARGETNAME)).bin
endif

ifeq ($(GENERATE_IHEX_FILE),1)
PRIMARY_OUTPUTS += $(BINARYDIR)/$(basename $(TARGETNAME)).ihex
endif

ifeq ($(PRIMARY_OUTPUTS),)
PRIMARY_OUTPUTS := $(BINARYDIR)/$(TARGETNAME)
endif

all: $(PRIMARY_OUTPUTS)

$(BINARYDIR)/$(basename $(TARGETNAME)).bin: $(BINARYDIR)/$(TARGETNAME)
	$(OBJCOPY) -O binary $< $@

$(BINARYDIR)/$(basename $(TARGETNAME)).ihex: $(BINARYDIR)/$(TARGETNAME)
	$(OBJCOPY) -O ihex $< $@

ifeq ($(TARGETTYPE),APP)
$(BINARYDIR)/$(TARGETNAME): $(all_objs) $(EXTERNAL_LIBS)
	$(LD) -o $@ $(LDFLAGS) $(START_GROUP) $(all_objs) $(LIBRARY_LDFLAGS) $(END_GROUP)
endif

ifeq ($(TARGETTYPE),SHARED)
$(BINARYDIR)/$(TARGETNAME): $(all_objs) $(EXTERNAL_LIBS)
	$(LD) -shared -o $@ $(LDFLAGS) $(START_GROUP) $(all_objs) $(LIBRARY_LDFLAGS) $(END_GROUP)
endif
	
ifeq ($(TARGETTYPE),STATIC)
$(BINARYDIR)/$(TARGETNAME): $(all_objs)
	$(AR) -r $@ $^
endif

-include $(all_objs:.o=.dep)

clean:
ifeq ($(USE_DEL_TO_CLEAN),1)
	del /S /Q $(BINARYDIR)
else
	rm -rf $(BINARYDIR)
endif

$(BINARYDIR):
	mkdir $(BINARYDIR)

$(BINARYDIR)/%.o : %.cpp $(all_make_files) |$(BINARYDIR)
	$(CXX) $(CXXFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)

$(BINARYDIR)/%.o : %.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)

$(BINARYDIR)/%.o : %.S $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) $(ASFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)

$(BINARYDIR)/%.o : %.s $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) $(ASFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)

$(BINARYDIR)/%.o : %.cc $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) $(CXXFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)

$(BINARYDIR)/%.o : %.cxx $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) $(CXXFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)



$(BINARYDIR)/agenttime.o : ../../azure-c-shared-utility/adapters/agenttime.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/lock_pthreads.o : ../../azure-c-shared-utility/adapters/lock_pthreads.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/platform_linux.o : ../../azure-c-shared-utility/adapters/platform_linux.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/socketio_berkeley.o : ../../azure-c-shared-utility/adapters/socketio_berkeley.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/threadapi_pthreads.o : ../../azure-c-shared-utility/adapters/threadapi_pthreads.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/tickcounter_linux.o : ../../azure-c-shared-utility/adapters/tickcounter_linux.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/base64.o : ../../azure-c-shared-utility/src/base64.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/buffer.o : ../../azure-c-shared-utility/src/buffer.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/crt_abstractions.o : ../../azure-c-shared-utility/src/crt_abstractions.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/doublylinkedlist.o : ../../azure-c-shared-utility/src/doublylinkedlist.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/gballoc.o : ../../azure-c-shared-utility/src/gballoc.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/gb_stdio.o : ../../azure-c-shared-utility/src/gb_stdio.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/gb_time.o : ../../azure-c-shared-utility/src/gb_time.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/hmac.o : ../../azure-c-shared-utility/src/hmac.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/hmacsha256.o : ../../azure-c-shared-utility/src/hmacsha256.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/list.o : ../../azure-c-shared-utility/src/list.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/map.o : ../../azure-c-shared-utility/src/map.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/sastoken.o : ../../azure-c-shared-utility/src/sastoken.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/sha1.o : ../../azure-c-shared-utility/src/sha1.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/sha224.o : ../../azure-c-shared-utility/src/sha224.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/sha384-512.o : ../../azure-c-shared-utility/src/sha384-512.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/strings.o : ../../azure-c-shared-utility/src/strings.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/string_tokenizer.o : ../../azure-c-shared-utility/src/string_tokenizer.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/tlsio_openssl.o : ../../azure-c-shared-utility/src/tlsio_openssl.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/urlencode.o : ../../azure-c-shared-utility/src/urlencode.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/usha.o : ../../azure-c-shared-utility/src/usha.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/vector.o : ../../azure-c-shared-utility/src/vector.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/xio.o : ../../azure-c-shared-utility/src/xio.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/mqtt_client.o : ../../azure-umqtt-c/src/mqtt_client.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/mqtt_codec.o : ../../azure-umqtt-c/src/mqtt_codec.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/mqtt_message.o : ../../azure-umqtt-c/src/mqtt_message.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/certs.o : ../../certs/certs.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/iothub_client_sample_mqtt.o : ../../iothub_client/samples/iothub_client_sample_mqtt/iothub_client_sample_mqtt.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/main.o : ../../iothub_client/samples/iothub_client_sample_mqtt/linux/main.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/iothubtransport.o : ../../iothub_client/src/iothubtransport.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/iothubtransportmqtt.o : ../../iothub_client/src/iothubtransportmqtt.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/iothub_client.o : ../../iothub_client/src/iothub_client.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/iothub_client_ll.o : ../../iothub_client/src/iothub_client_ll.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/iothub_message.o : ../../iothub_client/src/iothub_message.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/version.o : ../../iothub_client/src/version.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/agenttypesystem.o : ../../serializer/src/agenttypesystem.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/codefirst.o : ../../serializer/src/codefirst.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/commanddecoder.o : ../../serializer/src/commanddecoder.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/datamarshaller.o : ../../serializer/src/datamarshaller.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/datapublisher.o : ../../serializer/src/datapublisher.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/dataserializer.o : ../../serializer/src/dataserializer.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/iotdevice.o : ../../serializer/src/iotdevice.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/jsondecoder.o : ../../serializer/src/jsondecoder.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/jsonencoder.o : ../../serializer/src/jsonencoder.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/multitree.o : ../../serializer/src/multitree.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/schema.o : ../../serializer/src/schema.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/schemalib.o : ../../serializer/src/schemalib.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/schemaserializer.o : ../../serializer/src/schemaserializer.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)

