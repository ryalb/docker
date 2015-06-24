echo -e "\n##############################################"
echo -e "\n# Setup Doppler..."
echo -e "\n##############################################"

mkdir -p /var/www/doppler/download
mkdir -p /var/www/doppler/temp

chmod 777 /var/www/doppler/download
chmod 777 /var/www/doppler/temp

rm -rf /doppler/AITKeynoteBuilder/download
rm -rf /doppler/AITReportBuilder/Server/temp

ln -s /var/www/doppler/download /doppler/AITKeynoteBuilder/
ln -s /var/www/doppler/temp /doppler/AITReportBuilder/Server/
