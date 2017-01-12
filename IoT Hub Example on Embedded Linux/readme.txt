录结构如下
-ROOT
---|- azure-c-shared-utility
---|- azure-umqtt-c
---|- iothub_client
---|- serializer
---|- sample
------|- Linux2
------|- openssl

在Linux2中执行make


有几个文件需要修改:
1. azure-c-shared-utility\src\tlsio_openssl.c   444行
修改为SSL_VERIFY_NONE, 由于嵌入式环境下没有信任链, 我们暂时先放弃验证服务器, 后续我会解决这个问题.
SSL_CTX_set_verify(tlsInstance->ssl_context, SSL_VERIFY_NONE, NULL);

2. serializer\samples\simplesample_mqtt\simplesample_mqtt.c
连接串修改一下
static const char* connectionString = "HostName=longfor-IoTDemo.azure-devices.net;DeviceId=LongforProxy-1;SharedAccessKey=SxPcn9T1KWeWwg+0QWJSJdA2rPDGPaHf75wPrprGEEc=";

3. serializer\inc\agenttypesystem.h
结构体的一个定义咱们的编译器不认
typedef struct AGENT_DATA_TYPE_TAG
…
…
}AGENT_DATA_TYPE;
643行左右的地方删除AGENT_DATA_TYPE

4. iothub_client\samples\iothub_client_sample_mqtt\linux\main.c
由于我在Makefile中没有include
所以修改一下相对路径#include "../iothub_client_sample_mqtt.h"


时间有限,文档不完善.我会全力支持的,随时打我电话.
