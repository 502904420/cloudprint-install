#!/bin/sh

#files
FILE_PATH=$(pwd)
PRINT_PLUGINS=${FILE_PATH}/print-plugin.tar.gz
HP_PLUGINS=${FILE_PATH}/hp_plugin_files.tar.gz
PRINT_BINS=${FILE_PATH}/print_bin.tar.gz
SYSTEM_FONTS=${FILE_PATH}/system-fonts.tar.gz
STATUS_FILE=${FILE_PATH}/install.status
PKG_CONFIG=/usr/local/lib/pkgconfig/

installed_status=0
getStatus() {
  local param1=$1
  var=$(cat ${STATUS_FILE} | grep ${param1} | awk -F ' ' '{print $2}')
  echo ${var}
}
setStatus() {
  local status=$(getStatus $1)
  if [ ${status} -eq 0 ]; then
    sed -i "/$1/s/0/1/g" ${STATUS_FILE}
  fi
}

#减压缩文件
installed_status=$(getStatus plugins)
if [ ${installed_status} -ne 1 ]; then
    if [ ! -e ${PRINT_PLUGINS} ]; then
        echo "Cloudprint plugin files not exists...."
        exit -1
    fi
    sudo tar -zvxf ${PRINT_PLUGINS}
    if [ $? -ne 0 ]; then
        echo "tar -zvxf ${PRINT_PLUGINS} failed"
        exit -1
    fi
    setStatus plugins
else
    echo "plugins alread released"
fi

#install plugins for cups
echo "To install cups ..."
installed_status=$(getStatus libusb)
if [ ${installed_status} -ne 1 ]; then
    echo "To install libusb-1.0.20 ..."
    cd ${FILE_PATH}/print-plugin/libusb-1.0.20/
    sudo ./configure --disable-udev && sudo make && sudo make install
    if [ $? -ne 0 ]; then
      echo "libusb FAILED"
      exit -1
    fi
    setStatus libusb
    echo "OK"
else
    echo "libusb already installed"
fi

installed_status=$(getStatus zlib)
if [ ${installed_status} -ne 1 ]; then
    echo "To install zlib-1.2.8 ..."
    cd ${FILE_PATH}/print-plugin/zlib-1.2.8/
    sudo ./configure && sudo make && sudo make install
    if [ $? -ne 0 ]; then
      echo "zlib FAILED"
      exit -1
    fi
    setStatus zlib
    echo "OK"
else
    echo "zlib already installed"
fi

installed_status=$(getStatus libcups)
if [ ${installed_status} -ne 1 ]; then
    cd ${FILE_PATH}/print-plugin/cups-2.2.0/
    sudo ./configure && sudo make && sudo make install
    if [ $? -ne 0 ]; then
      echo "cups FAILED"
      exit -1
    fi
    setStatus libcups
    echo "OK"
else
    echo "cups already installed"
fi
#install plugins for cups-filters
echo "To install cpus-filter ..."
installed_status=$(getStatus ghostscript)
if [ ${installed_status} -ne 1 ]; then
    echo "To install ghostscript-9.20 ..."
    cd ${FILE_PATH}/print-plugin/ghostscript-9.20/
    sudo ./configure && sudo make && sudo make install
    if [ $? -ne 0 ]; then
      echo "ghostscript FAILED"
      exit -1
    fi
    setStatus ghostscript
    echo "OK"
else
    echo "ghostscript already installed"
fi

installed_status=$(getStatus libffi)
if [ ${installed_status} -ne 1 ]; then
    echo "To install libffi-3.1 ..."
    cd ${FILE_PATH}/print-plugin/libffi-3.1/
    sudo ./configure && sudo make && sudo make install
    if [ $? -ne 0 ]; then
      echo "libffi FAILED"
      exit -1
    fi
    setStatus libffi
    echo "OK"
else
    echo "libffi already installed"
fi

installed_status=$(getStatus glib)
if [ ${installed_status} -ne 1 ]; then
    echo "To install glib-2.32.2 ..."
    cd ${FILE_PATH}/print-plugin/glib-2.32.2/
    sudo ./configure PKG_CONFIG_PATH=${PKG_CONFIG} && sudo make && sudo make install
    if [ $? -ne 0 ]; then
      echo "glib FAILED"
      exit -1
    fi
    setStatus glib
    echo "OK"
else
    echo "glib already installed"
fi

installed_status=$(getStatus lcms2)
if [ ${installed_status} -ne 1 ]; then
    echo "To install lcms2-2.9 ..."
    cd ${FILE_PATH}/print-plugin/lcms2-2.9/
    sudo ./configure && sudo make && sudo make install
    if [ $? -ne 0 ]; then
      echo "lcms FAILED"
      exit -1
    fi
    setStatus lcms2
    echo "OK"
