#! /bin/sh
#------pac-mv----
S_DIR=`pwd`
	
 
mv ghostscript-9.15-linux-x86_64.tgz ~/ffmpeg_sources
mv Image-ExifTool-10.28.tar.gz ~/ffmpeg_sources
mv gpac_extra_libs-0.5.0.zip ~/ffmpeg_sources
mv gpac-0.5.0.tar.gz ~/ffmpeg_sources
 
#-------------------yum pack-----------------------------

yum install gcc zlib* freeglut.x86_64  freeglut-devel.x86_64 perl-devel unzip -y
 
	


#----------------------------------------------------------------------------
#------ghostscript-9.15-linux-x86_64--------------
cd ~/ffmpeg_sources
tar xzvf ghostscript-9.15-linux-x86_64.tgz
cd /usr/bin/
mv gs gs--
ln -s /opt/ghostscript-9.15-linux-x86_64/gs-915-linux_x86_64 gs	
if [ $? != 0 ];then
	echo "ghostscript-9.15-linux-x86_64" >> $S_DIR/error
	exit 0
else
	echo "ghostscript-9.15-linux-x86_64成功" >> $S_DIR/log
fi
#----------------------------------------------------------------------------
#------ImageMagick-----------------------------------------------------------
cd ~/ffmpeg_sources
yum install ImageMagick
#----------------------------------------------------------------------------
#------Image-ExifTool-10.28-----------------------------------------------------------
cd ~/ffmpeg_sources
gzip -dc Image-ExifTool-10.28.tar.gz | tar -xf -
cd Image-ExifTool-10.28
perl Makefile.PL
make && make install -j4
if [ $? != 0 ];then
	echo "Image-ExifTool-10.28安装失败" >> $S_DIR/error
	exit 0
else
	echo "Image-ExifTool-10.28成功" >> $S_DIR/log
fi
#-----------yum install dcraw------------------------------------------------------
cd ~/ffmpeg_sources
yum install dcraw


#-----------------最后其他------------------------------------------------
cd ~/ffmpeg_sources
tar -zxvf gpac-0.5.0.tar.gz
unzip gpac_extra_libs-0.5.0.zip
mkdir /usr/local/src/gpac
mkdir /usr/local/src/gpac/extra_lib
cd gpac_extra_libs
cp -r * /usr/local/src/gpac/extra_lib
cd ..
cd gpac
chmod +x configure
./configure
make lib
make apps
make install lib
make install
if [ $? != 0 ];then
	echo "最后其他安装失败" >> $S_DIR/error
	exit 0
else
	echo "最后其他成功" >> $S_DIR/log
fi
cp bin/gcc/libgpac.so /usr/lib
#-----------------------------------------------------------------
