¼�ṹ����
-ROOT
---|- azure-c-shared-utility
---|- azure-umqtt-c
---|- iothub_client
---|- serializer
---|- sample
------|- Linux2
------|- openssl

��Linux2��ִ��make


�м����ļ���Ҫ�޸�:
1. azure-c-shared-utility\src\tlsio_openssl.c   444��
�޸�ΪSSL_VERIFY_NONE, ����Ƕ��ʽ������û��������, ������ʱ�ȷ�����֤������, �����һ����������.
SSL_CTX_set_verify(tlsInstance->ssl_context, SSL_VERIFY_NONE, NULL);

2. serializer\samples\simplesample_mqtt\simplesample_mqtt.c
���Ӵ��޸�һ��
static const char* connectionString = "HostName=longfor-IoTDemo.azure-devices.net;DeviceId=LongforProxy-1;SharedAccessKey=SxPcn9T1KWeWwg+0QWJSJdA2rPDGPaHf75wPrprGEEc=";

3. serializer\inc\agenttypesystem.h
�ṹ���һ���������ǵı���������
typedef struct AGENT_DATA_TYPE_TAG
��
��
}AGENT_DATA_TYPE;
643�����ҵĵط�ɾ��AGENT_DATA_TYPE

4. iothub_client\samples\iothub_client_sample_mqtt\linux\main.c
��������Makefile��û��include
�����޸�һ�����·��#include "../iothub_client_sample_mqtt.h"


ʱ������,�ĵ�������.�һ�ȫ��֧�ֵ�,��ʱ���ҵ绰.