else
    echo "lcms2 already installed"
fi

installed_status=$(getStatus freetype)
if [ ${installed_status} -ne 1 ]; then
    echo "To install freetype-2.7 ..."
    cd ${FILE_PATH}/print-plugin/freetype-2.7/
    sudo ./configure && sudo make && sudo make install
    if [ $? -ne 0 ]; then
      echo "freetype FAILED"
      exit -1
    fi
    setStatus freetype
    echo "OK"
else
    echo "freetype already installed"
fi

installed_status=$(getStatus libxml2)
if [ ${installed_status} -ne 1 ]; then
    echo "To install libxml2-2.7.3 ..."
    cd ${FILE_PATH}/print-plugin/libxml2-2.7.3/
    sudo ./configure && sudo make && sudo make install
    if [ $? -ne 0 ]; then
      echo "libxml FAILED"
      exit -1
    fi
    setStatus libxml2
    echo "OK"
else
   echo "libxml2 already installed"
fi

installed_status=$(getStatus fontconfig)
if [ ${installed_status} -ne 1 ]; then
    echo "To install fontconfig-2.12.1 ..."
    cd ${FILE_PATH}/print-plugin/fontconfig-2.12.1/
    sudo ./configure PKG_CONFIG_PATH=${PKG_CONFIG} --enable-libxml2 && sudo make && sudo make install
    if [ $? -ne 0 ]; then
      echo "fontconfig FAILED"
      exit -1
    fi
    setStatus fontconfig
    echo "OK"
else
    echo "fontconfig already installed"
fi

installed_status=$(getStatus pcre)
if [ ${installed_status} -ne 1 ]; then
    echo "To install pcre-8.39 ..."
    cd ${FILE_PATH}/print-plugin/pcre-8.39/
    sudo ./configure && sudo make && sudo make install
    if [ $? -ne 0 ]; then
      echo "pcre FAILED"
      exit -1
    fi
    setStatus pcre
    echo "OK"
else
    echo "pcre already installed"
fi

installed_status=$(getStatus libqpdf)
if [ ${installed_status} -ne 1 ]; then
    echo "To install libqpdf ..."
    cd ${FILE_PATH}/print-plugin/qpdf-master/
    sudo ./configure && sudo make && sudo make install
    if [ $? -ne 0 ]; then
      echo "libqpdf FAILED"
      exit -1
    fi
    setStatus libqpdf
    echo "OK"
else
    echo "libqpdf already installed"
fi

installed_status=$(getStatus ijs)
if [ ${installed_status} -ne 1 ]; then
    echo "To install ijs ..."
    cd ${FILE_PATH}/print-plugin/ijs-0.35/
    sudo ./configure && sudo make && sudo make install
    if [ $? -ne 0 ]; then
      echo "ijs FAILED"
      exit -1
    fi
    setStatus ijs
    echo "OK"
else
    echo "ijs already installed"
fi

installed_status=$(getStatus cups-filter)
if [ ${installed_status} -ne 1 ]; then
    cd ${FILE_PATH}/print-plugin/cups-filters-1-20160918/
    sudo ./config.sh && sudo make && sudo make install
    if [ $? -ne 0 ]; then
      echo "cups-filter FAILED"
      exit -1
    fi
    setStatus cups-filter
    echo "OK"
else
    echo "cups-filter already installed"
fi


echo "To install hplip plugins ..."
echo "To install libjpeg ..."
installed_status=$(getStatus nasm)
if [ ${installed_status} -ne 1 ]; then
    echo "To install nasm ..."
    cd ${FILE_PATH}/print-plugin/nasm-2.14rc14/
    sudo ./configure --prefix=/usr/local && sudo make && sudo make install
    if [ $? -ne 0 ]; then
      echo "nasm FAILED"
      exit -1
    fi
    setStatus nasm
    echo "OK"
else
    echo "nasm already installed"
fi

installed_status=$(getStatus libjpeg)
if [ ${installed_status} -ne 1 ]; then
    cd ${FILE_PATH}/print-plugin/libjpeg-turbo-1.5.3/
    sudo ./configure --prefix=/usr/local && sudo make && sudo make install
    if [ $? -ne 0 ]; then
      echo "libjpeg FAILED"
      exit -1
    fi
    setStatus libjpeg
    echo "OK"
else
    echo "libjpeg already installed"
fi
#修改过源码
installed_status=$(getStatus hplip)
if [ ${installed_status} -ne 1 ]; then
    cd ${FILE_PATH}/print-plugin/hplip-3.16.8/
    sudo sh config.sh && sudo make && sudo make install
    if [ $? -ne 0 ]; then
      echo "hplip FAILED"
      exit -1
    fi
    setStatus hplip
    echo "OK"
