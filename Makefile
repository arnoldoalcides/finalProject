#Cross compilancion del Kernel
arm-2009q1: arm-2009q1-203-arm-none-linux-gnueabi-i686-pc-linux-gnu.tar.bz2
	    sudo cp arm-2009q1-203-arm-none-linux-gnueabi-i686-pc-linux-gnu.tar.bz2 /opt
	    cd /../opt
            sudo tar jxf arm-2009q1-203-arm-none-linux-gnueabi-i686-pc-linux-gnu.tar.bz2
        

linux-2.6.29: linux-2.6.29.tar.gz
	      tar zxf linux-2.6.29.tar.gz
	      cd linux-2.6.29/patches
	      quilt pop -a
	      quilt pop -f
	      quilt push -a
	      cd ..
              echo $PATH
	      PATH=/opt/arm-2009q1/bin/:$PATH
              make ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi-
	      make ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi- uImage

# Creacion del root file system 

busybox-1.19.0: busybox-1.19.0.tar.bz2
		tar jxf busybox-1.19.0.tar.bz2 
		cd busybox-1.19.0/
		CFLAGS=-march=armv4t make ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi- menuconfig
		CFLAGS=-march=armv4t make ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi-
		make install
          	make ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi- install
		cd _install/
		find . | cpio -o --format=newc > ../rootfs.img
		cd ..
		gzip -c rootfs.img > rootfs.img.gz
		cd _install/
		sudo mkdir /dev		
		sudo mkdir /etc
		sudo mkdir /proc
		sudo mkdir /tmp
		sudo mkdir /var
		sudo mkdir /mnt
		cd dev/
		mknod tty c 5 0
		mknod console c 5 1
		mknod tty0 c 4 0
		mknod ttyS0 c 4 64
		mknod ttyS0 c 4 64
		mknod ram0 b 1 0
		mknod null c 1 3
		cd ..
		cd /_install
		sudo mkdir /home/root-fs		
		sudo cp -a ../_install/* /home/root-fs/





