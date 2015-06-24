BASHRC=/root/.bashrc
BASHALIASES=/root/.bash_aliases

#sed -i "/#force_color_prompt=yes/d" ${BASHRC}

echo "" >> ${BASHRC}
echo "force_color_prompt=yes" >> ${BASHRC}

echo "alias p='. ~/.profile'" >> ${BASHRC}
echo "alias aptg='sudo apt-get install'" >> ${BASHRC}
echo "alias apts='apt-cache search'" >> ${BASHRC}
echo "alias aptss='apt-cache show'" >> ${BASHRC}

#chown vagrant:vagrant ${BASHALIASES}

echo "10.0.2.2 doppler.db.local" >> /etc/hosts