else
    echo "hplip already installed"
fi

installed_status=$(getStatus hpfiles) 
if [ ${installed_status} -ne 1 ]; then
	if [ ! -e $HP_PLUGINS ]; then
        	echo "Cloudprint hp plugin files not exists...."
        	exit -2
	fi
	sudo tar -zvxf $HP_PLUGINS
	sudo cp -rf usr/local/share/hplip/ /usr/local/share/
	sudo cp -rf var/lib/hp /var/lib/
	if [ ! -d /usr/local/share/hplip ]; then
    		echo "hplip files generates failed"
    		exit -3
	fi
	if [ ! -d /var/lib/hp ]; then
    		echo "hplip state file generates failed"
    		exit -4
	fi
	setStatus hpfiles
	echo "OK"
else
	echo "hp files already installed"
fi

echo "Install CANON printer plugins ..."
installed_status=$(getStatus libpopt)
if [ ${installed_status} -ne 1 ]; then
    echo "Install libpopt ..."
    cd ${FILE_PATH}/print-plugin/popt-1.16/
    sudo ./configure && sudo make && sudo make install
    if [ $? -ne 0 ]; then
      echo "popt FAILED"
      exit -1
    fi
    setStatus libpopt
    echo "OK"
else
    echo "libpopt already installed"
fi

installed_status=$(getStatus libtiff)
if [ ${installed_status} -ne 1 ]; then
    echo "Install libtiff ..."
    cd ${FILE_PATH}/print-plugin/tiff-4.0.9/
    sudo ./configure PKG_CONFIG_PATH=${PKG_CONFIG} && sudo make && sudo make install
    sudo cp /usr/local/lib/libtiff.so* /usr/lib64/
    if [ $? -ne 0 ]; then
      echo "libtiff FAILED"
      exit -1
    fi
    setStatus libtiff
    echo "OK"
else
    echo "libtiff already installed"
fi

installed_status=$(getStatus libpng)
if [ ${installed_status} -ne 1 ]; then
    echo "Install libpng ..."
    cd ${FILE_PATH}/print-plugin/libpng-1.0.7/
    sudo ./configure && sudo make && sudo make install
    sudo cp /usr/local/lib/libpng.so* /usr/lib64/
    if [ $? -ne 0 ]; then
      echo "libpng FAILED"
      exit -1
    fi
    setStatus libpng
    echo "OK"
else
    echo "libpng already installed"
fi

installed_status=$(getStatus canon-filter)
if [ ${installed_status} -ne 1 ]; then
    cd ${FILE_PATH}/print-plugin/canon-filter/
    sudo make && sudo make install
    sudo mkdir /usr/lib/bjlib
    sudo cp 370/database/* /usr/lib/bjlib/
    sudo cp 370/libs_bin64/* /usr/lib64/
    sudo cp cnijfilter/src/cif /usr/local/bin/cifmp280
    if [ $? -ne 0 ]; then
      echo "Canon files generate FAILED"
      exit -1
    fi
    setStatus canon-filter
    echo "OK"
else
    echo "canon-filter already installed"
fi

#Generate tools of "pdftops"
installed_status=$(getStatus poppler)
if [ ${installed_status} -ne 1 ]; then
    echo "Generate pdftops ..."
    cd ${FILE_PATH}/print-plugin/poppler-0.48.0/
    sudo ./configure PKG_CONFIG_PATH=${PKG_CONFIG} && make && make install
    sudo cp ./utils/pdftops /usr/bin/
    if [ $? -ne 0 ]; then
      echo "poppler FAILED"
      exit -1
    fi
    setStatus poppler
    echo "OK"
else
    echo "poppler already installed"
fi

echo "Copy poppler fonts to system path ..."
cd ${FILE_PATH}/print-plugin/poppler-fonts/
sudo cp -rf poppler /usr/local/share/
if [ $? -ne 0 ]; then
  echo "poppler fonts generate FAILED"
  exit -1
fi
echo "OK"

echo "Copy system fonts ..."
sudo tar -zvxf ${SYSTEM_FONTS} -C /usr/share/
if [ $? -ne 0 ]; then
  echo "system fonts generate FAILED"
  exit -1
fi
echo "OK"

echo "Generate bin files..."
if [ ! -e ${PRINT_BINS} ]; then
        echo "Cloudprint print executable files not exists...."
        exit -3
fi
sudo tar -zvxf ${PRINT_BINS} -C /opt/app/
if [ $? -ne 0 ]; then
  echo "print bins generate FAILED"
  exit -1
fi
echo "OK"
