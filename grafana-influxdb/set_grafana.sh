#!/bin/bash
set -e

if [ -f /.grafana_configured ]; then
    echo "=> grafana has been configured!"
    exit 0
fi

echo "=> Configuring grafana"
sed -i -e "s/<--DATA_USER-->/${INFLUXDB_DATA_USER}/g" \
		-e "s/<--DATA_PW-->/${INFLUXDB_DATA_PW}/g" \
		-e "s/<--GRAFANA_USER-->/${INFLUXDB_GRAFANA_USER}/g" \
		-e "s/<--GRAFANA_PW-->/${INFLUXDB_GRAFANA_PW}/g" \
 		-e "s/<--CADVISOR_USER-->/${CADVISOR_USER}/g" \
		-e "s/<--CADVISOR_PW-->/${CADVISOR_PW}/g" /src/grafana/config.js

sed -i -e "s/<--INFLUXDB_ADDR-->/${INFLUXDB_ADDR}/g" /src/grafana/config.js

touch /.grafana_configured

echo "=> Grafana has been configured as follows:"
echo "   InfluxDB DB DATA NAME:  data"
echo "   InfluxDB USERNAME: ${INFLUXDB_DATA_USER}"
echo "   InfluxDB PASSWORD: ${INFLUXDB_DATA_PW}"
echo "   InfluxDB DB GRAFANA NAME:  grafana"
echo "   InfluxDB USERNAME: ${INFLUXDB_GRAFANA_USER}"
echo "   InfluxDB PASSWORD: ${INFLUXDB_GRAFANA_USER}"
echo "   InfluxDB DB CADVISOR NAME:  cadvisor"
echo "   InfluxDB USERNAME: ${CADVISOR_USER}"
echo "   InfluxDB PASSWORD: ${CADVISOR_USER}"
echo "   ** Please check your environment variables if you find something is misconfigured. **"
echo "=> Done!"
exit 0
